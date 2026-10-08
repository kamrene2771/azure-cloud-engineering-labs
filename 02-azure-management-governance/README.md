# 02 — Azure Management & Governance

> Status: ✅ **Completed**

This section documents my notes from the Azure **Management & Governance** learning path.

🏆 **Learning path trophy: Introduction to Cloud Infrastructure: Describe Azure management and governance**  
https://learn.microsoft.com/api/achievements/share/en-us/khalilamrene-2949/9A597CGU?sharingId=E81E8C29E6F06D32

The objective is to understand how Azure resources are **costed, organized, governed, deployed, monitored, and managed** before moving deeper into automation and Infrastructure as Code.

## Achievement

🏆 **Microsoft Learn trophy earned:**  
**Introduction to Cloud Infrastructure: Describe Azure management and governance**

---

## Current Progress

### Completed topics

- ✅ Factors that affect Azure cost
- ✅ Azure Pricing Calculator
- ✅ Microsoft Cost Management
- ✅ Cost alerts and budgets
- ✅ Resource tags
- ✅ Cost optimization options
- ✅ Microsoft Purview
- ✅ Azure Policy and initiatives
- ✅ Resource locks
- ✅ Microsoft Service Trust Portal
- ✅ Azure management tools
- ✅ Copilot in Azure
- ✅ Azure Arc
- ✅ Azure Resource Manager
- ✅ ARM templates
- ✅ Infrastructure as Code
- ✅ Bicep
- ✅ Azure Advisor
- ✅ Azure Service Health
- ✅ Azure Monitor
- ✅ Log Analytics
- ✅ Azure Monitor Alerts

---

# 1 — Factors That Affect Azure Costs

Azure cost is influenced by several factors.

| Factor | Why it matters |
|---|---|
| **Resource type** | Different Azure services and SKUs have different pricing models. |
| **Consumption** | The amount of compute, storage, bandwidth, or other resources consumed affects cost. |
| **Maintenance** | Operational and lifecycle requirements can influence the total cost of a solution. |
| **Geography** | Pricing can vary between Azure regions. |
| **Subscription type** | Different subscription and purchasing models can affect pricing. |
| **Azure Marketplace** | Third-party products may introduce additional charges. |

The important idea is that Azure cost is not determined by a single value. Architecture, usage, region, and purchasing model all contribute to the final bill.

---

## Azure Pricing Calculator

The **Azure Pricing Calculator** is used to estimate the expected cost of Azure resources before deployment.

It can be used to:

- Estimate the cost of an individual resource
- Build an estimate for a complete solution
- Compare service tiers
- Compare regions
- Compare redundancy and configuration options

### Example

```text
App Service
    +
Managed Database
    +
Storage
    =
Estimated monthly Azure cost
```

The configuration can then be changed to compare regions, service tiers, and redundancy options before resources are deployed.

### Key takeaway

```text
Pricing Calculator
        ↓
Estimate before deployment
```

It helps with **planning**. It does not replace monitoring the real cost of deployed resources.

---

# 2 — Microsoft Cost Management

**Microsoft Cost Management** provides tools to understand and control Azure spending.

It can be used to:

- Review Azure resource costs
- Track spending
- Create budgets
- Configure cost alerts
- Identify when spending approaches predefined thresholds

## Cost Alerts

The three alert types covered in the learning material are:

- **Budget alerts**
- **Credit alerts**
- **Department spending quota alerts**

## Budget Alerts

Budget alerts notify users when spending reaches or exceeds a configured threshold.

Budgets can be created through:

- Azure portal
- Azure Consumption API

In the Azure portal, budgets are based on **cost**.

Through the Azure Consumption API, budgets can also be defined using **consumption usage**.

```text
Configured budget threshold reached
                ↓
          Budget alert
                ↓
        Cost alert generated
                ↓
       Notification sent
```

### Example

```text
80% of monthly dev/test budget
```

This gives the team time to investigate resource usage and optimize spending before the budget target is exceeded.

---

# 3 — Resource Tags

Tags are metadata attached to Azure resources.

They help organize resources and provide context about how and why a resource is being used.

### Example

```text
Environment = Production
Owner       = Network-Team
Department  = IT
Workload    = Web-App
```

