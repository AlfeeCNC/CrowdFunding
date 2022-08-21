pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract Products is ERC1155 {
    uint256 public nft_current_id = 0;
    // 紀錄NFT創建者 => [{plan721Id,產品ID}]
    struct Product {
        uint256 planId;
        uint256 productId;
    }
    mapping(address => Product[]) initiators;

    mapping(uint256 => address) public products;
    mapping(uint256 => uint256) public products_amount;

    event MintNFT(
        address account,
        uint256 plan_id,
        uint256 productId,
        uint256 nft_id,
        uint256 amount,
        uint256 cost,
        uint256 price
    );

    event BurnNFT(address account, uint256 nft_id, uint256 amount);

    event BuyProduct(
        address buyer_address,
        uint256 buyer_id,
        uint256 plan721_id,
        uint256 product1155_id,
        uint256 amount,
        uint256 price,
        uint256 discount,
        uint256 cost
    );

    constructor() public ERC1155("https://example/api/item/{id}.json") {}

    function mintERC1155Token(
        address initiator,
        uint256 amount,
        uint256 planId,
        uint256 productId,
        uint256 cost,
        uint256 price
    ) public returns (uint256) {
        // 遞增NFT目前id
        uint256 ERC1155_id = nft_current_id;
        nft_current_id = nft_current_id + 1;
        bytes memory bytes_plan_id = abi.encodePacked(planId);
        // 鑄造產品token
        _mint(initiator, ERC1155_id, amount, bytes_plan_id);
        // 紀錄建立者與產品id
        initiators[initiator].push(Product(planId, ERC1155_id));
        // 紀錄產品id與數量
        products_amount[ERC1155_id] = amount;
        // 紀錄產品id屬於哪個建立者
        products[ERC1155_id] = initiator;
        emit MintNFT(
            initiator,
            planId,
            productId,
            ERC1155_id,
            amount,
            cost,
            price
        );
        return ERC1155_id;
    }

    function mintMoreERC1155Token(
        address initiator,
        uint256 amount,
        uint256 planId,
        uint256 productId,
        uint256 ERC1155_id,
        uint256 cost,
        uint256 price
    ) public returns (uint256) {
        bytes memory bytes_plan_id = abi.encodePacked(planId);
        // 鑄造產品token
        _mint(initiator, ERC1155_id, amount, bytes_plan_id);
        // 紀錄產品id與數量
        products_amount[ERC1155_id] += amount;
        emit MintNFT(
            initiator,
            planId,
            productId,
            ERC1155_id,
            amount,
            cost,
            price
        );
        return ERC1155_id;
    }

    function burnERC1155Token(
        address account,
        uint256 id,
        uint256 amount
    ) public {
        _burn(account, id, amount);
        products_amount[id] -= amount;
        emit BurnNFT(account, id, amount);
    }

    function getProductAmount(uint256 ERC1155_id)
        public
        view
        returns (uint256)
    {
        return products_amount[ERC1155_id];
    }

    function getProductInitiator(uint256 ERC1155_id)
        public
        view
        returns (address)
    {
        return products[ERC1155_id];
    }

    function buyProduct(
        address account,
        uint256 id,
        uint256 amount,
        uint256 plan721_id,
        address buyer_address,
        uint256 buyer_id,
        uint256 price,
        uint256 discount,
        uint256 cost
    ) public {
        // 呼叫burnErc1155
        burnERC1155Token(account, id, amount);
        // emit 購買人地址, 購買人id, plan721id, product1155id, 數量,
        // 售價, 折扣, 成本
        emit BuyProduct(
            buyer_address,
            buyer_id,
            plan721_id,
            id,
            amount,
            price,
            discount,
            cost
        );
    }
}
