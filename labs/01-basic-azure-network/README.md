# Lab 01 — Basic Azure Network Security

> Status: 🔄 **In progress**  
> Region: **Belgium Central**

This lab moves from Azure theory into hands-on cloud networking and security.

The objective is to build a small segmented Azure network, validate private connectivity, deliberately break SSH access with a Network Security Group rule, troubleshoot the failure, and restore access using a more precise security policy.

---

## Objectives

- Create an Azure Virtual Network with multiple subnets
- Apply NSGs at subnet level
- Deploy a management VM and a private application VM
- Restrict management access from the internet
- Validate inter-subnet routing
- Use a jump host / SSH ProxyJump
- Create an intentional NSG failure
- Distinguish network failures from authentication failures
- Restore access with least-privilege rules
- Document security, cost, and troubleshooting decisions

---

## Architecture

```text
                         Internet
                            |
                 SSH from my public IP only
                            |
                            v
                    +----------------+
                    | vm-mgmt-001    |
                    | 10.10.10.4     |
                    | Ubuntu 24.04   |
                    +--------+-------+
                             |
                      snet-mgmt
                     10.10.10.0/24
                       nsg-mgmt
                             |
                    Azure VNet routing
                             |
                       nsg-app
                      snet-app
                     10.10.20.0/24
                             |
                    +--------+-------+
                    | vm-app-001     |
                    | 10.10.20.4     |
                    | Ubuntu 24.04   |
                    | No public IP   |
                    +----------------+
```

---

## Addressing Plan

| Resource | Address / CIDR |
|---|---|
| VNet | `10.10.0.0/16` |
| Management subnet | `10.10.10.0/24` |
| Application subnet | `10.10.20.0/24` |
| Management VM | `10.10.10.4` |
| Application VM | `10.10.20.4` |

Azure reserves addresses inside each subnet for platform use, so a /24 does not provide all 256 addresses to workloads.

---

## Azure Resources

| Resource | Name | Notes |
|---|---|---|
| Resource group | `rg-azlab-network-dev` | Lab resources |
| Virtual network | `vnet-azlab-dev-001` | `10.10.0.0/16` |
| Management subnet | `snet-mgmt` | `10.10.10.0/24` |
| Application subnet | `snet-app` | `10.10.20.0/24` |
| Management NSG | `nsg-mgmt` | Associated with `snet-mgmt` |
| Application NSG | `nsg-app` | Associated with `snet-app` |
| Management VM | `vm-mgmt-001` | Ubuntu 24.04, B-series |
| Application VM | `vm-app-001` | Ubuntu 24.04, private-only |

The VMs use subnet-level NSGs. I intentionally avoided adding a second NSG at NIC level so the first lab would have one clear security-policy layer to troubleshoot.

---

## Cost Controls

Cost controls were configured before deploying compute resources.

For the lab I selected low-cost burstable Linux VM sizes and avoided unnecessary premium services.

Operational rules for this lab:

- Use small B-series VMs
- Do not deploy paid DDoS protection just for testing
- Avoid Bastion until its value and cost are specifically being tested
- Deallocate VMs when they are not needed
- Remove orphaned public IPs and disks
- Delete disposable lab resources when testing is complete

No budget screenshot is included because it is operational hygiene rather than technical evidence.

---

# Phase 1 — Network Baseline

The initial VNet was created with two subnets:

```text
vnet-azlab-dev-001
10.10.0.0/16

├── snet-mgmt  10.10.10.0/24
└── snet-app   10.10.20.0/24
```

At the baseline stage there were:

- No custom route tables
- No custom NSG associations
- No application workloads

This created a clean state before security controls were introduced.

### Evidence — VNet and baseline subnets

![Azure VNet overview](./screenshots/01-vnet-overview-redacted.png)

![Baseline subnet configuration](./screenshots/02-subnets-baseline.png)

---

# Phase 2 — Subnet-Level NSGs

Two Network Security Groups were created:

```text
nsg-mgmt -> snet-mgmt
nsg-app  -> snet-app
```

Azure default NSG rules include:

### Inbound

| Priority | Rule | Action |
|---:|---|---|
| 65000 | AllowVNetInBound | Allow |
| 65001 | AllowAzureLoadBalancerInBound | Allow |
| 65500 | DenyAllInBound | Deny |

### Outbound

| Priority | Rule | Action |
|---:|---|---|
| 65000 | AllowVNetOutBound | Allow |
| 65001 | AllowInternetOutBound | Allow |
| 65500 | DenyAllOutBound | Deny |

A key lesson is that subnet segmentation by IP addressing does not automatically create security isolation. The default `AllowVNetInBound` rule permits VNet traffic unless a higher-priority custom rule overrides it.

