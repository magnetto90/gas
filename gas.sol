// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Run with medusa fuzz --target gas.sol --deployment-order fuzzIt

contract fuzzIt {
    error ETHTransferFailed();

    function fuzzSafeTransferETH() external payable returns (bool) {
        return safeTransferETH(msg.sender, msg.value) == safeTransferETH2(msg.sender, msg.value);
    }

    function safeTransferETH(address to, uint256 amount) internal returns (bool) {
        assembly {
            if iszero(call(gas(), to, amount, gas(), 0x00, gas(), 0x00)) {
                mstore(0x00, 0xb12d13eb)
                revert(0x1c, 0x04)
            }
        }
        return true;
    }

    function safeTransferETH2(address to, uint256 amount) internal returns (bool) {
        assembly {
            if iszero(call(gas(), to, amount, 0x00, 0x00, 0x00, 0x00)) {
                mstore(0x00, 0xb12d13eb)
                revert(0x1c, 0x04)
            }
        }
        return true;
    }
}
