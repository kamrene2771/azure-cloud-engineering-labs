# Lab 02 — Secure Azure Storage Access

> Status: 🔄 **In progress**  
> Region: **Belgium Central**

This lab focuses on securing Azure Storage from a cloud infrastructure and networking perspective.

The goal is to understand how a private workload can access Azure Blob Storage without exposing the storage account to the public internet.

---

## Objectives

- Create an Azure Storage account and private Blob container
- Build a dedicated VNet for the lab
- Deploy a Linux client VM
- Restrict storage public network access
- Create a Private Endpoint for Blob Storage
- Configure and validate Azure Private DNS
- Verify that the storage endpoint resolves to a private IP
- Test private connectivity from the client VM
- Intentionally break DNS or network access
- Troubleshoot and restore connectivity
- Document security decisions and clean up billable resources

---

## Planned Architecture

```text
                     Internet
                        |
             SSH restricted to my IP
                        |
                        v
              vm-storage-client-001
                  10.20.10.x
                  snet-client
                        |
                        | private VNet traffic
                        v
                 Private Endpoint
                  10.20.20.x
            snet-private-endpoints
                        |
                        v
               Azure Blob Storage
             Public access restricted

DNS flow:

<storage>.blob.core.windows.net
              |
              v
<storage>.privatelink.blob.core.windows.net
              |
              v
       Private endpoint IP
```

---

## Planned Addressing

| Resource | Address / CIDR |
|---|---|
| VNet | `10.20.0.0/16` |
| Client subnet | `10.20.10.0/24` |
| Private Endpoint subnet | `10.20.20.0/24` |

---

## Planned Resources

| Resource | Name |
|---|---|
| Resource group | `rg-azlab-storage-dev` |
| Virtual network | `vnet-azlab-storage-dev-001` |
| Client subnet | `snet-client` |
| Private Endpoint subnet | `snet-private-endpoints` |
| Client VM | `vm-storage-client-001` |
| Client NSG | `nsg-storage-client` |
| Private DNS zone | `privatelink.blob.core.windows.net` |
| Storage account | To be chosen — globally unique name required |

---

## Lab Method

This lab will follow the same workflow as Lab 01:

**Baseline → Secure → Break → Troubleshoot → Restore → Document → Cleanup**

Evidence will be captured only at meaningful checkpoints rather than for every portal click.

---

## Current Progress

- ⬜ Resource group
- ⬜ VNet and subnets
- ⬜ Client NSG
- ⬜ Linux client VM
- ⬜ Storage account
- ⬜ Baseline public access test
- ⬜ Storage network restrictions
- ⬜ Private Endpoint
- ⬜ Private DNS
- ⬜ Private connectivity validation
- ⬜ Failure scenario
- ⬜ Troubleshooting and recovery
- ⬜ Cleanup
