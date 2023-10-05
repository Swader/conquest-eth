import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {parseEther} from '@ethersproject/units';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {deployer} = await hre.getNamedAccounts();
  const {deploy} = hre.deployments;

  // const chainId = await hre.getChainId();
  const networkName = await hre.deployments.getNetworkName();
  // TODO use network tags ?
  const localTesting = networkName === 'hardhat' || networkName === 'localhost'; // chainId === '1337' || chainId === '31337';

  let numTokensPerNativeTokenAt18Decimals = parseEther('1');

  if (localTesting) {
    numTokensPerNativeTokenAt18Decimals = parseEther('1000');
  }

  if (networkName === 'defcon') {
    numTokensPerNativeTokenAt18Decimals = parseEther('1');
  }

  await deploy('PlayToken', {
    from: deployer,
    contract: 'PlayToken',
    args: [numTokensPerNativeTokenAt18Decimals],
    proxy: hre.network.name !== 'mainnet' ? 'postUpgrade' : undefined, // TODO l2 network mainnet
    log: true,
    autoMine: true,
    linkedData: {
      numTokensPerNativeTokenAt18Decimals: numTokensPerNativeTokenAt18Decimals.toString(),
    },
  });
};
export default func;
func.tags = ['PlayToken', 'PlayToken_deploy'];
