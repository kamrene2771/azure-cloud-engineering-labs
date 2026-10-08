# 02 — Azure Management & Governance

> Status: 🔄 **In progress**

This section documents my notes from the Azure **Management & Governance** learning path.

The goal is to understand how Azure resources are **costed, organized, controlled, monitored, and governed** before moving deeper into automation and Infrastructure as Code.

---

## Current Progress

### Covered so far

- ✅ Factors that affect Azure cost
- ✅ Azure Pricing Calculator
- ✅ Microsoft Cost Management
- ✅ Cost alerts and budgets
- ✅ Resource tags
- ✅ Cost optimization options

### Still to cover

- ⬜ Azure Policy
- ⬜ Resource locks
- ⬜ Azure RBAC in governance
- ⬜ Azure Monitor
- ⬜ Azure Advisor
- ⬜ Management tools
- ⬜ Infrastructure deployment approaches

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

---

## Cost Alerts

Cost Management provides a centralized location for several types of cost alerts.

The three alert types covered in the learning material are:

- **Budget alerts**
- **Credit alerts**
- **Department spending quota alerts**

---

## Budget Alerts

Budget alerts notify users when spending reaches or exceeds a configured threshold.

Budgets can be created through:

- Azure portal
- Azure Consumption API

In the Azure portal, budgets are based on **cost**.

Through the Azure Consumption API, budgets can also be defined using **consumption usage**.

When an alert condition is met:

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

A development team could create an alert at:

```text
80% of monthly dev/test budget
```

This gives the team time to investigate resource usage and optimize spending before the budget target is exceeded.

---

# 3 — Resource Tags

Tags are metadata attached to Azure resources.

They help organize resources and provide additional context about how and why a resource is being used.

A tag can represent information such as:

```text
Environment = Production
Owner       = Network-Team
Department  = IT
Workload    = Web-App
```

---

## Why Tags Matter

| Use case | Purpose |
|---|---|
| **Resource management** | Locate and group resources by workload, environment, team, or owner. |
| **Cost management and optimization** | Group resources for cost reporting, internal allocation, budgets, and forecasting. |
| **Operations management** | Group resources according to operational importance and availability requirements. |
| **Security** | Classify resources or data according to security level, such as public or confidential. |
| **Governance and compliance** | Identify resources associated with governance or regulatory requirements. |
| **Automation** | Identify groups of resources that automation tools can act on. |

### Example

A company could require resources to contain tags such as:

```text
Owner
Department
Environment
Application
```

This creates a consistent way to identify who owns a resource, what it belongs to, and how its cost should be classified.

### Key takeaway

Tags do not change the technical behavior of the resource by themselves.

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

Azure provides different purchasing options depending on workload behavior.

The three options covered so far are:

- Reservations
- Azure savings plan for compute
- Spot pricing

---

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

---

## Azure Savings Plan for Compute

Azure savings plan for compute is also based on a commitment.

Instead of committing to a specific VM family or instance type, you commit to an **hourly spend amount** for:

```text
1 year
or
3 years
```

Savings are then applied to eligible compute usage.

### Best suited for

Workloads with relatively consistent compute spending where more flexibility is required across compute services.

---

## Spot Pricing

Spot Virtual Machines use unused Azure capacity at a reduced price.

The tradeoff is that Azure can reclaim the capacity when it is needed elsewhere.

### Best suited for

Workloads that are:

- Interruptible
- Fault tolerant
- Able to restart or recover
- Highly cost sensitive

---

## Quick Decision Guide

| Workload | Better fit |
|---|---|
| Predictable, long-running, stable resource requirement | **Reservations** |
| Predictable compute spend but more flexibility required | **Azure savings plan for compute** |
| Interruptible workload where lowest price is the priority | **Spot pricing** |

A simple mental model:

```text
Stable resource requirement
        ↓
Reservations

Stable compute spending + flexibility
        ↓
Savings Plan

Interruptible workload
        ↓
Spot
```
5.the purpose of Microsoft Purview

Microsoft Purview is a family of data governance, risk, and compliance solutions that helps you get a single, unified view into your data. Microsoft Purview brings insights about your on-premises, multicloud, and software-as-a-service data together.

With Microsoft Purview, you can stay up-to-date on your data landscape thanks to:

Automated data discovery
Sensitive data classification
End-to-end data lineage

6.the purpose of Azure Policy

Azure Policy is a service in Azure that enables you to create, assign, and manage policies that control or audit your resources. These policies enforce different rules across your resource configurations so that those configurations stay compliant with your standards.

How does Azure Policy define policies?

Azure Policy enables you to define both individual policies and groups of related policies, known as initiatives. Azure Policy evaluates your resources and highlights resources that aren't compliant with the policies you've created. Azure Policy can also prevent noncompliant resources from being created.