## Why Tags Matter

| Use case | Purpose |
|---|---|
| **Resource management** | Locate and group resources by workload, environment, team, or owner. |
| **Cost management and optimization** | Group resources for cost reporting, internal allocation, budgets, and forecasting. |
| **Operations management** | Group resources according to operational importance and availability requirements. |
| **Security** | Classify resources or data according to security level, such as public or confidential. |
| **Governance and compliance** | Identify resources associated with governance or regulatory requirements. |
| **Automation** | Identify groups of resources that automation tools can act on. |

### Key takeaway

Tags do not change the technical behavior of a resource by themselves.

Their value comes from making resources easier to:

```text
Find
Organize
Report
Govern
Automate
```

---

# 4 — Azure Cost Optimization Options

The three options covered are:

- Reservations
- Azure savings plan for compute
- Spot pricing

## Reservations

Reservations are designed for **stable and predictable workloads**.

You commit to specific resource capacity for:

```text
1 year
or
3 years
```

Azure then applies discounted pricing to matching usage.

### Best suited for

Long-running workloads where the required resources are known and relatively stable.

## Azure Savings Plan for Compute

Azure savings plan for compute is also based on a commitment.

Instead of committing to a specific VM family or instance type, you commit to an **hourly spend amount** for one or three years.

### Best suited for

Workloads with relatively consistent compute spending where more flexibility is required across compute services.

## Spot Pricing

Spot Virtual Machines use unused Azure capacity at a reduced price.

Azure can reclaim that capacity when needed.

### Best suited for

Workloads that are:

- Interruptible
- Fault tolerant
- Able to restart or recover
- Highly cost sensitive

## Quick Decision Guide

| Workload | Better fit |
|---|---|
| Predictable, long-running, stable resource requirement | **Reservations** |
| Predictable compute spend but more flexibility required | **Azure savings plan for compute** |
| Interruptible workload where lowest price is the priority | **Spot pricing** |

---

# 5 — Microsoft Purview

**Microsoft Purview** is a family of data governance, risk, and compliance solutions that provides a unified view into data.

It can bring together insights about:

- On-premises data
- Multicloud data
- Software-as-a-Service data

Key capabilities covered include:

- Automated data discovery
- Sensitive data classification
- End-to-end data lineage

### Mental model

```text
Different data sources
        ↓
Microsoft Purview
        ↓
Discover
Classify
Track lineage
Govern
```

---

# 6 — Azure Policy

**Azure Policy** enables organizations to create, assign, and manage policies that control or audit Azure resources.

Policies enforce rules across resource configurations so that resources stay compliant with organizational standards.

Azure Policy can:

- Evaluate resources
- Identify non-compliant resources
- Prevent non-compliant resources from being created
- Apply governance rules at different Azure scopes

## Scope and Inheritance

Policies can be assigned at different levels, including:

```text
Higher-level scope
      ↓
Resource Group
      ↓
Resources
```

Policies assigned at a parent scope are inherited by resources below that scope.

## Policy Initiatives

An **initiative** groups related policy definitions together so that compliance can be tracked against a larger goal.

```text
Initiative
   |
   +-- Policy 1
   +-- Policy 2
   +-- Policy 3
```

The learning material uses monitoring recommendations in Azure Security Center as an example of related policies grouped into an initiative.

## Policy Guardrails for AI-Assisted Changes

If teams use Copilot recommendations or agent-like automation, Azure Policy can still enforce organizational standards.

Examples include requiring:

- Allowed locations
- Required tags
- Approved resource SKUs
- Security baseline controls

### Key takeaway

The method used to propose a change does not bypass Azure governance controls.

---

# 7 — Resource Locks

Resource locks help protect Azure resources from accidental changes or deletion.

Two lock types are covered:

| Lock | Effect |
|---|---|
| **Delete** | Authorized users can read and modify the resource, but cannot delete it. |
| **ReadOnly** | Authorized users can read the resource, but cannot update or delete it. |

A **ReadOnly** lock is similar to restricting users to read-only behavior for the locked resource.

### Mental model

```text
Delete lock
    → modify ✅
    → delete ❌

ReadOnly lock
    → read ✅
    → modify ❌
    → delete ❌
```

