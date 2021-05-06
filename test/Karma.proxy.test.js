// Load dependencies
const { expect } = require('chai');
const { deployProxy, upgradeProxy} = require('@openzeppelin/truffle-upgrades');

// Load compiled artifacts
const Karma = artifacts.require('Karma');

// Start test block
contract('Karma (proxy)', function () {
    // Test case
    it('Karma deploys successfully', async function () {
        // Increment
        const karma = await Karma.new();
    });
});