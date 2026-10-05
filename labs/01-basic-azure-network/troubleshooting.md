# Lab 01 — Troubleshooting Notes

## SSH returned `Permission denied (publickey)`

Initial symptom:

```text
user@<mgmt-public-ip>: Permission denied (publickey)
```

Root cause:

The network path and TCP/22 were working, but the wrong Linux username was used.

Resolution:

```bash
ssh -i ~/.ssh/key.pem azureuser@<mgmt-public-ip>
```

Lesson:

A public-key authentication failure is different from a network timeout. It proves that the SSH service was reached.

---

## ProxyJump initially failed at the jump host

If an SSH ProxyJump error names the public management IP, troubleshoot authentication to `vm-mgmt-001` first.

If the error names `10.10.20.4`, the jump host worked and the remaining issue is on the application VM side.

---

## SSH hung after adding the NSG deny rule

Change introduced:

```text
Priority 200
Source 10.10.10.0/24
TCP/22
Deny
```

Observed behavior:

```bash
ssh azure-app
# connection did not complete
```

Root cause:

The priority-200 custom rule was evaluated before Azure's default priority-65000 `AllowVNetInBound` rule.

This demonstrated an NSG policy failure rather than an SSH authentication failure.

---

## Least-privilege correction

The intended final policy is:

```text
100 Allow 10.10.10.4/32 -> TCP/22
200 Deny  10.10.10.0/24 -> TCP/22
```

This permits only the designated management VM to SSH to the application VM.
