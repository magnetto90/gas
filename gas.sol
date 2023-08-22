// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./helper.sol";

// Run with medusa fuzz --target gas.sol --deployment-order fuzzIt

contract fuzzIt is PropertiesAsserts {
    function fuzz_SafeTransferETH(address to) external payable {
        uint256 amount = msg.value / 2;
        bool success1;
        bool success2;
        assembly {
            success1 := call(gas(), to, amount, gas(), 0x00, gas(), 0x00)
            success2 := call(gas(), to, amount, 0x00, 0x00, 0x00, 0x00)
        }

        assertEq(success1, success2, "SafeTransferETH failed");
    }
}
