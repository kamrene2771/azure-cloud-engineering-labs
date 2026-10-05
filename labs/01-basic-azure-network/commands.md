# Lab 01 — Commands

## Connect to the management VM

```bash
chmod 600 ~/.ssh/key.pem
ssh -i ~/.ssh/key.pem azureuser@<mgmt-public-ip>
```

## Validate Linux networking

```bash
hostname
ip addr
ip route
```

## SSH config for ProxyJump

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

Protect the SSH config:

```bash
chmod 600 ~/.ssh/config
```

Connect to the private VM:

```bash
ssh azure-app
```

## Validate the private SSH path

```bash
hostname
who
echo $SSH_CONNECTION
ip addr
ip route
```

Expected private path:

```text
10.10.10.4 -> 10.10.20.4:22
```
