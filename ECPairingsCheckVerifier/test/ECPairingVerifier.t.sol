// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/ECPairingVerifier.sol"; // Adjust the path as necessary

contract ECPairingVerifierTest is Test {
    ECPairingVerifier verifier;

    function setUp() public {
        verifier = new ECPairingVerifier();
    }

  function testComputeX1() public {
    // Example test for computeX1 with fixed inputs
    uint256 x1 = 1;
    uint256 x2 = 2;
    uint256 x3 = 3;
    
    // Update these expected values to match the computed X1 values from the Python script
    uint256[2] memory expected = [
        uint256(4503322228978077916651710446042370109107355802721800704639343137502100212473),
        uint256(6132642251294427119375180147349983541569387941788025780665104001559216576968)
    ];

    uint256[2] memory result = verifier.computeX1(x1, x2, x3);
    assertEq(result[0], expected[0], "X coordinate does not match");
    assertEq(result[1], expected[1], "Y coordinate does not match");
}


    function testVerifyComputation() public {
        // Example test for verifyComputation with mock inputs
        // This requires setting up A1, B2, C1, x1, x2, x3 and expected outcome
        // For the sake of example, let's define mock values
        uint256[2] memory A1 = [uint256(1), uint256(2)];
        uint256[2] memory B2 = [uint256(3), uint256(4)];
        uint256[2] memory C1 = [uint256(5), uint256(6)];
        uint256 x1 = 7;
        uint256 x2 = 8;
        uint256 x3 = 9;
        bool expected = true; // This should be determined based on what you're actually testing

        // You need to update the verifyComputation function in ECPairingVerifier to accept parameters as designed
        bool result = verifier.verifyComputation(A1, B2, C1, x1, x2, x3);
        assertEq(result, expected, "Verification failed");
    }

    // Fuzz testing for computeX1
    function testFuzzComputeX1(uint256 x1, uint256 x2, uint256 x3) public {
        // To prevent excessively large values, you might want to limit the size of inputs
        // Forge already limits these values but using bound for explicit range can be more readable
        vm.assume(x1 > 0 && x1 <= 1000);
        vm.assume(x2 > 0 && x2 <= 1000);
        vm.assume(x3 > 0 && x3 <= 1000);

        // Call computeX1 with fuzzed inputs and assert some property that should always hold
        // For example, that the output is not the zero point, if applicable
        uint256[2] memory result = verifier.computeX1(x1, x2, x3);
        assertTrue(result[0] != 0 || result[1] != 0, "Resulting point is unexpectedly zero");
    }
}
