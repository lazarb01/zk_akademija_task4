pragma circom 2.1.6;
include "circomlib/comparators.circom";

template Example () {
    signal input a1;
    signal input a2;
    signal input a3;
    signal input a4;
    signal input a5;
    signal input b;
    signal pomocni1;
    signal pomocni2;
    signal pomocni3;
    signal output odgovor;

/*  ovaj deo i ne mora da se radi,
    proveravamo da li je svaki od ulaznih brojeva veci od 1
*/
    component veciOdJedan1 = GreaterThan(252);
    veciOdJedan1.in[0] <== a1;
    veciOdJedan1.in[1] <== 1;
    veciOdJedan1.out === 1;

    component veciOdJedan2 = GreaterThan(252);
    veciOdJedan2.in[0] <== a2;
    veciOdJedan2.in[1] <== 1;
    veciOdJedan2.out === 1;

    component veciOdJedan3 = GreaterThan(252);
    veciOdJedan3.in[0] <== a3;
    veciOdJedan3.in[1] <== 1;
    veciOdJedan3.out === 1;

    component veciOdJedan4 = GreaterThan(252);
    veciOdJedan4.in[0] <== a4;
    veciOdJedan4.in[1] <== 1;
    veciOdJedan4.out === 1;

    component veciOdJedan5 = GreaterThan(252);
    veciOdJedan5.in[0] <== a5;
    veciOdJedan5.in[1] <== 1;
    veciOdJedan5.out === 1;


/*  koristimo pomocne signale da validno pomnozimo prva cetri broja */  
    pomocni1 <== a1 * a2;
    pomocni2 <== a3 * a4;
    pomocni3 <== pomocni1 * pomocni2;
    
/*  pomocu komponente IsEqual proveravamo 
    da li je prozivod prva cetri broja sa petim jednak javnom inputu b*/ 
    component jednaki = IsEqual();
    jednaki.in[0] <== b;
    jednaki.in[1] <== pomocni3 * a5;
    odgovor <== jednaki.out;

}

component main { public [ b ] } = Example();

/* INPUT = {
    "a1": "2",
    "a2": "3",
    "a3": "6",
    "a4": "4",
    "a5": "5",
    "b": "720"
} */