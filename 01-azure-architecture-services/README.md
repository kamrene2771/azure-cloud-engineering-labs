# 01 — Azure Architecture & Services

> Status: 🔄 **In progress**  
> Microsoft Learn modules completed:
> - ✅ **Describe the core architectural components of Azure**
> - ✅ **Describe Azure compute services**
> - ✅ **Describe Azure networking services**
> - ✅ **Describe Azure storage services**

Core architecture achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/VSRTPTQM?sharingId=E81E8C29E6F06D32

Compute services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/3ZG7A2ZH?sharingId=E81E8C29E6F06D32

Networking services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/H262SW48?sharingId=E81E8C29E6F06D32

Storage services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/9A5QGWHU?sharingId=E81E8C29E6F06D32

This section documents my understanding of Azure architecture and core services as I progress through Microsoft Learn.

---

## 1. What is Microsoft Azure?

Microsoft Azure is a cloud computing platform that provides a broad range of services for building, hosting, managing, and securing applications and infrastructure.

Azure includes services across areas such as:

- Compute
- Networking
- Storage
- Databases
- AI and machine learning
- Identity and security
- DevOps and management
- IoT
- Analytics
- Integration

Azure can be used to run existing workloads on virtual machines, build cloud-native applications, manage data and analytics, and deploy new services without owning the underlying physical infrastructure.

---

## 2. Azure Physical Infrastructure

Azure's infrastructure starts with datacenters.

These datacenters contain servers arranged in racks and are supported by dedicated:

- Power
- Cooling
- Physical networking
- Security
- Operational infrastructure

Azure organizes these datacenters into larger architectural units such as regions and availability zones.

---

## 3. Azure Regions

An Azure region is a geographic area that contains one or more nearby datacenters connected through a low-latency network.

Regions allow organizations to deploy resources closer to users, meet data-residency requirements, and design systems across different geographic locations.

---

## 4. Availability Zones

Availability zones are physically separate locations within an Azure region.

Each availability zone is designed with independent:

- Power
- Cooling
- Networking

This creates an isolation boundary. If one zone experiences a failure, workloads designed across multiple zones can continue operating from the remaining zones.

Not every Azure region supports availability zones.

### Types of services across availability zones

**Zonal services**  
A resource is deployed into a specific availability zone.

Examples can include:

- Virtual machines
- Managed disks
- IP addresses

**Zone-redundant services**  
Azure automatically replicates the service across multiple availability zones.

Examples can include:

- Zone-redundant storage
- Azure SQL Database

**Non-regional services**  
Some services are not tied to one Azure region and are designed to operate at a broader scope.

---

## 5. Region Pairs

Many Azure regions are paired with another region within the same geography.

Region pairs are designed to support resilience and disaster-recovery scenarios by providing geographic separation between paired regions.

This can help reduce the risk of both locations being affected by the same large-scale event.

---

## 6. Sovereign Regions

Azure also provides sovereign regions.

These are isolated Azure environments designed for specific legal, regulatory, or compliance requirements.

Organizations may use a sovereign region when workloads must operate under particular government or regulatory constraints.

---

# Azure Management Infrastructure

## 7. Azure Resources

A resource is a basic building block in Azure.

Anything that is created, provisioned, or deployed in Azure is a resource.

Examples include:

- Virtual machines
- Virtual networks
- Databases
- Storage accounts
- AI services

---

## 8. Resource Groups

A resource group is a logical container used to organize Azure resources.

Every Azure resource belongs to exactly one resource group at a time.

Resource groups are useful for managing resources that share a common:

- Project
- Environment
- Lifecycle
- Ownership
- Management scope

Resource groups cannot be nested.

Some resources can be moved between resource groups, depending on the Azure service.

A clear naming convention is important because resource groups cannot simply be renamed after creation.

---

## 9. Azure Subscriptions

An Azure subscription provides access to Azure products and services and also acts as a billing and management boundary.

One Azure account can have multiple subscriptions.

Subscriptions can help separate environments or business needs.

### Billing boundary

Subscriptions can separate costs and billing.

For example:

- Development subscription
- Production subscription
- Separate business-unit subscriptions

### Access-control boundary

Permissions and access policies can also be applied at the subscription level.

This allows different subscriptions to have different:

- Access rules
- Spending controls
- Administrative permissions

