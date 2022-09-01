Install["bin/gm2calc.mx"];

GM2CalcSetFlags[
    loopOrder -> 2,
    tanBetaResummation -> True,
    forceOutput -> False];

GM2CalcSetSMParameters[
    alphaMZ -> 0.0077552,   (* 1L *)
    alpha0 -> 0.00729735,   (* 2L *)
    alphaS -> 0.1184,       (* 2L *)
    MW -> 80.385,           (* 1L *)
    MZ -> 91.1876,          (* 1L *)
    MT -> 173.34,           (* 2L *)
    mbmb -> 4.18,           (* 2L *)
    ML -> 1.777,            (* 2L *)
    MM -> 0.1056583715];    (* 1L *)

MS = 5000;

Calc[smu_, chi_] :=
    Module[{spec},
           spec = GM2CalcAmuGM2CalcScheme[
               MAh    -> MS,                      (* 2L *)
               TB     -> 40,                      (* 1L *)
               Mu     -> chi,                     (* 1L *)
               MassB  -> chi,                     (* 1L *)
               MassWB -> chi,                     (* 1L *)
               MassG  -> MS,                      (* 2L *)
               mq2    -> MS^2 IdentityMatrix[3],  (* 2L *)
               ml2    -> smu^2 IdentityMatrix[3], (* 1L *)
               mu2    -> MS^2 IdentityMatrix[3],  (* 2L *)
               md2    -> MS^2 IdentityMatrix[3],  (* 2L *)
               me2    -> smu^2 IdentityMatrix[3], (* 2L *)
               Au     -> 0 IdentityMatrix[3],     (* 2L *)
               Ad     -> 0 IdentityMatrix[3],     (* 2L *)
               Ae     -> 0 IdentityMatrix[3],     (* 1L *)
               Q      -> smu                      (* 2L *)
           ];
           {
               First[MSm /. spec],  (* light smuon mass *)
               First[MChi /. spec], (* light neutralino mass *)
               amu /. spec,
               Damu /. spec
           }
    ]

(* res = Calc[500, 500] *)
(* Print[res]; *)
(* Quit[] *)

points = Tuples[{
    Subdivide[300, 1000, 100],
    Subdivide[300, 1000, 100]
}]

res = Calc[Sequence @@ #]& /@ points

Export["scan.dat", res]
