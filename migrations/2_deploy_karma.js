const Karma = artifacts.require('Karma');

module.exports = async function (deployer) {
    await deployer.deploy(Karma);
};