---

## 10. Azure Management Groups

Management groups sit above subscriptions in the Azure hierarchy.

They are used to organize multiple subscriptions and apply governance at a higher level.

Policies and access controls applied to a management group can be inherited by the subscriptions below it.

A simplified Azure management hierarchy is:

```text
Management Group
    ↓
Subscription
    ↓
Resource Group
    ↓
Resource
```

This hierarchy allows organizations to apply governance consistently across large Azure environments.

---

# Azure Compute Services

## 11. Azure Virtual Machines

Azure Virtual Machines provide virtualized servers as an **Infrastructure as a Service (IaaS)** offering.

Like a physical server, a VM gives the customer control over the operating system and installed software.

VMs are a good fit when you need:

- Full control over the operating system
- Custom software
- Custom hosting configurations
- Existing workloads that are difficult to redesign

### Common VM use cases

- **Testing and development** — quickly create and remove different operating system and application configurations.
- **Cloud application hosting** — run applications in Azure and adjust capacity as demand changes.
- **Datacenter extension** — extend an on-premises environment into Azure.
- **Disaster recovery** — maintain recovery capacity in Azure.
- **Lift-and-shift migration** — move existing server workloads with minimal redesign.

### VM resources and sizing

When creating a VM, important choices include:

- vCPU count
- RAM
- Storage and disk performance
- Network throughput
- VM size family
- Premium SSD support
- Hardware generation

### Common VM families

| Family | Typical focus | Example use |
|---|---|---|
| B-series | Burstable / cost efficient | Development and test |
| D-series | General purpose | Web and application servers |
| E-series | Memory optimized | Databases and analytics |
| F-series | Compute optimized | CPU-intensive workloads |
| M-series | Large memory | Enterprise databases |
| L-series | Storage optimized | High-throughput data workloads |
| N-series | GPU enabled | AI, graphics, GPU workloads |

---

## 12. VM Scale Sets and Availability Sets

### Virtual Machine Scale Sets

Virtual Machine Scale Sets allow groups of similar VMs to be created and managed together.

They can:

- Keep VM configuration consistent
- Scale out or scale in
- Respond to workload demand
- Integrate with load balancing

### Availability Sets

Availability sets improve resiliency for groups of VMs inside a region.

They organize VMs across:

- **Fault domains** — separate hardware, power, or network failure boundaries
- **Update domains** — groups that can be rebooted together during planned maintenance

---

## 13. Azure Virtual Desktop

Azure Virtual Desktop is a desktop and application virtualization service hosted in Azure.

It enables users to securely access Windows desktops and applications from different devices and locations.

Typical scenarios include:

- Remote workers
- Contractors
- Shared or standardized desktop environments
- Centrally managed application access

---

## 14. Azure Containers

Containers package applications in a lightweight and portable way.

Unlike virtual machines, containers do not require a full guest operating system for each application instance.

This makes containers:

- Lightweight
- Fast to start
- Easy to scale
- Well suited for microservices

### Azure Container Instances

Azure Container Instances provides a simple way to run containers without managing virtual machines.

It is useful when you want to run a container quickly without operating a full orchestration platform.

### Azure Container Apps

Azure Container Apps provides a managed environment for containerized applications with features such as:

- Built-in scaling
- Load balancing
- Reduced infrastructure-management overhead

### Azure Kubernetes Service

Azure Kubernetes Service (AKS) is a managed Kubernetes service used to orchestrate containerized workloads.

It helps manage:

- Container deployment
- Scaling
- Availability
- Lifecycle
- Large groups of containers

### Containers and microservices

Containers are commonly used in microservice architectures where an application is divided into smaller independent components.

For example:

```text
Frontend container
        ↓
Backend/API container
        ↓
Data service
```

Each component can then be deployed, scaled, and updated independently.

---

## 15. Azure Functions

Azure Functions is an **event-driven serverless compute** service.

Instead of keeping a VM or container running continuously, a function can execute when triggered by an event.

Common triggers can include:

- HTTP or REST requests
- Timers
- Messages
- Events from other Azure services

Benefits include:

- No VM management
- Automatic scaling
- Good fit for event-driven workloads
- Resources can be allocated only when code needs to run

Functions are stateless by default, while **Durable Functions** can maintain workflow state across multiple operations.

---

