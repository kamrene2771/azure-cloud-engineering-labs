# 01 — Azure Architecture & Services

> Status: 🔄 **In progress**  
> Microsoft Learn modules completed:
> - ✅ **Describe the core architectural components of Azure**
> - ✅ **Describe Azure compute services**

Core architecture achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/VSRTPTQM?sharingId=E81E8C29E6F06D32

Compute services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/3ZG7A2ZH?sharingId=E81E8C29E6F06D32

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

## 25. Azure storage accounts

A storage account provides a unique namespace for your Azure Storage data that's accessible from anywhere in the world over HTTP or HTTPS. Data in this account is secure, highly available, durable, and massively scalable.

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

Storage account endpoints
One of the benefits of using an Azure storage account is having a unique namespace in Azure for your data. Every storage account must have a unique account name within Azure. The combination of the account name and the Azure Storage service endpoint forms the endpoints for your storage account.

When naming your storage account, keep these rules in mind:

Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only.
Your storage account name must be unique within Azure. No two storage accounts can have the same name. This supports the ability to have a unique, accessible namespace in Azure.
The following table shows the endpoint format for Azure Storage services.

---

# Learning Evidence

Completed Microsoft Learn modules:

- ✅ **Describe the core architectural components of Azure**
- ✅ **Describe Azure compute services**
- ✅ **Describe Azure networking services**

Core architecture achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/VSRTPTQM?sharingId=E81E8C29E6F06D32

Compute services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/3ZG7A2ZH?sharingId=E81E8C29E6F06D32

Networking services achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/H262SW48?sharingId=E81E8C29E6F06D32

---

## Next Step

Start the first hands-on Azure networking lab.

The first practical lab will focus on:

- Resource group
- Virtual network
- Subnets
- Network Security Groups
- Linux virtual machine
- Connectivity validation
- Intentional connectivity failure
- Troubleshooting and documentation
