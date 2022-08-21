pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract FundRaisingPlan is ERC721URIStorage, Ownable {
    using SafeMath for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // 募資計畫之投資紀錄
    struct InvestmentData {
        uint256 planId;
        mapping(uint256 => uint256) investRecords;
    }
    mapping(address => InvestmentData[]) investors;

    // investor => planId => productId : investQuantity
    mapping(address => mapping(uint256 => mapping(uint256 => uint256)))
        public investTokenOwner;

    event NewInvestment(
        address investor,
        uint256 planId,
        uint256 productId,
        uint256 investQuantity
    );

    event InvestTokenTransferLog(
        address from,
        address to,
        uint256 planId,
        uint256 productId,
        uint256 tokenQuantities
    );

    // data structure for mapping of initiator and plan id
    struct Plan {
        uint256 planId;
    }
    mapping(address => Plan[]) initiators;

    constructor() public ERC721("FundRaisingPlan", "FRP") {}

    function createFundRaisingPlan(address initiator, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();

        _mint(initiator, newItemId);
        // set metadata of this new 721 token
        _setTokenURI(newItemId, tokenURI);
        _tokenIds.increment();
        // store new record
        initiators[initiator].push(Plan(newItemId));
        return newItemId;
    }

    // 只有部署此合約的擁有者可刪除ERC721
    function burnFundRaisingPlan(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
    }

    // 發行募資計畫投資憑證
    function issueFundraisingInvestToken(
        address investor,
        uint256 planId,
        uint256 productId,
        uint256 investQuantity
    ) public onlyOwner {
        investTokenOwner[investor][planId][productId] = investTokenOwner[
            investor
        ][planId][productId].add(investQuantity);
        emit NewInvestment(investor, planId, productId, investQuantity);
    }

    // 轉移募資計畫投資憑證
    function transferInvestToken(
        address from,
        address to,
        uint256 planId,
        uint256 productId,
        uint256 tokenQuantities
    ) public returns (bool) {
        if (investTokenOwner[from][planId][productId] >= tokenQuantities) {
            investTokenOwner[from][planId][productId] = investTokenOwner[from][
                planId
            ][productId].sub(tokenQuantities);
            investTokenOwner[to][planId][productId] = investTokenOwner[to][
                planId
            ][productId].add(tokenQuantities);
            emit InvestTokenTransferLog(
                from,
                to,
                planId,
                productId,
                tokenQuantities
            );
            return true;
        } else {
            return false;
        }
    }

    fallback() external payable {}

    function getDataTest() public pure returns (uint256) {
        return 100;
    }

    function getBoolean() public pure returns (bool) {
        return true;
    }
}