## 16. AI, Machine Learning, IoT, and Edge Services

### Azure AI services

Azure AI services provide prebuilt capabilities for scenarios such as:

- Language
- Speech
- Vision
- Document processing

These services can be consumed through APIs without building a machine-learning model from scratch.

### Azure OpenAI Service

Azure OpenAI Service supports generative AI use cases such as:

- Chat
- Content generation
- AI-assisted applications

### Azure Machine Learning

Azure Machine Learning is designed for building, training, deploying, and managing custom machine-learning models.

### IoT and Edge

Azure IoT services help connect, monitor, and manage devices.

Examples include:

- **Azure IoT Hub** — secure bidirectional communication between devices and cloud services.
- **Azure IoT Central** — a managed SaaS platform for building IoT solutions.
- **Azure IoT Edge** — extends cloud workloads closer to devices and where data is generated.

---

## 17. Application Hosting Options

Azure provides several application-hosting approaches.

### Virtual Machines

Choose VMs when you need:

- Full OS control
- Custom software
- Custom infrastructure
- Lift-and-shift workloads

### Containers

Choose containers when you need:

- Lightweight packaging
- Portability
- Fast deployment
- Microservices
- Independent scaling

### Azure App Service

Azure App Service is a managed application-hosting platform.

It can host:

- Web applications
- REST APIs
- Background jobs
- Mobile backends

It supports Windows and Linux and can integrate with source-control systems for automated deployment.

---

# Azure Networking Services

## 18. Azure Virtual Networks

Azure Virtual Network (VNet) provides private networking for Azure resources.

A VNet can connect resources such as:

- Virtual machines
- Azure Kubernetes Service
- Virtual machine scale sets
- Application environments
- Other supported Azure services

A VNet can also communicate with users over the internet and with on-premises networks.

### Isolation and segmentation

A VNet has its own IP address space.

That address space can be divided into subnets so that workloads can be separated logically.

This makes it possible to organize resources by role, security requirement, or application tier.

For name resolution, Azure provides built-in DNS capabilities, and a VNet can also be configured to use custom DNS servers.

### Internet communication

Azure resources can communicate with the internet when public connectivity is configured.

Examples include:

- Assigning a public IP address to a resource
- Placing resources behind a public load balancer

Public connectivity should be designed together with appropriate security controls.

### Communication between Azure resources

Azure resources can communicate privately inside Azure.

Two important approaches covered in this module are:

- **Virtual network connectivity** — resources communicate through a VNet.
- **Service endpoints** — selected Azure services such as Azure Storage or Azure SQL can be reached from a VNet using controlled network access.

### Communication with on-premises resources

Azure VNets can connect to on-premises environments.

Common options include:

- **Point-to-site VPN** — an individual client device creates an encrypted VPN connection to Azure.
- **Site-to-site VPN** — an on-premises VPN device connects to an Azure VPN Gateway over an encrypted tunnel.
- **ExpressRoute** — provides private connectivity to Microsoft cloud services without sending traffic over the public internet.

---

## 19. Routing and Traffic Control

Azure automatically provides routing between connected network components, but routing can also be controlled explicitly.

### Route tables and User-Defined Routes

Route tables can contain custom routes that control how traffic is forwarded.

**User-Defined Routes (UDRs)** can be used to control traffic flow:

- Between subnets
- Between VNets
- Toward network virtual appliances
- Toward on-premises environments

### Border Gateway Protocol

BGP can be used with:

- Azure VPN Gateway
- Azure Route Server
- Azure ExpressRoute

BGP allows routes to be exchanged dynamically between Azure and external networks.

This is particularly relevant in hybrid networking scenarios.

---

## 20. Filtering Network Traffic

### Network Security Groups

Network Security Groups (NSGs) contain inbound and outbound rules that allow or deny traffic.

Rules can be based on:

- Source IP address
- Destination IP address
- Port
- Protocol
- Direction

NSGs are one of the primary tools for controlling traffic at the subnet or network-interface level.

### Network Virtual Appliances

A Network Virtual Appliance (NVA) is a specialized virtual machine that performs a network function.

Examples include:

- Firewalling
- Routing
- WAN optimization

NVAs can be inserted into a traffic path when more specialized network processing is required.

---

## 21. Virtual Network Peering

Virtual network peering connects two VNets directly.

