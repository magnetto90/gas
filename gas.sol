// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./helper.sol";

// Run with medusa fuzz --target gas.sol --deployment-order fuzzIt

contract fuzzIt is PropertiesAsserts {
    error ETHTransferFailed();

    function fuzzSafeTransferETH(address to, uint256 amount) external payable {
        uint256 balanceBefore = to.balance;
        emit LogUint256("Balance Before", balanceBefore);
        safeTransferETH(to, amount);
        safeTransferETH2(to, amount);
        emit LogUint256("Balance After", to.balance);
        assertEq(balanceBefore + amount * 2, to.balance, "Balance is not right");
    }

    function safeTransferETH(address to, uint256 amount) internal {
        assembly {
            if iszero(call(gas(), to, amount, gas(), 0x00, gas(), 0x00)) {
                mstore(0x00, 0xb12d13eb)
                revert(0x1c, 0x04)
            }
        }
    }

    function safeTransferETH2(address to, uint256 amount) internal {
        assembly {
            if iszero(call(gas(), to, amount, 0x00, 0x00, 0x00, 0x00)) {
                mstore(0x00, 0xb12d13eb)
                revert(0x1c, 0x04)
            }
        }
    }
}
