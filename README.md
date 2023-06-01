# StackUp DApp Smart Contract

This Solidity smart contract represents the backend logic for the StackUp DApp, a decentralized application that allows users to participate in quests and campaigns. The smart contract includes several features to enhance the functionality and flexibility of the DApp.

## Features

### Quest Review Functionality
The contract enables the admin to review quest submissions and take actions such as approving, rejecting, or rewarding them. Each quest has a status (Pending, Approved, or Rejected) that can be changed by the admin using the `reviewQuest` function.

### Edit and Delete Quests
The contract provides functions for the admin to edit and delete quests. The `editQuest` function allows the admin to modify the title and description of a quest, while the `deleteQuest` function allows the admin to remove a quest from the system.

### Campaigns
The contract introduces the concept of campaigns, which are collections of quests with a common theme or objective. The `createCampaign` function allows the admin to create a new campaign, specifying its title and description. The `addQuestToCampaign` and `removeQuestFromCampaign` functions enable the admin to add or remove quests from a campaign.

### Quest Start and End Time
Each quest now includes start and end times to specify the period during which users can participate. The `isQuestJoinable` function checks if a quest is joinable based on its status and the current timestamp. Users cannot join a quest that has ended or has not been approved.

## Contract Structure

The contract includes several data structures, including `Quest` and `Campaign`, to store quest and campaign information. It also includes mappings to track quests and campaigns, as well as variables to keep counts of the quests and campaigns.

## Usage

1. Deploy the `StackUpDApp` contract on a compatible Ethereum Virtual Machine (EVM) using Solidity version 0.8.0 or later.
2. Set the `admin` address to the desired admin address.
3. Interact with the contract by calling the available functions:
   - Users can submit quests using the `submitQuest` function, providing the quest title, description, start time, and end time.
   - The admin can review quests using the `reviewQuest` function by specifying the quest ID and desired status.
   - The admin can edit quests using the `editQuest` function by specifying the quest ID and the updated title and/or description.
   - The admin can delete quests using the `deleteQuest` function by specifying the quest ID.
   - The admin can create campaigns using the `createCampaign` function, providing the campaign title and description.
   - The admin can add quests to campaigns using the `addQuestToCampaign` function, specifying the campaign ID and quest ID.
   - The admin can remove quests from campaigns using the `removeQuestFromCampaign` function, specifying the campaign ID and quest ID.
   - Users can check if a quest is joinable using the `isQuestJoinable` function, providing the quest ID.

## Security Considerations

Ensure that the `admin` address is set to a trusted and secure Ethereum address. Only the admin address will have access to functions that modify the quests and campaigns.

It is important to perform thorough testing and security audits before deploying the smart contract to a production environment. Consider additional security measures such as access control mechanisms, input validation, and handling of edge cases to ensure the contract's robustness and security.

**Note: This is a simplified example for demonstration purposes only. It may require additional considerations and improvements for real-world use.**