NSGs are stateful, so return traffic for an allowed connection does not require a mirrored allow rule.

### Evidence — NSG association

![Subnets associated with NSGs](./screenshots/03-subnets-with-nsgs.png)

![Network security groups](./screenshots/04-nertwork-sec-groups.png)

---

# Phase 3 — Secure Management VM

`vm-mgmt-001` was deployed in `snet-mgmt`.

Configuration:

- Ubuntu Server 24.04 LTS
- B-series VM
- Private IP: `10.10.10.4`
- Temporary public IP for management
- Public inbound ports in the VM wizard: **None**
- NIC NSG: **None**
- Security enforced through `nsg-mgmt`

The VM having a public IP does **not** mean inbound traffic is automatically permitted. Public addressing and NSG filtering are separate controls.

A custom SSH rule was added manually:

```text
Priority: 100
Source: my current public IPv4 /32
Protocol: TCP
Destination port: 22
Action: Allow
```

All other unsolicited inbound internet traffic continues to fall through to `DenyAllInBound`.

### Evidence — Management VM and restricted SSH

![Management VM overview](./screenshots/05-vm-mgmt-001.png)

![Restricted SSH rule](./screenshots/06-nsg-restricted-ssh.png)

---

# Phase 4 — SSH Validation and Authentication Troubleshooting

My first SSH attempt reached the VM but failed with:

```text
Permission denied (publickey)
```

The cause was not Azure networking. I used the wrong Linux username.

Incorrect:

```bash
ssh -i ~/.ssh/key.pem user@<public-ip>
```

Correct:

```bash
ssh -i ~/.ssh/key.pem azureuser@<public-ip>
```

This was an important troubleshooting distinction:

| Symptom | Likely area |
|---|---|
| `Permission denied (publickey)` | SSH authentication / username / key |
| Connection timeout | NSG, route, reachability, VM state |
| Connection refused | Host reachable but service not listening / local firewall |

After correcting the username, SSH succeeded.

Validation commands:

```bash
hostname
ip addr
ip route
```

Observed on `vm-mgmt-001`:

- Hostname: `vm-mgmt-001`
- Private IP: `10.10.10.4/24`
- Default route through Azure virtual networking

### Evidence — Management VM network validation

![Management VM network validation](./screenshots/07-vm-mgmt-network-validation.png)

---

# Phase 5 — Private Application VM

`vm-app-001` was deployed in `snet-app`.

Configuration:

- Ubuntu Server 24.04 LTS
- B-series VM
- Private IP: `10.10.20.4`
- **No public IP**
- Public inbound ports: **None**
- NIC NSG: **None**
- Security enforced through `nsg-app`

This VM cannot be administered directly from the internet.

The management VM acts as the jump host.

### Evidence — Private application VM

![Private application VM](./screenshots/08-vm-app-001.png)

---

## SSH ProxyJump

The private key remains on my local machine. It is not copied to the management VM.

Example local SSH configuration:

```text
Host azure-mgmt
    HostName <mgmt-public-ip>
    User azureuser
    IdentityFile ~/.ssh/key.pem
    IdentitiesOnly yes

Host azure-app
    HostName 10.10.20.4
    User azureuser
    IdentityFile ~/.ssh/key.pem
    IdentitiesOnly yes
    ProxyJump azure-mgmt
```

Connection:

```bash
ssh azure-app
```

The private application VM became reachable through the jump host.

Validation on `vm-app-001`:

```bash
hostname
ip addr
ip route
who
echo $SSH_CONNECTION
```

The SSH connection information confirmed that the session reaching the application VM originated from:

```text
10.10.10.4 -> 10.10.20.4:22
```

This proves the management path is using private Azure networking after the initial connection to the jump host.

### Evidence — Private connectivity through ProxyJump

![Application VM private network validation](./screenshots/09-vm-app-network-validation.png)

---

# Phase 6 — Intentional NSG Failure

To test NSG rule evaluation, I created a custom inbound deny rule on `nsg-app`:

```text
Priority: 200
Source: 10.10.10.0/24
Protocol: TCP
Destination port: 22
Action: Deny
Name: Deny-SSH-From-Mgmt-Subnet
```

Because priority 200 is evaluated before the default `AllowVNetInBound` rule at priority 65000, SSH traffic from the management subnet was dropped.

Retesting:

```bash
ssh azure-app
```

The SSH session no longer completed and had to be interrupted.

This demonstrates that the failure was caused by network policy rather than SSH authentication.

### Evidence — Intentional failure

![NSG deny rule](./screenshots/10-nsg-app-deny-ssh.png)

![SSH blocked by NSG](./screenshots/11-ssh-blocked-by-nsg.png)

---

# Phase 7 — Restore Access with Least Privilege

The intended final policy is:

```text
100   Allow 10.10.10.4/32  -> TCP/22
200   Deny  10.10.10.0/24  -> TCP/22
65000 AllowVNetInBound
65500 DenyAllInBound
```

This allows SSH only from the designated management VM while denying SSH from other hosts in the management subnet.

> **Final verification required:** the current portal screenshot still shows the priority-100 allow rule sourced from `10.10.10.0/24`. Before marking the lab complete, this rule must be changed to `10.10.10.4/32` and the final NSG state captured again.

After the allow rule was introduced, SSH connectivity to `vm-app-001` was restored. The connection details confirmed the source was `10.10.10.4`.

### Evidence — Access restored

![Current controlled SSH policy](./screenshots/13-nsg-app-controlled-ssh.png)

![SSH restored after allow rule](./screenshots/12-ssh-restored-after-allow-rule.png)

> The NSG screenshot above is retained as evidence of the troubleshooting sequence. The priority-100 source still needs to be tightened from `10.10.10.0/24` to `10.10.10.4/32` before the least-privilege policy is considered final.

---

# Security Decisions

## DDoS protection

Advanced DDoS protection was reviewed but not enabled for this learning lab.

Reason:

- Azure already provides baseline infrastructure-level DDoS protection
- Advanced protection would add cost
- Generating attack traffic is not an appropriate validation method for this lab

## Bastion

Azure Bastion was reviewed but not deployed in this first lab because the goal was to understand the underlying public-IP, NSG, SSH, and jump-host behavior directly.

A future lab can compare this design with Bastion-based private administration.

## Public IP exposure

Only the management VM has temporary public addressing.

The application VM is private-only.

## SSH keys

- SSH public-key authentication is used
- Private keys remain on the local workstation
- Private keys are never committed to GitHub
- ProxyJump is used instead of copying private keys to the jump host

---

# Troubleshooting Lessons

## 1. Public IP is not the same as an open port

A VM can have a public IP while an NSG blocks all inbound traffic.

```text
Public IP = addressing / reachability
NSG       = allow / deny policy
```

## 2. Authentication failure vs network failure

`Permission denied (publickey)` showed that TCP/22 was reachable and the SSH server answered.

An SSH timeout after the NSG deny rule showed that traffic was being dropped before authentication.

## 3. Azure routes between subnets automatically

Both subnets are inside the same VNet, so Azure provides system routes between them by default.

Custom NSG rules were required to restrict the traffic.

## 4. Security rule priority matters

Lower numbers are evaluated first.

A custom priority-200 deny overrides the default priority-65000 VNet allow.

## 5. Private-only workloads can still be administered securely

The application VM does not need a public IP. It can be reached through a controlled management path.

---

# Evidence Captured

The following screenshots were captured during the lab and should be published only after sensitive values are redacted:

| Evidence | Purpose |
|---|---|
| `01-vnet-overview-redacted.png` | VNet overview |
| `02-subnets-baseline.png` | Baseline subnet configuration |
| `03-subnets-with-nsgs.png` | Two subnets with subnet-level NSGs |
| `04-nertwork-sec-groups.png` | NSG resources |
| `05-vm-mgmt-001.png` | Management VM configuration |
| `06-nsg-restricted-ssh.png` | SSH restricted to my source IP |
| `07-vm-mgmt-network-validation.png` | Management VM SSH and routes |
| `08-vm-app-001.png` | App VM with no public IP |
| `09-vm-app-network-validation.png` | Private jump-host connectivity |
| `10-nsg-app-deny-ssh.png` | Intentional deny rule |
| `11-ssh-blocked-by-nsg.png` | Failed SSH test |
| `12-ssh-restored-after-allow-rule.png` | Connectivity restored |
| `13-nsg-app-controlled-ssh.png` | Controlled allow + deny policy |

Sensitive information to redact before publishing:

- Subscription IDs
- Public IP addresses
- Personal source IP addresses
- Account email addresses
- Any private-key material

Private RFC1918 addresses used inside the lab are intentionally visible because they are part of the network design.

---

# Current Lab Status

Completed:

- ✅ Resource group
- ✅ VNet and subnet segmentation
- ✅ Subnet-level NSGs
- ✅ Management VM
- ✅ Restricted inbound SSH to management VM
- ✅ Private-only application VM
- ✅ SSH ProxyJump
- ✅ Inter-subnet validation
- ✅ Intentional NSG deny test
- ✅ Troubleshooting and access restoration

Remaining before marking complete:

- ⬜ Tighten priority-100 app SSH rule from `10.10.10.0/24` to `10.10.10.4/32`
- ⬜ Capture final corrected NSG screenshot
- ⬜ Deallocate VMs when not actively testing
- ⬜ Continue with routing and controlled outbound connectivity
