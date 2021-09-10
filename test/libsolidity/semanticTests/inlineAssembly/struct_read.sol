contract C {
	struct S { uint256 x; }
	struct S2 { uint256 x; uint256 y; }
	function f(S calldata s, S2 calldata s2) public pure returns (uint256 r, uint256 r2) {
		assembly {
			r := calldataload(s)
			r2 := calldataload(s2)
		}
	}
	function g(S memory s, S2 memory s2) public pure returns (uint256 r, uint256 r2)
	{
		assembly {
			r := mload(s)
			r2 := mload(s2)
		}
	}
}
// ====
// compileViaYul: false
// ----
// f((uint256),(uint256,uint256)): 0x42, 0x07, 0x77 -> 0x42, 0x07
// g((uint256),(uint256,uint256)): 0x42, 0x07, 0x77 -> 0x42, 0x07
