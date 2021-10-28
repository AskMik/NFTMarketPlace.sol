pragma solidity >=0.8.0;
import "./BlockshipFractionManager.sol";

contract NFTMarketPlace{
    
    constructor() public{
        InterfaceSupport[0x80ac58cd] = true;
    }
    
    FractionsManager fm = FractionsManager(MPAddress);
        
        address payable MPAddress = payable(address(this));
        address payable fmadd = fm.FMAddress();
        uint EnlistingPrice = 0.005 ether;
        string name;
        string symbol;
        address nftAddress;
        uint nftId;
        uint shareOfNFT;
        uint PriceOfNFt;
        uint totalShareSupply = 300;
        address payable caller;
        uint tokensCount = 0;
        uint a;
        uint pr;
        
            
        uint CounterForEnlistedSellingTokens = 0; 
        uint sellingTime = block.timestamp * 30 days;
            
            
    
    struct SellerData{
        
        uint Counter;
        string nameOfToken;
        string SymbolOfToken;
        address TokenAddress;
        uint TokenID;
        uint ShareOFToken;
        uint PriceOfTokenShare;
        bool ShareisForSale;
        
    }   
    
   
 
    SellerData[] SellerDataStruct;
    mapping(uint => uint) TokenTrackerMapping;
    
    
    
    
    event TokenForSale(
        string ename,
        string eId,
        uint esharesOfTokenIssued,
        uint etime
        );

    mapping(uint => SellerData) SellerDataMapping;
    mapping(address => bool) AddressIdentifier;
    mapping(bytes4 => bool) private InterfaceSupport;
    mapping(address => bool) private AddressConfirmation;
    address payable[] RegisteredAddresses;
    mapping(uint => bool) NftIdChecker;
    
        function GetEnlistingPrice() public view returns(uint){
            return EnlistingPrice;
        }
    
    
        function getTheAllowedPercentageOfshares(address _YourAddress, bytes4 _YourTokenInterface, uint _amountOfSharesToBeIssued , uint _priceOfYourNft) public returns(uint, uint){
         require(AddressConfirmation[_YourAddress] = true);   
         require(InterfaceSupport[_YourTokenInterface] = true,"Your Token should support the Erc721 interface ");
         require( _amountOfSharesToBeIssued >=99, "The minimum limit for Issuance of Shares is 100"); 
         require(_priceOfYourNft > _amountOfSharesToBeIssued, "The price Of Token Should be greater than he number of shares Issued");
         
         caller = payable(msg.sender);
         AddressIdentifier[caller] = true;
         
         uint NumberOfSharesIssued = (_amountOfSharesToBeIssued * 100) / totalShareSupply;
         uint PriceForYourOneShare =  ( _priceOfYourNft / _amountOfSharesToBeIssued);
         
         _amountOfSharesToBeIssued = a;
         _priceOfYourNft = pr;
         
         return ( NumberOfSharesIssued, PriceForYourOneShare);
    
        }
        
        
        function EnlistForSelling(
        string memory _name,
        string memory _symbol,
        address _nftAddress,
        uint _nftId
        ) payable public{
        
        require(msg.value == EnlistingPrice, "you must have Enlisting Price i.g. 0.005 ether");
        require(AddressIdentifier[msg.sender] = true);
        

        name = _name;
        symbol = _symbol;
        nftAddress = _nftAddress;
        nftId = _nftId;

        bytes memory Enlisted = "your shares have been enlisted";
        
        MPAddress.transfer(msg.value);
        
        fm.safeTransferFrom(payable(msg.sender), fmadd, nftId, shareOfNFT, Enlisted );
        
        CounterForEnlistedSellingTokens++;
        NftIdChecker[nftId] = true;
        
        //_mint function to be used here(MPAddress, nftId, shareOfNFT, "");
        
        SellerDataStruct.push(SellerData(CounterForEnlistedSellingTokens, name, symbol, nftAddress, nftId, a, pr, true));
        SellerDataMapping[nftId]= SellerData(CounterForEnlistedSellingTokens, name, symbol, nftAddress, nftId, a, pr, true);
        
        
        
        }
        
    
        
    function GetTheSharesLeftForBuying(uint IdForToken) public view returns(uint){
        return (SellerDataMapping[IdForToken].ShareOFToken);
    }

    function BuySomeshares(address _receiverAddress, uint TokenIdYouWantToBuySharesOf, uint NumberOfShares) public payable{
        require(NftIdChecker[TokenIdYouWantToBuySharesOf] = true);
        require( msg.value == SellerDataMapping[TokenIdYouWantToBuySharesOf].PriceOfTokenShare);
        
        
        
       }
}
