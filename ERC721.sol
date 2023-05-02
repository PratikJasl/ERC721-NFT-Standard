//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
import "./AccessControl.sol";
import "./ERC721 Receiver.sol";
import "./Pausable.sol";
contract ERC721 is AccessControl, pausable
{
    string private _TokenName;
    string private _TokenSymbol;
    uint256 private _TotalTokens;
    uint256 private _MaxSupplyNFT;
    string private _BaseURI;
    address private _Owner;
    //mapping from tokenID to owners.
    mapping (uint256 => address) private _owners;
    //mapping from owners to Total tokens.
    mapping (address => uint256) private _balances;

    constructor(string memory tokenname_ , string memory tokensymbol_, uint256 maxsupply_, string memory baseUri_)
    {
        _TokenName = tokenname_;
        _TokenSymbol = tokensymbol_;
        _Owner = msg.sender;
        _MaxSupplyNFT = maxsupply_;
        _BaseURI = baseUri_;
    }
    event Transfer(address From, address To , uint256 TokenID);
    
// Functions to check the name and symbol of the Tokens.
    function TokenName() public virtual view returns(string memory)
    {
        return(_TokenName);
    }
    function TokenSymbol() public virtual view returns(string memory)
    {
        return(_TokenSymbol);
    }

// function to check the token balance in accounts.
    function Balances(address account) public virtual view returns(uint256)
    {
        require(account != address(0),"Please enter a valid address, the address is zero");
        return(_balances[account]);
    }
// Function to check the owner of any Token.
    function OwnerOfToken(uint256 TokenID) public virtual view returns(address)
    {
        return(_owners[TokenID]);
    }
// Function to check max number of NFT in this collection.
    function TotalTokens() public virtual view returns(uint)
    {
        return(_TotalTokens);
    }
// Function to take the BaseURI for the NFT's
    function BaseURI() public virtual view returns(string memory)
    {
        return(_BaseURI);
    }
// Function to Tranfer NFT's from one account to another.
    function SafeTranferNFT(address _To, uint256 _tokenID) public virtual
    {
        address _From = msg.sender;
        _Transfer(_From, _To, _tokenID);
    }

    function _Transfer(address _From, address _To, uint256 _TokenID) internal virtual
    {
        require(_To != address(0),"Aborting!!! Invalid Address");
        require(OwnerOfToken(_TokenID) == _From,"Aborting!!! Sender does not have the token");
        require(_checkOnERC721Received(_From, _To, _TokenID,"ERC721: transfer to non ERC721Receiver implementer"));
        BeforeTokenTransfer();
        {
            _balances[_From] -= 1;
            _balances[_To] += 1;
        }
        _owners[_TokenID] = _To;
        emit Transfer(_From, _To, _TokenID);
    }

// Function to check if a particular TokenID exists.
    function ExistingTokens(uint256 TokenID) public virtual view returns(bool)
    {
        return(_owners[TokenID] != address(0));
    }

// Function to mint new tokens.
    function SafeMint_Tokens(address _To, uint256 _TokenID) public virtual OnlyMiner
    {
        _mint(_To, _TokenID);
    }

    function _mint(address _To, uint256 _TokenID) internal virtual
    {
        address _From = msg.sender;
        require(_To != address(0),"Enter a valid address");
        require(!ExistingTokens(_TokenID),"ERC721: Token already minted");
        require(_checkOnERC721Received(_From, _To, _TokenID,"ERC721: transfer to non ERC721Receiver implementer"));
        BeforeTokenTransfer();
        {
            _balances[_To] += 1;
            _TotalTokens += 1;
        }
        _owners[_TokenID] = _To;
        emit Transfer(address(0), _To, _TokenID);
    }
// Function to burn the minted Token.
    function Burn_Tokens(uint256 _TokenID) public virtual OnlyBurner
    {
        _Burn(_TokenID);
    } 
    function _Burn(uint _TokenID) internal virtual OnlyBurner
    {
        require(_owners[_TokenID] != address(0),"ERC721: Invalid Token ID");
        BeforeTokenTransfer();
        address owner = OwnerOfToken(_TokenID);
        {
            _balances[owner] -= 1;
        }
        delete _owners[_TokenID];
        emit Transfer(owner, address(0), _TokenID);
    }

// Function to check if the give address is form a contract or not.
    function isContract(address account) internal virtual view returns (bool) 
    {
        return account.code.length > 0;
    }

// Function to ensure ERC721 enabled contracts can receive tokens.
     function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) private returns (bool) {
        if (isContract(to)) {
            try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) returns (bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("ERC721: transfer to non ERC721Receiver implementer");
                } else {
                    /// @solidity memory-safe-assembly
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    }

// Funciton to be check beofre the transfer of tokens. these are hooks.
     function BeforeTokenTransfer() internal virtual returns(bool)
     {
         require(!PauseStatus(),"ERC721: Contract operation paused by ADMIN");
         return(true);
     }
}