Azure Policies can be set at each level, enabling you to set policies on a specific resource, resource group, subscription, and so on. Additionally, Azure Policies are inherited, so if you set a policy at a high level, it will automatically be applied to all of the groupings that fall within the parent. For example, if you set an Azure Policy on a resource group, all resources created within that resource group will automatically receive the same policy.

Policy guardrails for AI-assisted changes
If teams use Copilot recommendations or agent-like automation, Azure Policy still enforces your standards. You can require allowed locations, required tags, approved resource SKUs, and security baseline controls regardless of how a change was proposed.

What are Azure Policy initiatives?
An Azure Policy initiative is a way of grouping related policies together. The initiative definition contains all of the policy definitions to help track your compliance state for a larger goal.

For example, Azure Policy includes an initiative named Enable Monitoring in Azure Security Center. Its goal is to monitor all available security recommendations for all Azure resource types in Azure Security Center.

Under this initiative, the following policy definitions are included:

Monitor unencrypted SQL Database in Security Center This policy monitors for unencrypted SQL databases and servers.

Monitor OS vulnerabilities in Security Center This policy monitors servers that don't satisfy the configured OS vulnerability baseline.

Monitor missing Endpoint Protection in Security Center This policy monitors for servers that don't have an installed endpoint protection agent.

7.the purpose of resource locks

There are two types of resource locks, one that prevents users from deleting and one that prevents users from changing or deleting a resource.

Delete means authorized users can still read and modify a resource, but they can't delete the resource.
ReadOnly means authorized users can read a resource, but they can't delete or update the resource. Applying this lock is similar to restricting all authorized users to the permissions granted by the Reader role.

8.the purpose of the Service Trust portal

The Microsoft Service Trust Portal is a portal that provides access to various content, tools, and other resources about Microsoft security, privacy, and compliance practices.

The Service Trust Portal contains details about Microsoft's implementation of controls and processes that protect our cloud services and customer data. To access some of the resources on the Service Trust Portal, you must sign in as an authenticated user with your Microsoft cloud services account (Microsoft Entra work or school account). You'll need to review and accept the Microsoft non-disclosure agreement for compliance materials.

The Service Trust Portal features and content are accessible from the main menu. The categories on the main menu are:

Service Trust Portal provides a quick access hyperlink to return to the Service Trust Portal home page.
My Library lets you save (or pin) documents to quickly access them on your My Library page. You can also set up to receive notifications when documents in your My Library are updated.
All Documents is a single landing place for documents on the service trust portal. From All Documents, you can pin documents to have them show up in your My Library.

9.tools for interacting with Azure
To get the most out of Azure, you need a way to interact with the Azure environment, the management groups, subscriptions, resource groups, resources, and so on. Azure provides multiple tools for managing your environment, including the:

Azure portal
Azure PowerShell
Azure Command Line Interface (CLI)

AI-assisted operations with Copilot in Azure
Copilot in Azure is an AI assistant experience that can help administrators work faster by providing contextual guidance in natural language. Depending on your environment, some Copilot workflows can be agent-like, where the assistant helps coordinate multi-step tasks.

At a fundamentals level, treat Copilot as an operational assistant. You should still validate recommendations, confirm permissions, and review deployment changes before applying them in production.

What is the Azure portal?

The Azure portal is a web-based, unified console that provides an alternative to command-line tools. With the Azure portal, you can manage your Azure subscription by using a graphical user interface. You can:

Build, manage, and monitor everything from simple web apps to complex cloud deployments
Create custom dashboards for an organized view of resources
Configure accessibility options for an optimal experience

10.the purpose of Azure Arc

Managing hybrid and multicloud environments can rapidly get complicated. Azure provides a host of tools to provision, configure, and monitor Azure resources. What about the on-premises resources in a hybrid configuration or the cloud resources in a multicloud configuration?

Azure Arc works with Azure Resource Manager to extend your Azure compliance and monitoring to hybrid and multicloud configurations. Azure Arc simplifies governance and management by delivering a consistent multicloud and on-premises management platform.

Azure Arc provides a centralized, unified way to:

Manage your entire environment together by projecting your existing non-Azure resources into Azure Resource Manager.
Manage multicloud and hybrid virtual machines, Kubernetes clusters, and databases as if they are running in Azure.
Use familiar Azure services and management capabilities, regardless of where they live.
Continue using traditional ITOps while introducing DevOps practices to support new cloud and native patterns in your environment.
Configure custom locations as an abstraction layer on top of Azure Arc-enabled Kubernetes clusters and cluster extensions.

11.Azure Resource Manager and Azure ARM templates

Azure Resource Manager is the deployment and management service for Azure. It provides a management layer that enables you to create, update, and delete resources in your Azure account. Anytime you do anything with your Azure resources, Azure Resource Manager is involved.

When a user sends a request from any of the Azure tools, APIs, or SDKs, Azure Resource Manager receives the request. Azure Resource Manager authenticates and authorizes the request. Then, Azure Resource Manager sends the request to the Azure service, which takes the requested action. You see consistent results and capabilities in all the different tools because all requests are handled through the same API.

