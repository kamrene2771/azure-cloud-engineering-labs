# 01 — Azure Architecture & Services

> Status: 🔄 **In progress**

This section will document my understanding of Azure architecture and core services as I progress through Microsoft Learn.

## Topics

- Azure regions
- Region pairs
- Availability zones
- Azure resources
- Resource groups
- Subscriptions
- Management groups
- Azure Resource Manager
- Compute services
- Azure Virtual Networks
- Storage services
- Identity and access
- Azure security services

1. what is microsoft Azure
   azure is a Microsoft cloud computing platform with expanding cloud services.
   What does Azure offer?
Limitless innovation. Build intelligent apps and solutions with advanced technology, tools, and services to take your operations to the next level. Seamlessly unify your technology to simplify platform management and deliver innovations efficiently and securely on a trusted cloud.

Bring ideas to life: Build on a trusted platform to advance your team's capabilities with industry-leading AI and cloud services.
Seamlessly unify: Efficiently manage all your infrastructure, data, analytics, and AI solutions across an integrated platform.
Innovate on trust: Rely on trusted technology from a partner who's dedicated to security and responsibility.

Azure provides hundreds of services that enable you to do everything from running your existing applications on virtual machines to exploring new software paradigms, such as intelligent bots and generative AI.

COMPUTE
NETWORKING
STORAGE
DATABASES
AI+ML
IDENTITY + SECURITY
DEVOPS + MANAGEMENT
IOT
ANALYTICS
INTEGRATION

2.Physical infrastructure

azure infrastructure starts with datacenters. these datacenters are facilities with servers arranged in racks,with dedicated power, cooling and networking only its a much larger scale.

3.Regions

a region is a geographical area on the planet that contains at least one or multiple datacenters that are nearby and betworked together with a low-latency network.

4.availability zones

availability zones are physically separate datacenters within an Azure region. Each availability zone is made up of one or more datacenters equipped with independent power, cooling, and networking. An availability zone is set up to be an isolation boundary. If one zone goes down, the other continues working.
However, not all Azure Regions currently support availability zones.

Azure services that support availability zones fall into three categories:

Zonal services: You pin the resource to a specific zone (for example, VMs, managed disks, IP addresses).
Zone-redundant services: The platform replicates automatically across zones (for example, zone-redundant storage, SQL Database).
Non-regional services: Services are always available from Azure geographies and are resilient to zone-wide outages as well as region-wide outages.

Region pairs
Most Azure regions are paired with another region within the same geography (such as US, Europe, or Asia) at least 300 miles away. This approach allows for the replication of resources across a geography that helps reduce the likelihood of interruptions because of events such as natural disasters, civil unrest, power outages, or physical network outages that affect an entire region.

Sovereign Regions
In addition to regular regions, Azure also has sovereign regions. Sovereign regions are instances of Azure that are isolated from the main instance of Azure. You may need to use a sovereign region for compliance or legal purposes.

3.Azure management infrastructure


## Learning Notes

Notes will be added only after I complete and understand each topic.

## Evidence

This section will contain:

- Concepts explained in my own words
- Architecture diagrams where useful
- Comparisons between Azure services
- Practical design observations
- Links to related hands-on labs

## Next Step

Continue Microsoft Learn **Azure Architecture & Services** and document each completed section here.