Traffic between peered VNets:

- Remains private
- Travels over the Microsoft backbone network
- Does not need to pass through the public internet

Peering enables resources in separate VNets to communicate with one another.

VNets can also be peered across Azure regions, allowing globally distributed private networks to be built.

---

## 22. Azure VPN Gateway

A VPN creates an encrypted tunnel across an untrusted network such as the public internet.

Azure VPN Gateway can support several connectivity models:

- **Site-to-site** — connects an on-premises network to an Azure VNet.
- **Point-to-site** — connects an individual device to an Azure VNet.
- **VNet-to-VNet** — connects one VNet to another using VPN gateways.

### Policy-based vs route-based VPN

**Policy-based VPN gateways** use defined traffic selectors to determine which traffic should enter a tunnel.

**Route-based VPN gateways** model tunnels as interfaces and use routing information to decide where packets should be sent.

Route-based VPNs are generally more flexible for scenarios such as:

- VNet-to-VNet connectivity
- Point-to-site connectivity
- Multisite connectivity
- Coexistence with ExpressRoute
- Dynamic routing with BGP

### VPN Gateway resiliency

VPN gateways are deployed with built-in redundancy.

In the standard active/standby design, one gateway instance can take over if the active instance is affected by maintenance or failure.

Azure also supports active/active VPN gateway configurations using multiple public IP addresses and separate tunnels.

For additional resilience, an organization can also deploy redundant on-premises VPN devices.

### Zone-redundant gateways

In regions that support availability zones, VPN Gateway and ExpressRoute gateways can use zone-redundant configurations.

This can improve resilience against zone-level failures.

---

## 23. Azure ExpressRoute

Azure ExpressRoute provides private connectivity between on-premises networks and Microsoft cloud services through a connectivity provider.

Unlike a normal VPN, ExpressRoute traffic does not travel over the public internet.

Typical reasons to use ExpressRoute include:

- Private connectivity requirements
- Predictable latency
- High-throughput connectivity
- Compliance requirements
- More consistent network performance

An ExpressRoute connection is delivered through an **ExpressRoute circuit**.

Connectivity options can include:

- Any-to-any IP VPN networks
- Point-to-point Ethernet
- Virtual cross-connections at colocation facilities

### ExpressRoute Global Reach

ExpressRoute Global Reach can connect separate on-premises locations through Microsoft’s network.

For example, an office and a datacenter in different geographic regions can communicate through their ExpressRoute circuits without sending that traffic over the public internet.

### ExpressRoute with VPN failover

A VPN Gateway can be used as a backup path for an ExpressRoute connection.

This provides an additional connectivity option if an ExpressRoute circuit experiences an outage.

---

## 24. Azure DNS

Azure DNS is a DNS hosting service that uses Microsoft Azure infrastructure.

It allows DNS zones and records to be managed using Azure tools, APIs, authentication, and billing.

Benefits covered in this module include:

- Reliability
- Performance
- Security
- Ease of management
- Integration with Azure environments
- Alias records

### Alias records

Alias record sets can point directly to supported Azure resources.

Examples include:

- Azure public IP addresses
- Azure Traffic Manager profiles
- Azure CDN endpoints

If the underlying resource changes, the alias can continue to resolve to the service without requiring the DNS record to be manually updated with a new IP address.

# Azure Storage Services

## 25. Azure Storage Accounts

An Azure storage account is the main container for Azure Storage data.

It provides a **unique namespace** for storage services and makes the data accessible through Azure Storage endpoints over HTTP or HTTPS.

Important storage-account naming rules from the module:

- The name must be between **3 and 24 characters**
- Only **lowercase letters and numbers** are allowed
- The name must be **unique across Azure**

A storage account can provide access to multiple Azure Storage services, including blobs, files, queues, tables, and disks.

---

## 26. Azure Storage Redundancy

Azure Storage keeps multiple copies of data to improve durability and availability.

The redundancy option determines **where those copies are stored**.

### LRS — Locally Redundant Storage

LRS keeps three copies of the data inside a single datacenter in the primary region.

It protects against local hardware failures, but all copies remain within one datacenter.

### ZRS — Zone-Redundant Storage

ZRS replicates data synchronously across three availability zones in the primary region.

This provides protection against a failure affecting an entire availability zone.

