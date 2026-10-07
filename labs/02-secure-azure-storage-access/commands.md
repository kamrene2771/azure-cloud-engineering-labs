# Lab 02 — Commands

Commands used to validate **Secure Azure Storage Access**.

Replace `<storage-account>` and other placeholders where required.

---

## Linux Network Validation

```bash
hostname
ip addr
ip route
```

## Private DNS Validation

```bash
getent hosts <storage-account>.blob.core.windows.net
nslookup <storage-account>.blob.core.windows.net
```

Expected private resolution:

```text
<storage-account>.blob.core.windows.net
    → <storage-account>.privatelink.blob.core.windows.net
    → 10.10.20.4
```

## TCP and HTTPS Validation

```bash
nc -vz <storage-account>.blob.core.windows.net 443
curl -I https://<storage-account>.blob.core.windows.net
```

A Storage HTTP response such as `400` or `403` still proves that the endpoint was reached.

## Install Azure CLI on Ubuntu

```bash
sudo apt-get update
sudo apt-get install -y curl
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az version
```

## Authenticate with the VM Managed Identity

```bash
az login --identity
```

## List Blobs

```bash
az storage blob list \
  --account-name <storage-account> \
  --container-name blob-lab-001 \
  --auth-mode login \
  --output table
```

## Create Test Data

```bash
echo "Lab 02 private storage test" > test.txt
```

## Upload Blob

```bash
az storage blob upload \
  --account-name <storage-account> \
  --container-name blob-lab-001 \
  --name test.txt \
  --file test.txt \
  --auth-mode login
```

## Download Blob

```bash
az storage blob download \
  --account-name <storage-account> \
  --container-name blob-lab-001 \
  --name test.txt \
  --file download_test.txt \
  --auth-mode login

cat download_test.txt
```

## DNS Failure Experiment

After intentionally removing the A-record IP from the Private DNS zone:

```bash
getent hosts <storage-account>.blob.core.windows.net
nslookup <storage-account>.blob.core.windows.net
```

Test the Private Endpoint directly:

```bash
nc -vz 10.10.20.4 443
```

Retest Blob access:

```bash
az storage blob list \
  --account-name <storage-account> \
  --container-name blob-lab-001 \
  --auth-mode login \
  --output table
```

## DNS Recovery Validation

```bash
nslookup <storage-account>.blob.core.windows.net
```

Expected address:

```text
10.10.20.4
```

Then:

```bash
az storage blob list \
  --account-name <storage-account> \
  --container-name blob-lab-001 \
  --auth-mode login \
  --output table
```

If DNS caching needs clearing:

```bash
sudo resolvectl flush-caches
```
