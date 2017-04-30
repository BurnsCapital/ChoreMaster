![task flow](/img/choresLogo.png)

# ChoreMaster
Simple smart contract managed chore management aka parenting on the blockchain

## Items needed
Budget/parent account (creates tasks is the “owner”)

Parent (approver) accounts

Task to be completed for a price (Do the dishes)

Someone(child) to complete the task

Some ETC

## Work flow
Contract should show a task that needs to be completed and be funded

The child completes the task in real life and signals the contract it is complete

the parent either approves or rejects the work

If the task is approved, payout!


## Variables

Task – the task name

Parent - controls the funding and inspects the work

Child - completes the task IRL and gets paid

## Events
taskUpdate: makes system announcments


## Functions

### Setup
Completed by: Parent

Inputs: parent address, child address, Task name

Outputs: none

About: This function sets the initial state of the task and assigns both a child and parent to it.

### Deposit
Completed by: Parent

Inputs: an amount of ETC

Outputs: none (consider adding a funded announcement in the future)

About: This allows the parent to fund the task

### Approve
Completed by: Parent and child

Inputs: none

Outputs: announcement event that task is complete or approved, payout if two approvals

About: This function is called once a child completes a task and again once the parent inspects it. After both have called this function the contract pays the child.

### Abort
Completed by: Parent and child

Inputs: none

Outputs: “Get real this task is not done”(parent) and “Just kidding”(child) announcement and resets approval 

About: used to revoke approval

### Refund
Completed by: Parent and child

Inputs: none

Outputs: none (consider adding a “Task defunded” announcement in the future)

About: used to cancel the bounty on the task

### Kill
Destroy the contract
