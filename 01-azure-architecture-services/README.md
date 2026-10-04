# 01 — Azure Architecture & Services

> Status: 🔄 **In progress**  
> Microsoft Learn badge earned: **Describe the core architectural components of Azure** ✅

Achievement:  
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

11 .Azure virtual machines

With Azure Virtual Machines (VMs), you can run virtualized servers in Azure as infrastructure as a service (IaaS). Like a physical server, you control the operating system and installed software. VMs are a good fit when you need:

Total control over the operating system (OS).
The ability to run custom software.
To use custom hosting configurations.

Common VM use cases include:

Testing and development. Create different OS and app configurations quickly, then remove the VM when testing is complete.
Cloud application hosting. Run applications in Azure and scale capacity up or down as demand changes.
Datacenter extension. Extend an on-premises network into Azure and host workloads in a connected virtual network.
Disaster recovery. Keep failover capacity in Azure and run critical workloads there if your primary site is unavailable.
Lift and shift migration. Move existing server workloads with minimal application redesign.

VM resources and sizing
When you provision a VM, you choose resources such as:

Size (purpose, number of processor cores, and amount of RAM)
Storage disks (hard disk drives, solid state drives, etc.)
Networking (virtual network, public IP address, and port configuration)
Understand VM size families and names
Azure VM sizes are grouped into families so you can quickly choose a size based on your workload needs.

Family	Typical focus	Example use
B-series	Burstable, cost-efficient	Dev/test workloads with occasional CPU spikes
D-series	General purpose	Web servers, small-to-medium app servers
E-series	Memory optimized	In-memory databases, analytics workloads
F-series	Compute optimized	CPU-intensive application tiers
M-series	Large memory footprint	Large enterprise databases
L-series	Storage optimized	High-throughput storage and data processing
N-series	GPU enabled	AI training/inference and graphics workloads

each VM also has options that you can customize based on your needs. You can adjust the number of virtual CPUs (vCPUs), the amount of RAM, and the storage disk configuration.
vCPU count: affects compute capacity for concurrent and CPU-bound workloads.
RAM: affects how much working data the VM can keep in memory.
Disk configuration: affects storage capacity, IOPS, and throughput.
Network throughput: affects data transfer performance in and out of the VM.
Premium SSD support: indicates whether the size supports premium managed disks.
Hardware generation: indicates platform generation and can affect baseline performance.

Scale and resiliency options for VMs
You can run single VMs for testing, development, or minor tasks. Or you can group VMs together to provide high availability, scalability, and redundancy. Azure can manage these groupings with features such as scale sets and availability sets.

Virtual machine scale sets
Virtual machine scale sets let you create and manage groups of identical, load-balanced VMs. Without scale sets, you must manually keep VM configuration consistent, monitor utilization, and adjust instance counts. Scale sets centralize configuration and can automatically scale out or in based on demand or schedules. They also integrate with load balancing so traffic is distributed efficiently.

Virtual machine availability sets improve VM resiliency inside a region. They reduce the chance that all VMs are affected by one maintenance event or hardware failure.

Availability sets group VMs by:

Update domain: VMs that can be rebooted together during planned maintenance.
Fault domain: VMs that share a potential power or network failure point.

12.Azure virtual desktop
---
Azure Virtual Desktop is a desktop and application virtualization service in Azure. It lets users securely access Windows desktops and apps from many device types and locations.

At a fundamentals level, Azure Virtual Desktop is a managed option for remote desktop access where desktops and apps stay in the cloud instead of on local devices

When to use Azure Virtual Desktop
Use Azure Virtual Desktop when a team needs centralized desktop and app access across distributed users, contractors, or hybrid workers. For example, a support team can use standardized cloud-hosted desktops so each shift has the same tools, access policies, and security controls.

14.Azure containers

Containers are a virtualization environment. Much like running multiple virtual machines on a single physical host, you can run multiple containers on a single physical or virtual host. Unlike virtual machines, you don't manage the operating system for a container. Each virtual machine runs its own operating system that you can connect to and manage. Containers are lightweight and designed to be created, scaled out, and stopped dynamically. You can create and deploy virtual machines as application demand increases, but containers are a lighter-weight, more agile method. Containers help you respond to changes on demand and restart quickly after a crash or hardware interruption. One of the most popular container engines is Docker, and Azure supports Docker.

Azure Container Instances

Azure Container Instances offer the fastest and simplest way to run a container in Azure, without managing any virtual machines or adopting extra services. Azure Container Instances are a platform as a service (PaaS) offering. You upload your containers and the service runs them for you.

Azure Container Apps

Azure Container Apps are similar in many ways to a container instance. They let you get up and running right away, they remove the container management overhead, and they're a PaaS offering. Container Apps also include built-in load balancing and scaling, so your design can adapt to changing demand.

Azure Kubernetes Service

Azure Kubernetes Service (AKS) is a container orchestration service. An orchestration service manages the lifecycle of containers. When you're deploying a fleet of containers, AKS can make fleet management simpler and more efficient.

Use containers in your solutions
Containers are often used to create solutions that use a microservice architecture. In this architecture, you break solutions into smaller, independent pieces. For example, you might split a website into a container hosting your front end, another hosting your back end, and a third for storage. This split lets you maintain, scale, or update each part of your app independently.

# Key Takeaways

From this module, my main takeaways are:

1. Azure's physical infrastructure is organized into datacenters, regions, and availability zones.
2. Availability zones provide physical separation inside a region and can improve resiliency when workloads are designed to use them.
3. Region pairs provide geographic separation that can support disaster-recovery strategies.
4. Azure resources are organized inside resource groups.
5. Subscriptions provide billing and access-control boundaries.
6. Management groups provide a governance layer above subscriptions.
7. The Azure hierarchy helps organize resources and apply management policies consistently.

---

# Learning Evidence

Completed Microsoft Learn module:

- ✅ **Describe the core architectural components of Azure**

Achievement:  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/VSRTPTQM?sharingId=E81E8C29E6F06D32

---

## Next Step

Continue the **Azure Architecture & Services** learning path and document the next completed module before moving deeper into hands-on Azure infrastructure labs.