---

# 8 — Microsoft Service Trust Portal

The **Microsoft Service Trust Portal** provides access to information about Microsoft's security, privacy, and compliance practices.

It contains details about Microsoft's implementation of controls and processes used to protect cloud services and customer data.

Some resources require:

- Authentication using a Microsoft Entra work or school account
- Acceptance of Microsoft's non-disclosure agreement for compliance materials

## Main Areas

### Service Trust Portal

Provides a quick path back to the portal home page.

### My Library

Allows users to save documents for quick access and receive notifications when saved documents are updated.

### All Documents

Provides a central location for documents available through the Service Trust Portal.

---

# 9 — Tools for Interacting with Azure

Azure provides multiple tools for managing Azure environments.

The tools covered include:

- Azure portal
- Azure PowerShell
- Azure Command Line Interface (CLI)

## Azure Portal

The Azure portal is a web-based unified console for managing Azure resources through a graphical interface.

It can be used to:

- Build resources
- Manage deployments
- Monitor resources
- Create custom dashboards
- Configure accessibility options

## Copilot in Azure

Copilot in Azure is an AI assistant experience that can provide contextual guidance using natural language.

Some workflows can be agent-like and help coordinate multi-step tasks.

At a fundamentals level, Copilot should be treated as an **operational assistant**.

Recommendations, permissions, and proposed deployment changes should still be validated before they are applied in production.

---

# 10 — Azure Arc

**Azure Arc** extends Azure Resource Manager management capabilities to hybrid and multicloud environments.

It provides a centralized way to manage resources that are not necessarily running inside Azure.

Azure Arc can help manage:

- Hybrid virtual machines
- Multicloud virtual machines
- Kubernetes clusters
- Databases
- Other supported non-Azure resources

## Why Azure Arc Matters

Azure Arc can:

- Project non-Azure resources into Azure Resource Manager
- Provide a consistent management experience
- Extend governance and monitoring beyond Azure
- Support traditional ITOps while introducing DevOps practices
- Configure custom locations on top of Azure Arc-enabled Kubernetes clusters and extensions

### Mental model

```text
Azure
On-premises
Other clouds
     ↓
 Azure Arc
     ↓
Azure Resource Manager
     ↓
Unified management and governance
```

---

# 11 — Azure Resource Manager and ARM Templates

**Azure Resource Manager (ARM)** is the deployment and management service for Azure.

Whenever a user sends a request through Azure tools, APIs, or SDKs, Azure Resource Manager receives the request.

```text
Portal / CLI / PowerShell / API / SDK
                ↓
      Azure Resource Manager
                ↓
   Authentication + Authorization
                ↓
          Azure service
                ↓
        Requested action
```

Because the same management layer processes requests, Azure tools provide consistent management capabilities.

## Azure Resource Manager Benefits

Azure Resource Manager can:

- Manage infrastructure through declarative templates rather than scripts
- Deploy and manage related resources as a group
- Re-deploy solutions consistently
- Define dependencies between resources
- Apply RBAC through the management platform
- Apply tags for organization and cost reporting

## ARM Templates

An ARM template is a JSON file that defines the Azure resources that should be deployed.

The desired infrastructure is declared in the template, and Azure Resource Manager handles deployment execution.

---

# 12 — Infrastructure as Code

**Infrastructure as Code (IaC)** means managing infrastructure through code and templates instead of manual configuration.

At a fundamentals level, this can begin with:

- Azure CLI
- Azure PowerShell

and progress toward repeatable deployments with:

- ARM templates
- Bicep

## ARM Template Benefits

| Benefit | Meaning |
|---|---|
| **Declarative syntax** | Define what should exist instead of writing every deployment step. |
| **Repeatable results** | Reuse the same template across environments. |
| **Orchestration** | ARM handles dependency order and parallel deployment. |
| **Modularity** | Split deployments into reusable components or nested templates. |
| **Extensibility** | Add PowerShell or Bash deployment scripts when extra setup is required. |

## Bicep

**Bicep** is a declarative language for deploying Azure resources through Azure Resource Manager.

Compared with JSON ARM templates, Bicep is generally simpler and more concise.

Benefits covered include:

