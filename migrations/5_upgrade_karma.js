const { upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const KarmaV2 = artifacts.require('KarmaV2');
const KarmaV3 = artifacts.require('KarmaV3');

module.exports = async function (deployer) {
    const existing = await KarmaV2.deployed();
    await upgradeProxy(existing.address, KarmaV3, { deployer });
};
