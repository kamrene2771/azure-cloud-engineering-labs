# 01 — Azure Architecture & Services

> Status: 🔄 **In progress**  
> Microsoft Learn modules completed:
> - ✅ **Describe the core architectural components of Azure**
> - ✅ **Describe Azure compute services**

Core architecture achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/VSRTPTQM?sharingId=E81E8C29E6F06D32

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

# Key Takeaways

From the architecture and compute modules, my main takeaways are:

1. Azure's physical infrastructure is organized into datacenters, regions, and availability zones.
2. Availability zones provide physical separation inside a region and can improve resiliency when workloads are designed to use them.
3. Region pairs provide geographic separation that can support disaster-recovery strategies.
4. Azure resources are organized inside resource groups.
5. Subscriptions provide billing and access-control boundaries.
6. Management groups provide a governance layer above subscriptions.
7. Virtual machines provide the most control but require the customer to manage more of the operating environment.
8. Containers are lighter than VMs and are useful for portable, scalable workloads.
9. AKS provides orchestration for larger containerized environments.
10. Azure Functions is useful for event-driven serverless workloads.
11. Azure App Service provides managed application hosting without requiring direct infrastructure management.
12. Choosing the right compute service depends on how much control, management responsibility, scalability, and portability the workload requires.

---

# Learning Evidence

Completed Microsoft Learn modules:

- ✅ **Describe the core architectural components of Azure**
- ✅ **Describe Azure compute services**

Core architecture achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/VSRTPTQM?sharingId=E81E8C29E6F06D32

---

## Next Step

Continue with **Describe Azure networking services**.

This is a high-priority module for my target path in **Cloud Infrastructure, Network Engineering, and NetDevOps**, and it will lead directly into the first hands-on Azure networking labs.
