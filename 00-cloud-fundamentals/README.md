# Lab 00 — Cloud Fundamentals

> Microsoft Learn progress: **Introduction to Cloud Infrastructure: Describe cloud concepts** 🏆 **Completed**

This section documents the cloud fundamentals I am learning as part of my Azure cloud engineering roadmap.  
The goal is not only to complete Microsoft Learn modules, but to explain the concepts in my own words and build a public record of my progress.

---

## 1. Cloud Computing

### What is cloud computing?

Cloud computing is the delivery of computing services over the internet.

Instead of purchasing and installing all infrastructure in advance, organizations can consume services such as:

- Virtual machines
- Storage
- Databases
- Networking
- Applications
- IoT services
- AI services

A major advantage is that infrastructure can be provisioned when it is needed and reduced again when demand decreases.

For example, if an application is expecting a large increase in traffic, additional cloud resources can be added without purchasing and installing new physical servers months in advance.

Cloud computing therefore helps organizations improve agility and align infrastructure usage with actual demand.

---

## 2. Shared Responsibility Model

In a traditional on-premises environment, the organization is responsible for almost the entire technology stack, including:

- Physical facilities
- Physical servers
- Networking equipment
- Operating systems
- Applications
- Security controls
- Data
- Identity and access

In cloud computing, responsibility is shared between the cloud provider and the customer.

The exact division of responsibility depends on the service model being used.

### IaaS — Infrastructure as a Service

With IaaS, the cloud provider manages the underlying physical infrastructure, while the customer still manages much of the software environment.

**Cloud provider responsibilities include:**

- Datacenter facilities
- Physical networking
- Physical servers
- Virtualization platform

**Customer responsibilities include:**

- Operating systems
- Applications
- Data
- Identity and access
- Security configuration
- Much of the virtual network configuration

IaaS provides the customer with the greatest level of control, but also the greatest management responsibility.

### PaaS — Platform as a Service

With PaaS, the cloud provider manages more of the technology stack.

The provider typically manages the physical infrastructure, virtualization platform, operating system, and platform runtime.

The customer focuses mainly on:

- Applications
- Data
- Identity and access
- Application configuration

PaaS reduces infrastructure-management effort compared with IaaS.

### SaaS — Software as a Service

With SaaS, the provider manages the application and almost the entire underlying platform.

The customer still remains responsible for important areas such as:

- Data
- User accounts
- Access decisions
- Service configuration
- How the service is used

The shared responsibility model does not disappear with SaaS; the provider simply manages a larger part of the stack.

---

## 3. Cloud Deployment Models

### Private cloud

A private cloud is a cloud environment dedicated to a single organization.

It provides a high level of control and isolation, but normally requires more infrastructure management and can be more expensive than using a public cloud.

### Public cloud

A public cloud is operated by a third-party cloud provider.

Customers consume computing resources from the provider without having to own or maintain the underlying physical infrastructure.

Microsoft Azure is an example of a public cloud platform.

### Hybrid cloud

A hybrid cloud combines private infrastructure with public cloud resources.

This allows workloads and data to operate across both environments.

For example, an organization may keep some workloads in a private datacenter while using Azure for additional capacity or cloud-native services.

Hybrid cloud can provide flexibility, but it also introduces additional networking, security, identity, and management complexity.

### Multicloud

A multicloud strategy uses services from more than one cloud provider.

Organizations may choose different providers because of technical requirements, commercial considerations, geographic coverage, or specific services.

Two Microsoft technologies related to hybrid and multicloud environments are:

- **Azure Arc** — helps organizations manage and govern resources across Azure, on-premises environments, and other clouds.
- **Azure VMware Solution** — enables VMware workloads to run on Azure infrastructure.

---

## 4. Consumption-Based Model

Cloud computing commonly uses a consumption-based pricing model.

Instead of purchasing large amounts of infrastructure before it is needed, customers pay for the resources and services they consume.

### CapEx vs OpEx

**Capital Expenditure (CapEx)** is upfront spending on physical assets.

Examples:

- Servers
- Switches
- Storage appliances
- Datacenter equipment

