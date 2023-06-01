// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract StackUpDApp {
    address public admin;

    enum QuestStatus { Pending, Approved, Rejected }

    struct Quest {
        uint id;
        string title;
        string description;
        uint startTime;
        uint endTime;
        QuestStatus status;
    }

    struct Campaign {
        uint id;
        string title;
        string description;
        uint[] questIds;
    }

    mapping(uint => Quest) public quests;
    mapping(uint => Campaign) public campaigns;
    uint public questCount;
    uint public campaignCount;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action.");
        _;
    }

    constructor() {
        admin = msg.sender;
        questCount = 0;
        campaignCount = 0;
    }

    event QuestSubmitted(uint id, string title, string description);
    event QuestReviewed(uint id, QuestStatus status);
    event QuestEdited(uint id, string newTitle, string newDescription);
    event QuestDeleted(uint id);
    event CampaignCreated(uint id, string title, string description);
    event CampaignQuestAdded(uint campaignId, uint questId);
    event CampaignQuestRemoved(uint campaignId, uint questId);

    function submitQuest(string memory _title, string memory _description, uint _startTime, uint _endTime) public {
        questCount++;
        quests[questCount] = Quest(questCount, _title, _description, _startTime, _endTime, QuestStatus.Pending);
        emit QuestSubmitted(questCount, _title, _description);
    }

    function reviewQuest(uint _id, QuestStatus _status) public onlyAdmin {
        require(_id > 0 && _id <= questCount, "Invalid quest ID.");

        Quest storage quest = quests[_id];
        quest.status = _status;
        emit QuestReviewed(_id, _status);
    }

    function editQuest(uint _id, string memory _newTitle, string memory _newDescription) public onlyAdmin {
        require(_id > 0 && _id <= questCount, "Invalid quest ID.");

        Quest storage quest = quests[_id];
        quest.title = _newTitle;
        quest.description = _newDescription;
        emit QuestEdited(_id, _newTitle, _newDescription);
    }

    function deleteQuest(uint _id) public onlyAdmin {
        require(_id > 0 && _id <= questCount, "Invalid quest ID.");

        delete quests[_id];
        emit QuestDeleted(_id);
    }

    function createCampaign(string memory _title, string memory _description) public onlyAdmin {
        campaignCount++;
        campaigns[campaignCount] = Campaign(campaignCount, _title, _description, new uint[](0));
        emit CampaignCreated(campaignCount, _title, _description);
    }

    function addQuestToCampaign(uint _campaignId, uint _questId) public onlyAdmin {
        require(_campaignId > 0 && _campaignId <= campaignCount, "Invalid campaign ID.");
        require(_questId > 0 && _questId <= questCount, "Invalid quest ID.");

        Campaign storage campaign = campaigns[_campaignId];
        campaign.questIds.push(_questId);
        emit CampaignQuestAdded(_campaignId, _questId);
    }

    function removeQuestFromCampaign(uint _campaignId, uint _questId) public onlyAdmin {
        require(_campaignId > 0 && _campaignId <= campaignCount, "Invalid campaign ID.");
        require(_questId > 0 && _questId <= questCount, "Invalid quest ID.");

        Campaign storage campaign = campaigns[_campaignId];
        uint[] storage questIds = campaign.questIds;

        for (uint i = 0; i < questIds.length; i++) {
            if (questIds[i] == _questId) {
                questIds[i] = questIds[questIds.length - 1];
                questIds.pop();
                emit CampaignQuestRemoved(_campaignId, _questId);
                return;
            }
        }
    }

    function getQuestCount() public view returns (uint) {
        return questCount;
    }

    function getCampaignCount() public view returns (uint) {
        return campaignCount;
    }

    function isQuestJoinable(uint _id) public view returns (bool) {
        require(_id > 0 && _id <= questCount, "Invalid quest ID.");

        Quest storage quest = quests[_id];
        return (quest.status == QuestStatus.Pending || (quest.status == QuestStatus.Approved && block.timestamp >= quest.startTime && block.timestamp <= quest.endTime));
    }
}
