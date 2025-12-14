pragma circom 2.1.6;
include "circomlib/comparators.circom";
include "circomlib/poseidon.circom";

template Example () {
    signal input geografska_sirina;
    signal input geografska_duzina;
    signal input com_adresa;
    signal pomocni1;
    signal pomocni2;
    signal pomocni3;
    signal output izlaz;

/*  izlaz ce biti 1 ako geografska sirina pripada 37,...,41 i geografska duzina
    pripada skupu 102,...,109
    izlaz ce biti 0 ako to nije ispunjeno
    */

    component provera_sirine1  = GreaterThan(252);
    provera_sirine1.in[0] <== geografska_sirina;
    provera_sirine1.in[1] <== 36;
    pomocni1 <== provera_sirine1.out;

    component provera_sirine2  = GreaterThan(252);
    provera_sirine2.in[0] <== 42;
    provera_sirine2.in[1] <== geografska_sirina;
    pomocni2 <== pomocni1 * provera_sirine2.out;


    component provera_duzine1 = GreaterThan(252);
    provera_duzine1.in[0] <== geografska_duzina;
    provera_duzine1.in[1] <== 101;
    pomocni3 <== pomocni2 * provera_duzine1.out;


    component provera_duzine2 = GreaterThan(252);
    provera_duzine2.in[0] <== 110;
    provera_duzine2.in[1] <== geografska_duzina;
    izlaz <== pomocni3 * provera_duzine2.out;

/* proverava se da li je komitovani hes isti kao hes od sirine i duzine */
    component hash = Poseidon(2);
    hash.inputs[0] <== geografska_sirina;
    hash.inputs[1] <== geografska_duzina;
    com_adresa === hash.out;
}

component main { public [ com_adresa ] } = Example();

/* INPUT = {
    "geografska_sirina": "40",
    "geografska_duzina": "108",
    "com_adresa": "5287691092657086211008339722850196321523991024606176344735884055041527394191"
    
} */