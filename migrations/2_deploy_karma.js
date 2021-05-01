const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const Karma = artifacts.require('Karma');

module.exports = async function (deployer) {
    // initializer chooses function to call on initialization
    // + initialize() defined in karma-ERC20.sol, marked as initializer
    // https://docs.openzeppelin.com/upgrades-plugins/1.x/api-truffle-upgrades#deploy-proxy
    await deployProxy(Karma, {deployer, initializer: 'initialize'});
};