### GRS — Geo-Redundant Storage

GRS first uses LRS in the primary region and then asynchronously replicates the data to a geographically separate secondary region.

This adds protection against a regional failure.

Because the replication to the secondary region is asynchronous, the most recent writes may not yet exist in the secondary region during a major outage.

### GZRS — Geo-Zone-Redundant Storage

GZRS combines:

- ZRS in the primary region
- Geo-replication to a secondary region
- LRS in the secondary region

This provides both zone-level resilience in the primary region and geographic disaster-recovery protection.

### Redundancy summary

| Option | Primary region | Secondary region | Main protection |
|---|---|---|---|
| LRS | 3 copies in one datacenter | No | Local hardware failure |
| ZRS | Copies across 3 availability zones | No | Zone failure |
| GRS | LRS | LRS | Regional disaster recovery |
| GZRS | ZRS | LRS | Zone + regional failure |

A useful design question is not simply "which option is strongest?" but **what level of failure does the workload need to survive, and what cost/complexity is justified?**

---

## 27. Azure Storage Services

Azure provides different storage services for different data patterns.

### Azure Blob Storage

Blob Storage is object storage designed for large amounts of unstructured text or binary data.

Examples include:

- Images
- Documents
- Backups
- Logs
- Large binary objects

Blob Storage also supports Data Lake Storage Gen2 scenarios.

### Azure Files

Azure Files provides fully managed file shares.

It supports familiar file-sharing protocols such as:

- SMB
- NFS

This makes it useful when applications or users need a shared filesystem without maintaining a traditional file server.

Key benefits covered in the module include:

- Shared access
- Fully managed infrastructure
- High availability
- Azure CLI, PowerShell, portal, and Storage Explorer management
- Compatibility with standard file I/O APIs

### Azure Queues

Azure Queue Storage provides a messaging store for communication between application components.

It is useful when components need to exchange messages reliably without being tightly coupled.

### Azure Disks

Azure managed disks provide block-level storage for Azure virtual machines.

From an infrastructure perspective, disks are the persistent storage attached to VMs for operating systems and application data.

### Azure Tables

Azure Table Storage provides structured NoSQL storage for non-relational data.

---

## 28. Blob Access Tiers

Blob Storage provides access tiers so storage cost can be balanced against how frequently data is read.

| Tier | Typical pattern |
|---|---|
| Hot | Frequently accessed data |
| Cool | Infrequently accessed data, typically kept at least 30 days |
| Cold | Infrequently accessed data, typically kept at least 90 days |
| Archive | Rarely accessed long-term data, typically kept at least 180 days |

The general principle is:

```text
More frequent access
        ↓
Hot → Cool → Cold → Archive
        ↓
Lower storage cost / slower or more expensive retrieval
```

The correct tier depends on the expected access pattern rather than simply choosing the cheapest storage tier.

---

## 29. Azure Storage and Migration Tools

### AzCopy

AzCopy is a command-line utility for moving data to, from, or between Azure storage accounts.

It can:

- Upload files
- Download files
- Copy between storage accounts
- Synchronize blobs or files

The module notes that AzCopy synchronization is **one-directional**.

### Azure Storage Explorer

Azure Storage Explorer is a graphical desktop application for managing Azure Storage.

It runs on Windows, macOS, and Linux and can be used to:

- Upload data
- Download data
- Move data between storage accounts
- Manage files and blobs

Storage Explorer uses AzCopy in the background for file and blob operations.

### Azure File Sync

Azure File Sync allows an organization to centralize file shares in Azure Files while keeping Windows file servers synchronized with Azure.

Unlike the one-way synchronization described for AzCopy, Azure File Sync keeps the Windows server and Azure Files synchronized bi-directionally.

### Azure Migrate

Azure Migrate is a migration hub for assessing and moving on-premises workloads to Azure.

It provides a central place to:

- Discover existing infrastructure
- Assess workloads
- Plan migration
- Track migration activities

### Azure Data Box

Azure Data Box is a physical data-transfer service.

Instead of transferring very large datasets entirely over a network connection, Microsoft ships a secured storage device that can be loaded with data and transported to Azure.

This is useful when network transfer would be too slow or impractical.

28.Azure directory services

Microsoft Entra ID is Microsoft's cloud-based identity and access management service. It lets you sign in and access both Microsoft cloud applications and cloud applications that you develop.

