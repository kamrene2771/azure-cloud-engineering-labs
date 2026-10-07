# Lab 02 — Troubleshooting Notes

## Scenario

The lab had already proven successful private Blob access through:

```text
vm-storage-client
        ↓
Private DNS
        ↓
Private Endpoint 10.10.20.4
        ↓
Azure Blob Storage
```

Authentication and authorization were provided by:

```text
System-assigned Managed Identity
        ↓
Microsoft Entra ID
        ↓
Storage Blob Data Contributor
```

To create a controlled failure, the IP value was removed from the storage account A record inside:

```text
privatelink.blob.core.windows.net
```

No changes were made to the VM, NSG, Private Endpoint, storage-account RBAC, or Managed Identity.

---

## Symptoms

The normal storage FQDN no longer resolved to `10.10.20.4`.

The DNS lookup still showed the CNAME relationship:

```text
<storage>.blob.core.windows.net
        ↓
<storage>.privatelink.blob.core.windows.net
```

but there was no private A-record address.

Blob access using the normal hostname stopped completing successfully.

Evidence:

- `17.remove-ip-resolve.png`
- `18.prove-dns-failure.png`
- `19.access-to-blob-broken.png`

---

## Isolation Test

Direct TCP reachability to the Private Endpoint was tested:

```bash
nc -vz 10.10.20.4 443
```

Result:

```text
succeeded
```

This proved:

```text
Private Endpoint exists             ✅
Private IP reachable                ✅
VNet routing works                  ✅
TCP/443 path works                  ✅
DNS service discovery               ❌
```

The fault therefore was not routing or endpoint availability.

---

## Root Cause

The Azure Storage application connects by FQDN, not by manually configured endpoint IP.

The Private Endpoint provided `10.10.20.4`, but the workload depended on Private DNS to discover that address through:

```text
<storage>.blob.core.windows.net
        ↓ CNAME
<storage>.privatelink.blob.core.windows.net
        ↓ A
10.10.20.4
```

Removing the A-record value broke the final DNS mapping.

The endpoint remained healthy, but the application could no longer discover it.

---

## Recovery

The A record was restored:

```text
<storage-account> → 10.10.20.4
```

DNS was validated again:

```bash
nslookup <storage-account>.blob.core.windows.net
```

The response again contained:

```text
Address: 10.10.20.4
```

Blob access was retested with:

```bash
az storage blob list \
  --account-name <storage-account> \
  --container-name blob-lab-001 \
  --auth-mode login \
  --output table
```

The previously uploaded `test.txt` was returned successfully.

Evidence:

- `20.dns-restored.png`
- `21.dns-validation.png`

---

## Troubleshooting Lesson

> A healthy Private Endpoint is not enough. Private DNS is part of the functional data path because the application uses the Azure service FQDN.

| Test | Result | Conclusion |
|---|---|---|
| `nc -vz 10.10.20.4 443` | Success | Private endpoint/network path healthy |
| `nslookup <storage>.blob.core.windows.net` | Missing private A record | DNS broken |
| `az storage blob list ...` | Failed/hung | Application affected by DNS failure |

This prevented unnecessary changes to NSGs, routing, Private Endpoint configuration, or RBAC.

---

## Additional Lessons

- DNS lookup failure → name-resolution layer
- TCP timeout → network/security/routing layer
- HTTP `400` → service reached, request invalid
- HTTP `403` → service reached, authorization/access issue
- Successful TCP by IP but failure by FQDN → strong DNS indicator

Private connectivity answers:

```text
Can the workload reach the service?
```

Managed Identity + RBAC answers:

```text
Can this workload perform the requested data operation?
```

Both must succeed for secure Blob access.
