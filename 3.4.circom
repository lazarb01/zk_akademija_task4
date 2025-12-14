pragma circom 2.1.6;
include "circomlib/comparators.circom";
include "circomlib/poseidon.circom";

template Example () {
    signal input hesevi[10];
    signal input tajni_kod;
    signal poklapanja[10];
    component provera[10];
    signal hes_tajni_kod;
    signal pomocni1;
    signal pomocni2;
    signal pomocni3;
    signal pomocni4;
    signal pomocni5;
    signal pomocni6;
    signal pomocni7;
    signal pomocni8;
    signal pomocni9;
    signal output izlaz;

    /*prvo hesiramo tajni kod na ulazu*/

    component hash = Poseidon(1);
    hash.inputs[0]<== tajni_kod;
    hes_tajni_kod <== hash.out;

    /* radimo proveru da li je hesiran tajni kod jednak nekom od heseva iz liste,
    rezultat svake provere smestamo u poklapanja,
    rezultat je 0 ako su razliciti, 
    1 ako su jednaki*/
      for (var i = 0; i < 10; i++) {
        provera[i] = IsEqual();
        provera[i].in[0] <== hes_tajni_kod;
        provera[i].in[1] <== hesevi[i];
        poklapanja[i] <== provera[i].out;
    }

    /*pravimo zbir svih provera da bismo videli da li je taj zbir veci od nule,
     ako jeste to znaci da imamo bar jedno poklapanje*/ 
    pomocni1 <== poklapanja[0] + poklapanja [1];
    pomocni2 <== pomocni1 + poklapanja[2];
    pomocni3 <== pomocni2 + poklapanja[3];
    pomocni4 <== pomocni3 + poklapanja[4];
    pomocni5 <== pomocni4 + poklapanja[5];
    pomocni6 <== pomocni5 + poklapanja[6];
    pomocni7 <== pomocni6 + poklapanja[7];
    pomocni8 <== pomocni7 + poklapanja[8];
    pomocni9 <== pomocni8 + poklapanja[9];

/* argument u GreaterThan govori sa koliko bitova predstavljamo broj, posto je nama
    zbir izmedju 1 i 10(lista moze da ima deset istih heseva), uzimamo 4, jer 10 < 2^4*/
    component izlazna_provera = GreaterThan(4);
    izlazna_provera.in[0] <== pomocni9;
    izlazna_provera.in[1] <== 0;
    izlaz <== izlazna_provera.out;


}
component main { public [hesevi] } = Example();

/* test primeri su hesevi brojeva od 1 do 10*/

/* INPUT = {
    "hesevi":["18586133768512220936620570745912940619677854269274689475585506675881198879027",
        "8645981980787649023086883978738420856660271013038108762834452721572614684349",
        "6018413527099068561047958932369318610297162528491556075919075208700178480084",
        "9900412353875306532763997210486973311966982345069434572804920993370933366268",
        "19065150524771031435284970883882288895168425523179566388456001105768498065277",
        "4204312525841135841975512941763794313765175850880841168060295322266705003157",
        "7061949393491957813657776856458368574501817871421526214197139795307327923534",
        "8761383103374198182292249284037598775384145428470309206166618811601037048804",
        "5199363853932272446084541931873785938987820779897294035064941545455873932186",
        "17853941289740592551682164141790101668489478619664963356488634739728685875777"],
    "tajni_kod": "5"
    
} */