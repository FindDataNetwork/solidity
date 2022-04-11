library L {
    event E();
}
library S {
    event E(uint);
}
library T {
    event E();
}
interface I {
    event E();
}
library Y {
    event E() anonymous;
}

contract D {
    event F();
}

contract C is D {
    function test1() external pure returns (bytes32, bytes32, bytes32, bytes32) {
        assert(L.E.selector == T.E.selector);
        assert(I.E.selector == L.E.selector);
        assert(Y.E.selector == L.E.selector);

        assert(L.E.selector != S.E.selector);
        assert(T.E.selector != S.E.selector);
        assert(I.E.selector != S.E.selector);
        assert(Y.E.selector != S.E.selector);

        return (L.E.selector, S.E.selector, I.E.selector, Y.E.selector);
    }

    bytes32 s1 = L.E.selector;
    bytes32 s2 = S.E.selector;
    bytes32 s3 = T.E.selector;
    bytes32 s4 = I.E.selector;
    bytes32 s5 = Y.E.selector;

    function test2() view external returns (bytes32, bytes32, bytes32, bytes32, bytes32) {
        return (s1, s2, s3, s4, s5);
    }

    function test3() pure external returns (bytes32) {
        return (F.selector);
    }
}
// ----
// TypeError 9582: (400-412): Member "selector" not found or not visible after argument-dependent lookup in function ().
