// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../base/erc20/UsingERC20Base.sol";
import "../base/erc20/WithPermitAndFixedDomain.sol";
import "hardhat-deploy/solc_0.8/proxy/Proxied.sol";
import "./PlayToken.sol";

contract PlayToken is UsingERC20Base, WithPermitAndFixedDomain, Proxied {
    uint256 internal constant DECIMALS_18 = 1000000000000000000;
    uint256 public immutable numTokensPerNativeTokenAt18Decimals;

    constructor(uint256 _numTokensPerNativeTokenAt18Decimals) WithPermitAndFixedDomain("1") {
        numTokensPerNativeTokenAt18Decimals = _numTokensPerNativeTokenAt18Decimals;
        postUpgrade(numTokensPerNativeTokenAt18Decimals);
    }

    function postUpgrade(uint256) public proxied {}

    string public constant symbol = "PLAY";

    function name() public pure override returns (string memory) {
        return "Play";
    }

    function mint(address to, uint256 amount) external payable {
        require((msg.value * numTokensPerNativeTokenAt18Decimals) / DECIMALS_18 == amount, "INVALID_AMOUNT");
        _mint(to, amount);
    }

    function burn(address payable to, uint256 amount) external {
        _burnFrom(msg.sender, amount);
        to.transfer((amount * DECIMALS_18) / numTokensPerNativeTokenAt18Decimals);
    }
}
