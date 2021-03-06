# Adds endomorphism data to a file of colon-separated lines

# Defining polynomials have to be provided in pairs, defined by strings in x or
# by lists of integers. These polynomials (and the conjectural Sato-Tate group,
# if provided) need to be at a consistent index in the provided lines.

# Length of the lines in the input file:
line_length = 2
# Specify indices of defining polynomials and Sato-Tate group here;
# making the latter negative ignores the corresponding check.
f_index = 1
st_index = -1
# Precision:
prec = 300

import os, shutil

# Specify input and output:
base_string = 'gce_genus3_nonhyperelliptic'
inputfile = base_string + '.txt'
outputfile = base_string + '_endos.txt'

# Ambient ring:
R.<x,y,z> = PolynomialRing(QQ, 3)

@parallel(ncpus=4)
def step(line):
    global fh_index
    global R
    global prec
    global outputstream
    try:
        linestrip = line.rstrip()
        linesplit = linestrip.split(':')
        pol_list = eval(linesplit[f_index].replace('^', '**'))
        f = R(pol_list[0])
        X = mPlaneCurve(f)
        Endo = EndomorphismData(X, prec = prec, molin_neurohr = True)
        Lat_str = Endo.lattice()._desc_
        return repr(Lat_str).replace('\n', '').replace(' ', '')
    except:
        print linestrip
        return "Error"

with open(inputfile) as inputstream:
    with open(outputfile, 'w') as outputstream:
        inputlist = [ line for line in inputstream ]
        outputlist = [ ]
        for tup in list(step(inputlist)):
            outputlist.append(tup[0][0][0].rstrip() + ':' + tup[1] + '\n')
        outputlist.sort(key = lambda line: int(line.split(':')[0]))
        for line in outputlist:
            outputstream.write(line)
