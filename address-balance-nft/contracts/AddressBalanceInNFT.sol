//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { Base64 } from "./libraries/Base64.sol";

import "hardhat/console.sol";

contract AddressBalanceInNFT is ERC721 {

  uint256 private _tokenId = 1;
  string private _proxyUri = "";

  constructor() ERC721("BalanceInNFT", "BNFT") {}

  function claim() external {
    unchecked {
      _safeMint(msg.sender, ++_tokenId);
    }
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    string memory animationUrl;

    if (bytes(_proxyUri).length == 0) {
      animationUrl = string(abi.encodePacked("data:text/html;charset=utf-8,", tokenDataInHTML(tokenId)));
    } else {
      animationUrl = string(abi.encodePacked(_proxyUri, toString(tokenId), ".html"));
    }

    return string(
      abi.encodePacked(
        'data:application/json;base64,',
        Base64.encode(
          abi.encodePacked(
            '{"name":"BalanceInNFT #',
            toString(tokenId),
            '","description": "Experiment.", "animation_url":"',
            animationUrl,
            '","image": "data:image/svg+xml;base64,',
            Base64.encode(abi.encodePacked("<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width='100%' height='100%' fill='yellow' /><text x='30' y='30' class='base'>EXPERIMENT</text></svg>")),
            '"}'
            ))));
  }


  function tokenDataInHTML(uint256 tokenId) public view returns (string memory) {
    return string("<html><head><meta charset='UTF-8'><style>html,body,div{margin:0;padding:0; height:100%;text-align:center;background-color: #3498db;}h1{font-size: 3rem;color: #fff; margin-top: 20px;}</style><script src='https://cdn.ethers.io/lib/ethers-5.2.umd.min.js' type='application/javascript'></script><script type='text/javascript'> let provider=new ethers.providers.JsonRpcProvider('alchemy-url'); async function getBalance(){if (provider !==null){try{const balance=await provider.getBalance('ethers.eth'); document.getElementById('output').innerHTML=ethers.utils.formatEther(balance) + ' ETH';}catch (err){document.getElementById('output').innerHTML=err;}}else{document.getElementById('output').innerHTML='no provider';}}</script></head><body><div><h1 id='output'></h1><button onclick='getBalance();'>CLICK</button></div></body></html>");
  }

  function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

    if (value == 0) {
      return "0";
    }
    
    uint256 temp = value;
    uint256 digits;
    while (temp != 0) {
      digits++;
      temp /= 10;
    }
    
    bytes memory buffer = new bytes(digits);
    while (value != 0) {
      digits -= 1;
      buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
      value /= 10;
    }

    return string(buffer);
  }

}
