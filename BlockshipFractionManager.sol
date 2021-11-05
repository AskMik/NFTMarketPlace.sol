pragma solidity >=0.8.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";


contract FractionsManager is ERC1155{
    constructor()ERC1155(""){
        
    }
    
    address payable public FMAddress = payable(address(this)); 
    uint TokenIdYouWantToBuySharesOf;
    uint NumberOfShares;
    address payable _receiverAddress;
    
    

    uint nftId;
    uint shareOfNFT;
    
    
    
    
    function mint(address to, uint Id, uint Amount, bytes memory data) public{
        _mint(to, Id, Amount, data);
    }
}

