//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract MagicArray {
	
    constructor() {
    }

   	uint256 constant MAX_POPULATION = 10;
	uint256[] ids = new uint256[](MAX_POPULATION);

	function pickIdOne() public returns(uint256 id) {
		uint256 len = ids.length;
		
		require(len > 0, "no data left");
		    
		// generate random hash and use it to pick a number between 0 and ids.length
		uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % len;

		// use current index or grab an old one
		if (ids[randomIndex] != 0) {
		    id = ids[randomIndex];
		} else {
		    id = randomIndex;
		}

		// fill array position with value
		uint256 a = len - 1;
		if (ids[a] == 0) {
		    ids[randomIndex] = a;
		} else {
		    ids[randomIndex] = ids[a];
		}

		// shrink ids array
		ids.pop();
	}

	function pickIdTwo() public returns(uint256 id) {
		require(ids.length > 0, "no data left");
		    
		// generate random hash and use it to pick a number between 0 and ids.length
		uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % ids.length;

		// use current index or grab an old one
		if (ids[randomIndex] != 0) {
		    id = ids[randomIndex];
		} else {
		    id = randomIndex;
		}

		// fill array position with value
		if (ids[ids.length - 1] == 0) {
		    ids[randomIndex] = ids.length - 1;
		} else {
		    ids[randomIndex] = ids[ids.length - 1];
		}

		// shrink ids array
		ids.pop();
	}
}