- Support for current Azure resources
- Simpler syntax
- Repeatable deployments
- Built-in orchestration
- Modularity through Bicep modules

### Mental model

```text
Manual configuration
        ↓
Infrastructure as Code
        ↓
Repeatable infrastructure
        ↓
ARM / Bicep
```

---

# 13 — Azure Advisor

**Azure Advisor** evaluates Azure resources and provides recommendations to improve the environment.

Recommendations fall into five categories:

| Category | Purpose |
|---|---|
| **Reliability** | Identify configuration risks that can affect availability. |
| **Security** | Detect threats and vulnerabilities. |
| **Performance** | Identify changes that can improve application performance. |
| **Operational Excellence** | Suggest improvements to workflows and deployments. |
| **Cost** | Identify opportunities to reduce spending. |

Recommendations can be acted on, postponed, or dismissed.

### Key takeaway

Azure Advisor acts as a personalized best-practices guide for Azure resources.

---

# 14 — Azure Service Health

**Azure Service Health** helps track the health of Azure and the services and resources being used.

The learning material divides health visibility into three levels.

| Tool | Scope |
|---|---|
| **Azure Status** | Global Azure health across services and regions |
| **Service Health** | Services and regions relevant to the signed-in environment |
| **Resource Health** | Health of an individual Azure resource |

## Azure Status

Provides a global view of Azure service health.

## Service Health

Shows outages, planned maintenance, and health advisories relevant to the Azure services and regions being used.

Alerts can be configured.

## Resource Health

Shows whether an individual resource is operating normally and can help identify whether an issue is related to Azure or the resource itself.

### Mental model

```text
Azure Status
   Global Azure

Service Health
   My services and regions

Resource Health
   My individual resource
```

---

# 15 — Azure Monitor

**Azure Monitor** is a platform for collecting, analyzing, and acting on data from Azure resources and applications.

It can work with:

- Azure environments
- On-premises environments
- Multicloud environments

## Log Analytics

**Log Analytics** is the Azure portal tool used to write and run queries against data collected by Azure Monitor.

It can be used for:

- Filtering data
- Finding errors
- Investigating recent events
- Analyzing trends over time

## Azure Monitor Alerts

Alerts notify users when a defined monitoring condition is met.

An alert includes:

```text
Alert rule
    +
Condition
    +
Action group
    =
Notification or action
```

The **alert rule** defines what should be monitored.

The **action group** controls who is notified and what happens when the condition is triggered.

---

# What I Should Be Able to Explain

Before considering this section complete, I should be able to explain:

- What factors influence Azure cost
- What the Azure Pricing Calculator is used for
- What Microsoft Cost Management provides
- How budgets and cost alerts work
- Why organizations use tags
- The difference between Reservations, Savings Plans, and Spot pricing
- What Microsoft Purview provides
- What Azure Policy does
- The difference between a policy and an initiative
- How policy inheritance works
- The difference between Delete and ReadOnly resource locks
- What the Microsoft Service Trust Portal provides
- The differences between Azure portal, PowerShell, and CLI as management tools
- How Copilot in Azure fits into Azure operations
- What Azure Arc provides for hybrid and multicloud management
- The role of Azure Resource Manager
- What ARM templates are
- What Infrastructure as Code means
- Why Bicep is used
- What Azure Advisor evaluates
- The difference between Azure Status, Service Health, and Resource Health
- What Azure Monitor does
- What Log Analytics is used for
- How Azure Monitor alerts and action groups work

---

# Core Mental Model

```text
Cost Management
    → understand and control spending

Tags
    → organize and classify resources

Purview
    → govern and understand data

Azure Policy
    → enforce standards

Resource Locks
    → protect resources from changes/deletion

Service Trust Portal
    → security, privacy, and compliance information

Portal / CLI / PowerShell / Copilot
    → interact with Azure

Azure Arc
    → extend Azure management to hybrid/multicloud

Azure Resource Manager
    → management and deployment layer

ARM / Bicep
    → declarative infrastructure deployment

Azure Advisor
    → best-practice recommendations

Service Health
    → Azure platform and resource health

Azure Monitor
    → collect, analyze, alert
```

The objective is not only to memorize Azure services, but to understand **which management or governance problem each service solves**.
