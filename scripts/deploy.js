const { ethers } = require("hardhat");

async function main() {
  const VotingDApp = await ethers.getContractFactory("VotingDApp");
  
  // Example candidate names; modify as needed.
  const candidateNames = ["Alice", "Bob", "Charlie"];
  
  const contract = await VotingDApp.deploy(candidateNames);
  await contract.deployed();

  console.log("VotingDApp deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
