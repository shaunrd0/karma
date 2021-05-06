const Karma = artifacts.require('Karma');

const { deployProxy } = require('@openzeppelin/truffle-upgrades');

module.exports = async function (deployer) {
    await deployProxy(
        Karma,
        ['Karma', 'KRMA', '1000000000000000000000000000'],
        { deployer, initializer: 'initialize' }
    );
};