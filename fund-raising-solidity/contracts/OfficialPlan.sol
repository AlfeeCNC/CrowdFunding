pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./OfficialInvestmentToken.sol";

contract OfficialPlan is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // 此合約的地址
    address ContractAddress = address(this);
    // 發行計畫之紀錄 發起人=>[{計畫ID}]
    struct Plan {
        uint256 planId;
    }
    mapping(address => Plan[]) initiators;

    event CreateOfficialPlanEvent(
        address initiator,
        address contract_address,
        uint256 token_id
    );
    event NewInvestment(
        address investor,
        uint256 planId,
        uint256 productId,
        uint256 investQuantity
    );

    constructor() public ERC721("OfficialPlan", "OP") {}

    function createOfficialPlan(address initiator, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        // 更新發起人address的balance
        // 更新tokenId對應至發起人address
        // 平台地址去mint新的721
        _mint(msg.sender, newItemId);
        // 設定此721的metadata
        _setTokenURI(newItemId, tokenURI);
        _tokenIds.increment();
        initiators[initiator].push(Plan(newItemId));
        emit CreateOfficialPlanEvent(initiator, ContractAddress, newItemId);
        return newItemId;
    }

    // 只有部署此合約的擁有者可刪除ERC721
    function burnOfficiallan(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
    }

    // 發行正式計畫(721)之投資憑證(1155)
    function issueOfficialInvestToken(
        address investor,
        uint256 planId,
        uint256 productId,
        uint256 investQuantity,
        address investTokenContractAddr
    ) public onlyOwner {
        // 呼叫 投資憑證合約 裡的發行憑證function
        OfficialInvestmentToken investTokenContract = OfficialInvestmentToken(
            investTokenContractAddr
        );
        investTokenContract.issueInvestToken(
            investor,
            planId,
            productId,
            investQuantity
        );
    }

    fallback() external payable {}
}
