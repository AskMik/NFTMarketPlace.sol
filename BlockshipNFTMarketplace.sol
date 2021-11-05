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
        uint SellingTimeLimit = 30 days;
            
            
    
    struct SellerData{
        
        uint Counter;
        address payable SenderAddress;
        string nameOfToken;
        string SymbolOfToken;
        address TokenAddress;
        uint TokenID;
        uint ShareOfToken;
        uint PriceOfTokenShare;
        uint SharesRemain;
        uint TimeOfSelling;
        bool ShareisForSale;
        
    }   
    
   
    address payable[] SellerAddresses;
    SellerData[] SellerDataStruct;
    mapping(uint => uint) TokenTrackerMapping;
    

    
    event TokenForSale(
        string ename,
        uint eId,
        uint esharesOfTokenIssued,
        uint etime
        );

    mapping(uint => SellerData) public SellerDataMapping;
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
        uint SellTime = block.timestamp;
        
        fm.safeTransferFrom(payable(msg.sender), fmadd, nftId, shareOfNFT, Enlisted );
        
        CounterForEnlistedSellingTokens++;
        NftIdChecker[nftId] = true;
        
        fm.mint(fmadd, nftId, shareOfNFT, "");
        SellerAddresses.push(payable(msg.sender));
        SellerDataStruct.push(SellerData(CounterForEnlistedSellingTokens, payable(msg.sender), name, symbol, nftAddress, nftId, a, pr, a, SellTime, true));
        SellerDataMapping[nftId]= SellerData(CounterForEnlistedSellingTokens, payable(msg.sender), name, symbol, nftAddress, nftId, a, pr, a, SellTime, true);
        
        emit TokenForSale(name, nftId, a, SellTime);
        
        
        }
        
    
        
    function GetTheSharesLeftForBuying(uint IdForToken) public view returns(uint){
        return (SellerDataMapping[IdForToken].SharesRemain);
    }

    function BuySomeshares( uint TokenIdYouWantToBuySharesOf, uint NumberOfShares) public payable{
        require(NftIdChecker[TokenIdYouWantToBuySharesOf] = true, "TokenID not available for Sale");
        require( msg.value == (SellerDataMapping[TokenIdYouWantToBuySharesOf].PriceOfTokenShare) * NumberOfShares);
        fm.mint(msg.sender, TokenIdYouWantToBuySharesOf, NumberOfShares, "" );
        
        SellerDataMapping[TokenIdYouWantToBuySharesOf].SenderAddress.transfer(NumberOfShares * SellerDataMapping[TokenIdYouWantToBuySharesOf].PriceOfTokenShare);
        uint RemainingShares = (SellerDataMapping[TokenIdYouWantToBuySharesOf].PriceOfTokenShare) - NumberOfShares;
        SellerDataMapping[TokenIdYouWantToBuySharesOf].SharesRemain = RemainingShares;
        
       }
       
    function ReturningShares( uint NFTID) public returns(bool){
    
            require( SellerDataMapping[NFTID].TimeOfSelling> SellingTimeLimit);
            fm.mint(SellerDataMapping[NFTID].SenderAddress, SellerDataMapping[NFTID].TokenID, SellerDataMapping[NFTID].SharesRemain, "");
            delete SellerDataMapping[NFTID];
            
            return true;
        }
        }
    



        
