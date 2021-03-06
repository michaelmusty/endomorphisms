/***
 *  Computation of bidegrees
 *
 *  Copyright (C) 2016-2017
 *            Edgar Costa      (edgarcosta@math.dartmouth.edu)
 *            Davide Lombardo  (davide.lombardo@math.u-psud.fr)
 *            Jeroen Sijsling  (jeroen.sijsling@uni-ulm.de)
 *
 *  See LICENSE.txt for license details.
 */


import "Conventions.m": VariableOrder;


intrinsic BiDimDeg(X::Crv, Y::Crv, D::Sch) -> SeqEnum
{Given a subscheme D of the product X x Y, returns the dimension of the fibers of the projections to X and Y over the base point (P_0, Q_0) of X x Y, as well as the degree of these projections restricted to these fibers.}

A4 := Ambient(D); RA4 := CoordinateRing(A4);
RA2 := PolynomialRing(X`F, 2); A2 := AffineSpace(RA2);
seq1 := [ X`P0[1], X`P0[2], RA2.1, RA2.2 ]; seq2 := [ RA2.1, RA2.2, X`P0[1], X`P0[2] ];
varord := VariableOrder();
seq1 := [ seq1[Index(varord, i)] : i in [1..#varord] ]; seq2 := [ seq2[Index(varord, i)] : i in [1..#varord] ];
h1 := hom< RA4 -> RA2 | seq1 >; h2 := hom< RA4 -> RA2 | seq2 >;
eqs1 := [ h1(eq4) : eq4 in DefiningEquations(D) ]; eqs2 := [ h2(eq4) : eq4 in DefiningEquations(D) ];
S1 := Scheme(A2, eqs1); S2 := Scheme(A2, eqs2);
return [ [ Dimension(S1), Dimension(S2) ], [ Degree(S1), Degree(S2) ] ];

end intrinsic;


intrinsic Bidegree(X::Crv, Y::Crv, D::Sch) -> SeqEnum
{Given a subscheme D of the product X x Y, returns the degree of the projections to X and Y over the base point (P_0, Q_0) restricted to the corresponding fibers.}

A4 := Ambient(D); RA4 := CoordinateRing(A4);
RA2 := PolynomialRing(X`F, 2); A2 := AffineSpace(RA2);
seq1 := [ X`P0[1], X`P0[2], RA2.1, RA2.2 ]; seq2 := [ RA2.1, RA2.2, X`P0[1], X`P0[2] ];
varord := VariableOrder();
seq1 := [ seq1[Index(varord, i)] : i in [1..#varord] ]; seq2 := [ seq2[Index(varord, i)] : i in [1..#varord] ];
h1 := hom< RA4 -> RA2 | seq1 >; h2 := hom< RA4 -> RA2 | seq2 >;
eqs1 := [ h1(eq4) : eq4 in DefiningEquations(D) ]; eqs2 := [ h2(eq4) : eq4 in DefiningEquations(D) ];
S1 := Scheme(A2, eqs1); S2 := Scheme(A2, eqs2);
return [ Degree(S1), Degree(S2) ];

f1 := map< Curve(D) -> Curve(X`U) | [ RA4.varord[1], RA4.varord[2] ]>;
f2 := map< Curve(D) -> Curve(X`U) | [ RA4.varord[3], RA4.varord[4] ]>;
f1 := ProjectiveClosure(f1); f2 := ProjectiveClosure(f2);
return [ Degree(f1), Degree(f2) ];

end intrinsic;
