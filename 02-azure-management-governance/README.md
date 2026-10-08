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
