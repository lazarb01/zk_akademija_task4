pragma circom 2.1.6;

include "circomlib/poseidon.circom";

template Example () {
    signal input tajni_kod;
    signal output hes_tajni_kod;
    component hash = Poseidon(1);
    hash.inputs[0] <== tajni_kod;
    hes_tajni_kod <== hash.out;
}

component main { public [ tajni_kod ] } = Example();

/* INPUT = {
    "tajni_kod": "5"
} */