Azure Resource Manager benefits

With Azure Resource Manager, you can:

Manage your infrastructure through declarative templates rather than scripts. A Resource Manager template is a JSON file that defines what you want to deploy to Azure.
Deploy, manage, and monitor all the resources for your solution as a group, rather than handling these resources individually.
Re-deploy your solution throughout the development life-cycle and have confidence your resources are deployed in a consistent state.
Define the dependencies between resources, so they're deployed in the correct order.
Apply access control to all services because RBAC is natively integrated into the management platform.
Apply tags to resources to organize your subscription and support cost reporting.

12.Infrastructure as code

Infrastructure as code (IaC) means managing infrastructure through code and templates instead of manual configuration. At a fundamentals level, this can start with Azure CLI or Azure PowerShell and grow into repeatable environment deployments by using Azure Resource Manager templates and Bicep.

Azure Resource Manager templates

Azure Resource Manager templates describe desired Azure resources in declarative JSON. Azure validates the template before deployment, then orchestrates resource creation in the right order and in parallel when possible. Teams define the desired end state, and Azure Resource Manager handles deployment execution.

Templates can also call PowerShell or Bash deployment scripts when setup steps are needed before or after resource creation.

Benefits of using Azure Resource Manager templates
Azure Resource Manager templates provide several key benefits:

Declarative syntax: Define what to deploy instead of writing step-by-step deployment commands.
Repeatable results: Reuse the same template across environments for consistent outcomes.
Orchestration: Azure Resource Manager handles dependency order and parallel deployment automatically.
Modularity: Split templates into reusable components and nested templates.
Extensibility: Add deployment scripts when additional setup actions are required.

Bicep
Bicep is a declarative language for deploying Azure resources through ARM. Compared to JSON ARM templates, Bicep is generally simpler and more concise.

Benefits of Bicep include:

Support for current Azure resources: Bicep tracks Azure resource types and API versions.
Simple syntax: Bicep is easier to read and write than equivalent JSON templates.
Repeatable deployments: Bicep files are idempotent for consistent lifecycle deployments.
Built-in orchestration: Azure Resource Manager handles dependencies and parallel deployment execution.
Modularity: Reuse logic by organizing deployments into Bicep modules.

13.the purpose of Azure Advisor

Azure Advisor evaluates your Azure resources and makes recommendations to help you improve reliability, security, performance, and cost efficiency. Think of it as a personalized best-practices guide built into the Azure portal. Each recommendation includes a suggested action you can take right away, postpone, or dismiss.

The Advisor dashboard displays recommendations for all your subscriptions, and you can filter by subscription, resource group, or service. Recommendations fall into five categories:

Reliability helps keep your applications running by flagging configuration risks.
Security detects threats and vulnerabilities that could lead to breaches.
Performance identifies changes that can speed up your applications.
Operational Excellence suggests workflow and deployment improvements.
Cost finds ways to reduce your Azure spending.

14.Azure Service Health

Azure Service Health helps you stay informed about the health of Azure itself and the specific resources you run. It combines three views that narrow in scope from global down to individual resources.

Three health views
Azure Status gives you a global picture of Azure health across all services and regions. Check this page when you hear about a widespread outage and want to know whether it affects Azure.
Service Health focuses on the Azure services and regions you actually use. Because you're signed in, Service Health knows which services matter to you and shows outages, planned maintenance, and health advisories relevant to your environment. You can set up alerts so you're notified automatically.
Resource Health zooms in on individual resources, such as a specific virtual machine. It tells you whether a resource is running normally or experiencing a problem, and whether the issue is on Azure's side or yours.

15.Azure Monitor
Azure Monitor is a platform for collecting, analyzing, and acting on data from your Azure resources and applications. It works with Azure, on-premises, and multicloud environments.

Azure Log Analytics
Log Analytics is the tool in the Azure portal where you write and run queries against the data Azure Monitor collects. You can do simple filtering, like finding all errors in the last hour, or run advanced analytics to visualize trends over time.

Azure Monitor Alerts
Alerts notify you when Azure Monitor detects that a condition you defined has been met. You create an alert rule that specifies the condition, and an action group that controls who gets notified and what happens next.


---

# What I Should Be Able to Explain

Before considering this part complete, I should be able to explain:

- What factors influence Azure cost
- What the Azure Pricing Calculator is used for
- What Microsoft Cost Management provides
- The purpose of budgets and cost alerts
- Why organizations use tags
- How tags support cost management, operations, security, governance, and automation
- The difference between Reservations, Savings Plans, and Spot pricing
- Which cost optimization option fits a given workload

---

# Next

Continue the Management & Governance learning path with:

```text
Azure Policy
Resource Locks
RBAC
Monitoring
Advisor
Management Tools
Deployment Approaches
```

The objective is not only to memorize Azure services, but to understand how governance decisions affect real cloud infrastructure.
