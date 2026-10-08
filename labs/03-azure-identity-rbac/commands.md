# Lab 03 — Commands

Commands used to validate **Azure Identity & RBAC: Least Privilege Access**.

Replace placeholders such as `<storage-account>` and `<CLIENT-ID>` with the appropriate lab values.

---

## Managed Identity Login

When only one appropriate identity is available:

```bash
az login --identity
```

When multiple identities are attached to the VM, select the intended user-assigned identity explicitly:

```bash
az login --identity --client-id <CLIENT-ID>
```

This is especially important for repeatable RBAC testing because the test must use the identity associated with the role being evaluated.

---

## Verify Current Azure Context

```bash
az account show --output table
```

---

## List Blob Data

```bash
az storage blob list \
  --account-name <storage-account> \
  --container-name blob-dev-002 \
  --auth-mode login \
  --output table
```

Expected results:

- `Storage Blob Data Reader` → succeeds
- `Storage Blob Data Contributor` → succeeds
- Azure built-in `Reader` only → denied

---

## Create Test File

```bash
echo "Lab 03 RBAC test" > test.txt
```

---

## Test Blob Upload

```bash
az storage blob upload \
  --account-name <storage-account> \
  --container-name blob-dev-002 \
  --name test.txt \
  --file test.txt \
  --auth-mode login
```

Expected results:

```text
Storage Blob Data Reader        → denied
Storage Blob Data Contributor   → succeeds
```

---

## Optional Download Validation

If a Blob already exists:

```bash
az storage blob download \
  --account-name <storage-account> \
  --container-name blob-dev-002 \
  --name test.txt \
  --file downloaded-test.txt \
  --auth-mode login
```

Then:

```bash
cat downloaded-test.txt
```

---

## Control-Plane Test

Using the identity assigned the built-in Azure `Reader` role:

```bash
az login --identity --client-id <AZURE-READER-CLIENT-ID>
```

Read the storage-account resource configuration:

```bash
az storage account show \
  --name <storage-account> \
  --resource-group rg-azlab-identity-dev \
  --output table
```

Expected result:

```text
SUCCESS
```

This request is evaluated through the Azure resource management/control plane.

---

## Data-Plane Test with the Same Identity

Without changing identities:

```bash
az storage blob list \
  --account-name <storage-account> \
  --container-name blob-dev-002 \
  --auth-mode login \
  --output table
```

Expected result:

```text
Authorization denied
```

This proves that the built-in Azure `Reader` role does not automatically provide Blob data access.

---

## Useful Network Validation

Private Endpoint IP used in the lab:

```text
10.10.20.4
```

Validate DNS:

```bash
nslookup <storage-account>.blob.core.windows.net
```

Validate TCP/443:

```bash
nc -vz <storage-account>.blob.core.windows.net 443
```

These tests help separate network problems from RBAC problems.

---

## Test Matrix

| Identity / Role | Control-plane read | Blob list/read | Blob upload |
|---|---:|---:|---:|
| Azure `Reader` | ✅ | ❌ | ❌ |
| `Storage Blob Data Reader` | not the purpose of this role | ✅ | ❌ |
| `Storage Blob Data Contributor` | not the purpose of this role | ✅ | ✅ |
