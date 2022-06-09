// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC721, Ownable {
    using Counters for Counters.Counter;

    IERC20 public myERC20Address;
    uint256 public rate = 100 * 10**18;

    Counters.Counter private _tokenIdCounter;



    constructor(address _myERC20Address) ERC721("MyToken", "MTK") {
        myERC20Address = IERC20(_myERC20Address);
    }

    function safeMint() public  {
        myERC20Address.transferFrom(msg.sender, address(this), rate);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

       function withdrawToken() public onlyOwner {
        myERC20Address.transfer(msg.sender, myERC20Address.balanceOf(address(this)));
    }
}