Authentication — Verifies identity before granting access. Includes self-service password reset, multifactor authentication, banned password lists, and smart lockout.

Single sign-on (SSO) — Lets one identity access multiple applications. SSO benefits and behavior are covered in the authentication methods unit.

Application management — Manages cloud and on-premises apps through features like Application Proxy, SaaS app integration, and the My Apps portal.

Device management — Supports device registration and management through tools like Microsoft Intune. Enables device-based Conditional Access policies that restrict access to known devices.

Microsoft Entra Domain Services
Microsoft Entra Domain Services provides managed domain services — domain join, group policy, LDAP, and Kerberos/NTLM authentication — without requiring you to deploy or maintain domain controllers in the cloud.

Is information synchronized?

A managed domain is configured to perform a one-way synchronization from Microsoft Entra ID to Microsoft Entra Domain Services. You can create resources directly in the managed domain, but they aren't synchronized back to Microsoft Entra ID. In a hybrid environment with an on-premises AD DS environment, Microsoft Entra Connect synchronizes identity information with Microsoft Entra ID, which is then synchronized to the managed domain.

29.Azure authentication methods

Authentication establishes the identity of a person, service, or device by requiring credentials. In Azure, common methods include passwords, single sign-on (SSO), multifactor authentication (MFA), and passwordless sign-in. Modern approaches are designed to improve both security and user convenience.

---

# Storage Key Takeaways

From the Azure storage module, my main takeaways are:

1. A storage account provides the namespace and access point for Azure Storage services.
2. Storage redundancy is a resilience decision: LRS, ZRS, GRS, and GZRS protect against different failure scopes.
3. Blob, Files, Queues, Disks, and Tables solve different storage problems.
4. Blob access tiers trade storage cost against access frequency and retrieval requirements.
5. Azure Files provides managed SMB/NFS file shares without maintaining a traditional file server.
6. Managed disks provide persistent block storage for Azure VMs.
7. AzCopy is a CLI data-transfer tool, while Storage Explorer provides a GUI.
8. Azure File Sync connects Windows file servers with Azure Files through bi-directional synchronization.
9. Azure Migrate helps assess and move existing workloads to Azure.
10. Azure Data Box is designed for moving very large datasets when network transfer is not practical.
11. For my cloud infrastructure path, the most relevant storage topics are managed disks, redundancy, secure storage access, migration, and private connectivity.



---

# Networking Key Takeaways

From the Azure networking module, my main takeaways are:

1. A VNet is the main private networking boundary for Azure resources.
2. Subnets provide segmentation inside a VNet.
3. NSGs control inbound and outbound traffic using security rules.
4. Route tables and UDRs provide explicit control over packet forwarding.
5. BGP supports dynamic route exchange in hybrid Azure networking scenarios.
6. VNet peering provides private communication between Azure virtual networks.
7. VPN Gateway provides encrypted connectivity over the public internet.
8. ExpressRoute provides private connectivity that does not traverse the public internet.
9. Zone-redundant gateways can improve resilience for hybrid connectivity.
10. Azure DNS provides integrated DNS hosting and supports alias records for Azure resources.

---

# Learning Evidence

Completed Microsoft Learn modules:

- ✅ **Describe the core architectural components of Azure**
- ✅ **Describe Azure compute services**
- ✅ **Describe Azure networking services**
- ✅ **Describe Azure storage services**

Core architecture achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/VSRTPTQM?sharingId=E81E8C29E6F06D32

Compute services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/3ZG7A2ZH?sharingId=E81E8C29E6F06D32

Networking services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/H262SW48?sharingId=E81E8C29E6F06D32

Storage services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/9A5QGWHU?sharingId=E81E8C29E6F06D32

---

## Practical Reinforcement

The storage module was reinforced with:

**[Lab 02 — Secure Azure Storage Access](../labs/02-secure-azure-storage-access/)** ✅

The lab connected storage theory to infrastructure engineering through:

- Private Endpoint and Private DNS
- Public network restriction
- Managed Identity and Azure RBAC
- Blob data-plane access
- DNS failure isolation and recovery

## Next Step

Continue the **Azure Architecture & Services** Microsoft Learn path, then reinforce the next relevant topic with another specialization-focused lab.