**Operational Expenditure (OpEx)** is ongoing spending on services and operations over time.

Cloud computing moves much of the infrastructure cost from large upfront purchases toward operational spending based on consumption.

Benefits of the consumption-based model include:

- Lower upfront infrastructure costs
- Reduced risk of purchasing unused capacity
- Ability to add resources when demand increases
- Ability to reduce resources when demand decreases
- Better alignment between infrastructure cost and actual usage

---

## 5. Elasticity

Elasticity is the ability to increase or decrease resources dynamically according to demand.

If demand increases, additional resources can be added.

If demand decreases, unnecessary resources can be removed.

The objective is to avoid two common problems:

- **Overprovisioning** — paying for infrastructure that remains unused
- **Underprovisioning** — not having enough resources to support the workload

Elasticity helps cloud environments balance performance requirements and cost.

---

# 6. Benefits of Cloud Services

## High Availability

High availability is the ability of a service to remain accessible and operational for as much time as possible.

Azure services provide different availability commitments depending on the service and architecture being used. These commitments can be defined through a **Service Level Agreement (SLA)**.

Availability is normally represented as a percentage.

For a 30-day month, the approximate maximum downtime would be:

| Availability | Approximate downtime |
|---|---:|
| 99% | 7 hours 12 minutes |
| 99.9% | 43 minutes 12 seconds |
| 99.99% | 4 minutes 19 seconds |

Higher availability normally requires additional redundancy and can increase cost and architectural complexity.

A cloud platform provides the components required to design highly available systems, but the application still needs to be architected correctly to use them.

---

## Scalability

Scalability is the ability to adjust computing resources when workload demand changes.

There are two main approaches:

### Vertical scaling — Scale up / Scale down

Vertical scaling changes the capacity of an existing resource.

Examples:

- Adding more CPU to a virtual machine
- Increasing RAM
- Moving to a larger VM size

### Horizontal scaling — Scale out / Scale in

Horizontal scaling changes the number of resources.

Examples:

- Adding more virtual machines
- Adding additional containers
- Removing instances when demand decreases

Horizontal scaling is especially useful for workloads that can distribute traffic across multiple instances.

---

## Reliability

Reliability is the ability of a system to continue operating correctly and recover from failures.

Cloud platforms provide capabilities that can help build reliable systems, including:

- Multiple geographic regions
- Availability zones
- Replication
- Backup
- Redundancy

However, using the cloud does **not automatically make an application reliable**.

The architecture must be designed to use redundancy and recovery mechanisms correctly.

For example, if an application is deployed only in one region, another Azure region remaining online does not automatically make that application available after a regional failure.

---

## Predictability

Cloud computing can improve predictability in two major areas.

### Performance predictability

Cloud services provide tools and capabilities that help manage workload performance, such as:

- Scaling
- Load distribution
- Monitoring
- Known service capacities
- Performance metrics

### Cost predictability

Cloud platforms also provide tools to help estimate and control spending.

Examples include:

- Consumption-based pricing
- Cost estimates
- Budgets
- Usage monitoring
- Cost analysis

Predictability does not mean costs or performance are automatic; they still need to be monitored and managed.

---

## Security

Cloud platforms provide many security services and controls, but security remains a shared responsibility.

The customer's responsibility changes depending on whether IaaS, PaaS, or SaaS is being used.

For example:

- With **IaaS**, the customer manages the operating system, installed software, access, and much of the configuration.
- With **PaaS**, the provider manages more of the platform and operating environment.
- With **SaaS**, the provider manages the application platform, while the customer still manages data, identities, access, and configuration.

Moving to a more managed cloud service reduces some operational responsibilities, but it does not remove the customer's security responsibilities.

---

## Governance

Cloud governance helps organizations control how resources are created, configured, and managed.

Governance can help organizations:

- Apply technical standards
- Support regulatory requirements
- Detect non-compliant resources
- Standardize deployments
- Control how cloud resources are used

Automation and reusable templates can also help ensure that infrastructure is deployed consistently.

---

## Manageability

Cloud resources can be managed in several different ways.

Examples include:

- Web portal
- Command-line interfaces
- PowerShell
- APIs
- Infrastructure templates
- Monitoring tools
- Alerts
- Autoscaling

This gives administrators and engineers multiple ways to manage infrastructure manually or through automation.

---

## Sustainability

Cloud environments can help reduce unnecessary resource consumption when they are managed efficiently.

Examples include:

- Scaling resources down when demand decreases
- Turning off or deallocating unused resources
- Avoiding unnecessary overprovisioning
- Monitoring resource usage
- Optimizing deployments over time

Sustainability is closely connected to efficient resource management: using only the capacity that is actually required.

---

# 7. Cloud Service Types

## Infrastructure as a Service (IaaS)

IaaS is the most flexible cloud service model and gives the customer the greatest amount of control over the cloud environment.

With IaaS, the organization is effectively renting infrastructure from a cloud provider while remaining responsible for how that infrastructure is configured and used.

Common use cases include:

- **Lift-and-shift migration** — recreating infrastructure similar to an existing on-premises environment and moving workloads into the cloud.
- **Development and testing** — creating temporary environments quickly and removing them when they are no longer needed.
- **Custom infrastructure requirements** — workloads that require greater control over operating systems, networking, or installed software.

## Platform as a Service (PaaS)

With PaaS, the cloud provider manages the underlying infrastructure as well as much of the operating environment.

This can include:

- Physical infrastructure
- Networking
- Operating systems
- Middleware
- Runtime environments
- Platform services

The customer can focus more on applications and data rather than maintaining the underlying platform.

Common use cases include:

- **Application development** — developers can build applications on a managed platform without managing the underlying operating system.
- **Analytics and business intelligence** — managed services can help process and analyze data without requiring teams to build the complete infrastructure themselves.

## Software as a Service (SaaS)

SaaS provides a complete application that is operated and maintained by the service provider.

The customer consumes the application rather than building and maintaining the underlying infrastructure or platform.

Common examples include:

- Email platforms
- Messaging applications
- Financial software
- Productivity and collaboration tools

The customer still manages areas such as users, access, data, and how the application is configured and used.

---

# Key Takeaways

From this learning path, my main takeaways are:

1. Cloud computing allows infrastructure to be provisioned when needed instead of always being purchased in advance.
2. Moving to the cloud does not remove customer responsibility; responsibility changes depending on the service model.
3. IaaS provides the most control but requires more management, while PaaS and SaaS move more responsibility to the provider.
4. Scalability and elasticity allow infrastructure capacity to follow workload demand.
5. High availability and reliability depend on architecture, not simply on using a cloud provider.
6. Cloud cost is strongly connected to resource usage, so monitoring and cleanup are important engineering responsibilities.
7. Security, governance, and manageability remain essential even when infrastructure is hosted in the cloud.
8. Choosing between IaaS, PaaS, and SaaS depends on how much control and management responsibility the organization needs.

---

# Learning Evidence

## Certification

- ✅ **Microsoft Certified: Azure Fundamentals (AZ-900)** — Earned October 2026  
  Microsoft Learn transcript: https://learn.microsoft.com/en-us/users/khalilamrene-2949/transcript/md40c1qx9wn9gg7?wt.mc_id=certnurture_eml14_email_wwl

Microsoft Learn learning path completed:

- ✅ **Describe cloud computing**
- ✅ **Describe the benefits of using cloud services**
- ✅ **Describe cloud service types**
- 🏆 **Introduction to Cloud Infrastructure: Describe cloud concepts — Trophy earned**

**Achievement:**  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/8VCAPLHW?sharingId=E81E8C29E6F06D32

This repository will continue to document my Azure learning path through theory, hands-on labs, architecture diagrams, automation, troubleshooting, and Infrastructure as Code.

---

## Next Step

The Azure fundamentals checkpoint is now complete:

- ✅ Cloud concepts learning path
- ✅ Azure architecture and services learning path
- ✅ Azure management and governance learning path
- ✅ Hands-on Azure Labs 01–03
- ✅ Microsoft Certified: Azure Fundamentals (AZ-900)

The next phase is **Terraform and Infrastructure as Code**, using Azure resources I already understand and rebuilding them through repeatable code.
