pragma solidity >=0.8.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./BlockshipNFTMarketplace.sol";


contract FractionsManager is ERC1155{
    constructor()ERC1155(""){
        
    }
    
    address payable public FMAddress = payable(address(this)); 
    
    function _mint( address to, uint id, uint amount, bytes memory data) public override{
       
    }
    
}

