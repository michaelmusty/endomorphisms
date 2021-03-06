"""
 *  Some examples of endomorphism rings in genus 2 over general number fields
"""

from endomorphisms import EndomorphismData, mHyperellipticCurve

Xs = [ ]

# An example by Haluk Sengun
R.<t> = PolynomialRing(QQ)
F.<r> = NumberField(t^2 - t + 1)
R.<x> = PolynomialRing(F)
f = R([ -30*r + 42, -156*r + 312, -66*r + 186, -1456*r + 1040, -90*r + 126, 156*r - 312, -22*r + 62 ])
h = R(0)
Xs.append(mHyperellipticCurve(f, h))

R.<t> = PolynomialRing(QQ)
F.<r> = NumberField(t^2 + 1)
R.<x> = PolynomialRing(F)
f = x^5 - x^4 + 4*x^3 - 8*x^2 + 5*x - 1
h = R(0)
Xs.append(mHyperellipticCurve(f, h))

for X in Xs:
    print X
    Endo = EndomorphismData(X, prec = 300, molin_neurohr = False)

    print "Field of definition:"
    print Endo.endomorphism_field()

    print "Geometric representation:"
    Geo = Endo.geometric()
    print Geo.representation()
    print Geo.pretty_print()

    print "Lattice:"
    print Endo.lattice().pretty_print()
