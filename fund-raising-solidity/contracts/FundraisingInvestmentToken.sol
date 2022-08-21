pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract FundraisingInvestmentToken is ERC1155 {
    using SafeMath for uint256;

    constructor() public ERC1155("https://example/api/item/{id}.json") {}

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // investor => planId => productId : investQuantity
    mapping(address => mapping(uint256 => mapping(uint256 => uint256)))
        public investTokenOwner;
    // planId => productId : investTokenTypeId
    mapping(uint256 => mapping(uint256 => uint256)) public InvestTokenTypeId;
    // investTokenTypeId => quantities
    mapping(uint256 => uint256) public planInvestTokenQuantities;

    event InvestTokenIssueLog(
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

    event BurnInvestToken(
        address investor,
        uint256 planId,
        uint256 productId,
        uint256 amount
    );

    // 發行正式計畫的投資憑證
    function issueInvestToken(
        address investor,
        uint256 planId,
        uint256 productId,
        uint256 investQuantity
    ) public {
        uint256 tokenTypeId;
        if (InvestTokenTypeId[planId][productId] != uint256(0x0)) {
            // plan下的product已經發行過ERC1155投資憑證，取得tokenTypeId
            tokenTypeId = InvestTokenTypeId[planId][productId];
        } else {
            // plan下的product尚未發行過ERC1155投資憑證，遞增一個1155TokenTypeId
            tokenTypeId = _tokenIds.current();
            InvestTokenTypeId[planId][productId] = tokenTypeId;
            _tokenIds.increment();
        }
        _mint(
            msg.sender,
            tokenTypeId,
            investQuantity,
            addressToString(investor)
        );
        // investor下的planId=>productId 遞增 投資憑證token數量
        investTokenOwner[investor][planId][productId] = investTokenOwner[
            investor
        ][planId][productId].add(investQuantity);
        // plan下產品遞增其發行的投資憑證
        planInvestTokenQuantities[tokenTypeId] = planInvestTokenQuantities[
            tokenTypeId
        ].add(investQuantity);
        emit InvestTokenIssueLog(investor, planId, productId, investQuantity);
    }

    function balanceOfToken(
        address investor,
        uint256 planId,
        uint256 productId
    ) public returns (uint256) {
        return investTokenOwner[investor][planId][productId];
    }

    // 轉移正式計畫的投資憑證
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

    // 刪除投資憑證
    function burnInvestToken(
        address investor,
        uint256 planId,
        uint256 productId,
        uint256 tokenQuantities
    ) public {
        uint256 investTokenTypeId = InvestTokenTypeId[planId][productId];
        _burn(investor, investTokenTypeId, tokenQuantities);
        investTokenOwner[investor][planId][productId] = investTokenOwner[
            investor
        ][planId][productId].sub(tokenQuantities);
        planInvestTokenQuantities[
            investTokenTypeId
        ] = planInvestTokenQuantities[investTokenTypeId].sub(tokenQuantities);
        emit BurnInvestToken(investor, planId, productId, tokenQuantities);
    }

    function addressToString(address _address)
        public
        pure
        returns (bytes memory)
    {
        bytes32 _bytes = bytes32(uint256(uint160(_address)));
        bytes memory HEX = "0123456789abcdef";
        bytes memory _string = new bytes(42);
        _string[0] = "0";
        _string[1] = "x";
        for (uint256 i = 0; i < 20; i++) {
            _string[2 + i * 2] = HEX[uint8(_bytes[i + 12] >> 4)];
            _string[3 + i * 2] = HEX[uint8(_bytes[i + 12] & 0x0f)];
        }
        return bytes(_string);
    }
}
