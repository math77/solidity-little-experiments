async function main () {
  const balanceFactory = await hre.ethers.getContractFactory('AddressBalanceInNFT');
  const balanceContract = await balanceFactory.deploy();
  
  await balanceContract.deployed();
  console.log("Contract metadata deployed to:", balanceContract.address);

  let txn1;
  txn1 = await balanceContract.claim();
  await txn1.wait();

  let returnedTokenUri1 = await balanceContract.tokenURI(1);
  console.log("Token URI 1:", returnedTokenUri1);  
}


main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
});
