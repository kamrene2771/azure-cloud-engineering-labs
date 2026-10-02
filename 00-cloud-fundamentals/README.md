## Lab 00 — Cloud Fundamentals

## 1. Cloud Computing

### What is cloud computing?

Cloud computing is delivering computing services over the internet,that means common it infrastructure as VMs,storage,databases,networks,IOT,Ai.
and because internet is the support,cloud consumers are not limited by physical infrastructure like traditional datacenters are.
for example if a customer is expecting high traffic season or they are launching a new product,they are not supposed to deploy infrastructure months in advance instead expand their cloud computing capacity also the ability to scale down afterward.
cloud computing improves agility and lines spending to demand.
 
## Shared Responsibility Model

In traditional infras the IT departement is responsible for physical space,ensuring secrurity,maintaining equipment and servers replacing if anything happens with cloud computing this responsiblity is shared between cloud provider and customer.
the weight of responsibilty for each party is defined by the service model iaas,paas,saas

### IaaS vs PaaS vs SaaS

Iaas infrastructure as a service the provider is responsible for datacenters,networks,physical host,infrastructures
the cutomer is responsible for operating systems,network controls,applications,identity and access
paas platform as a service the shared responsibility model shifts, provider is reponsible alone up to the operating systems ,shares responsibility up to idetity and access with customer
saas software as a service the provider is responsible for the application so the customer only have data,accounts to maintain.

### private cloud vs public cloud vs hybrid cloud vs multicloud

###PRIVATE

a private cloud is the natural development of traditional datacenters its deployed and managed by single entity. data will no be collocated with other tenants .
great cost and fewer of the benefits of public cloud.

###PUBLIC

is controlled maintained by a third-party cloud provider.

###HYBRID

computing environment that uses both public and private clouds in an inte-connected environment, this allows private cloud to apply temporary public cloude resources
It can help keep specific workloads/data private, but the architecture itself can also increase complexity and security responsibility

###MULTICLOUD

using multiple public cloud providers maybe using differente features from different cloud providers
AZURE Arc is a way to manage and govern resources across Azure, on-premises and other clouds from Azure 
Azure Vmware solution is specifically for running VMware workloads on Azure infrastructure.

### Consumption-based model

cloud computing operates on consumption based model, you pay for ressources used .
in traditional IT budgeting we have : capEX , opEX
capitale expenditure is up-front spending on physical infra ex servers,network equipments.
operational expenditure is the spending on services over time

cloud consumption based model offer benefits as no upfront costs ,no need to purchase underutilized capacity also add resources when demand increase, release when demand decreases.

### Elasticity
its lining demands with resources so never in waste or shortfall:
overspend on infrastructure that sits idle. 
Underestimate, and your applications suffer degraded performance.

## 2. Benefits of Cloud Services

### High Availability

when deploying a cloud application should considerate availability and scale. 
Azure is a highly available cloud environment with uptime guarantees depending on the service .these guarantees are part of SLAs
azure SLAs is the agreement between the provider and the customer
therefore its represented by a percentage % a high service availability can be 99% to 100% available.
in reality 100% available service is very expensive and difficult to achieve cause it allows no time for required maintenance or upgrades .
a 99% service can be down up to 7.2hrs a month.
a 99.9% service can be down up to 43.2 min a month
each azure service has its own SLA.

### Scalability

is adjusting resources to match demand , if suddenly you experience peak traffic the ability to scale means adding more ressources.
Vertical Scaling: add more CPUs or RAM to the virtual machine.
Horizontal Scaling: add additional virtual machines or containers.

### Reliability
is the ability to recover from failures to function .
the cloud has a Decentralized design which by nature supports a reliable and resilient infrastructure.
With a decentralized design, the cloud enables you to have resources deployed in regions around the world. With this global scale, even if one region has a catastrophic event other regions are still up and running

### Predictability
with cloud you predict both performance and cost so you move forward with confidence. 
### Security
c
### Governance
### Manageability
### Sustainability
