# Lab 03 — Troubleshooting Notes

## 1. Reader Identity Can List Blobs but Cannot Upload

### Symptom

The VM authenticated successfully and could list the contents of:

```text
blob-dev-002
```

but an upload returned:

```text
You do not have the required permissions needed to perform this operation.
```

### Investigation

The identity being tested had:

```text
Storage Blob Data Reader
```

The important observations were:

```text
Managed Identity authentication      ✅
Private storage connectivity         ✅
Blob list/read                        ✅
Blob upload                           ❌
```

### Root Cause

The behavior was correct.

`Storage Blob Data Reader` is a read-oriented data-plane role. It does not grant Blob write permissions.

### Resolution

No repair was required.

The denied upload was retained as proof that the least-privilege policy worked as designed.

The operator test was then performed with:

```text
Storage Blob Data Contributor
```

and the upload succeeded.

Evidence:

- `10.access-failure-to-edit-blob.png`
- `11.assign-operator-identity.png`
- `12.access-blob-allowed.png`

---

## 2. Explicitly Selecting the Correct Managed Identity

### Symptom

Running:

```bash
az login --identity
```

did not provide the expected Azure subscription access for the control-plane test.

### Investigation

The VM had multiple identity possibilities during the lab.

For the control-plane test, the intended identity was the user-assigned managed identity:

```text
azure-reader
```

### Resolution

The identity was selected explicitly:

```bash
az login --identity --client-id <AZURE-READER-CLIENT-ID>
```

The login then returned the expected subscription context.

### Lesson

When multiple identities are attached to a resource, an engineering test should explicitly select the identity under test.

This makes the result reproducible and prevents an authorization failure from being misdiagnosed as an RBAC configuration problem.

---

## 3. Control-Plane Access Works but Blob Access Fails

### Scenario

The `azure-reader` managed identity was assigned the built-in Azure role:

```text
Reader
```

at the storage-account scope.

### Control-plane test

```bash
az storage account show \
  --name <storage-account> \
  --resource-group rg-azlab-identity-dev \
  --output table
```

Result:

```text
SUCCESS
```

The identity could view storage-account configuration.

### Data-plane test

Using the same authenticated identity:

```bash
az storage blob list \
  --account-name <storage-account> \
  --container-name blob-dev-002 \
  --auth-mode login \
  --output table
```

Result:

```text
DENIED
```

Evidence:

- `13.reader-only-conf.png`
- `14.control-vs-data-plane-validation.png`

### Root Cause

There was no network failure and no authentication failure.

The identity had permission to read the **Azure resource configuration**, but it did not have a **Blob data role**.

The authorization paths are different:

```text
Reader
   |
   v
Azure Resource Manager / control plane
   |
   +--> resource configuration ✅

Storage Blob Data Reader / Contributor
   |
   v
Blob service / data plane
   |
   +--> Blob data operations
```

### Conclusion

```text
Reader ≠ Storage Blob Data Reader
```

A role that can view an Azure resource does not automatically receive access to the data stored inside that service.

---

## 4. Troubleshooting Decision Tree

For future RBAC failures:

```text
Operation failed
      |
      v
Did authentication succeed?
      |
   +--+--+
   |     |
  No    Yes
   |     |
Identity  v
problem  Is the correct identity selected?
              |
           +--+--+
           |     |
          No    Yes
           |     |
       select    v
       identity  Does network/DNS work?
                     |
                  +--+--+
                  |     |
                 No    Yes
                  |     |
              network   v
              issue   Which role + scope?
                         |
                         v
              Control plane or data plane?
```

This sequence helps avoid unnecessary changes to NSGs, Private Endpoints, or DNS when the actual issue is authorization.

---

## Final Troubleshooting Takeaway

A `403` or permission error can be successful evidence in an RBAC lab.

The correct question is not:

> "Did every command succeed?"

The correct question is:

> "Did every identity receive exactly the access it was designed to receive?"

For Lab 03, the answer is yes.
