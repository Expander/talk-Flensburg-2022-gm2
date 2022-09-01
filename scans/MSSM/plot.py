#!/usr/bin/env python3

import numpy as np
import matplotlib.cm as cm
import matplotlib.pyplot as plt
import scipy.interpolate

plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]


def get_grid(filename):
    ms, mc, am, da = np.genfromtxt(filename, unpack=True, dtype=float)
    am = am*1e10
    da = da*1e10

    N = 100
    msi = np.linspace(ms.min(), ms.max(), N)
    mci = np.linspace(mc.min(), mc.max(), N)
    ami = scipy.interpolate.griddata((ms, mc), am, (msi[None,:], mci[:,None]), method='cubic')
    dai = scipy.interpolate.griddata((ms, mc), da, (msi[None,:], mci[:,None]), method='cubic')

    return msi, mci, ami, dai


def plot(xi, yi, zi, outputfile):
    fig = plt.figure(figsize=(4,4))
    plt.rc('text', usetex=True)
    plt.rc('font', family='serif', weight='normal')
    plt.xlabel(r"$m_{\tilde{\mu}_1}$ / GeV")
    plt.ylabel(r"$m_{\chi^0_1}$ / GeV")
    plt.title(r"$\tan\beta=40$, $M_{\text{SUSY}}=5\,\text{TeV}$")
    plt.xlim(np.min(xi), np.max(xi))
    plt.ylim(np.min(yi), np.max(yi))
    plt.grid(linestyle=':', linewidth=0.5)
    plt.tight_layout()

    # draw filled area with correct 1-, 2- and 3-sigma prediction of a_mu
    amu_exp_SM = 25.1
    damu_exp_SM = 5.9
    am3 = plt.contourf(xi, yi, zi, colors=['gray'],
                       levels = [amu_exp_SM - 3*damu_exp_SM, amu_exp_SM + 3*damu_exp_SM])
    am2 = plt.contourf(xi, yi, zi, colors=['yellow'],
                       levels = [amu_exp_SM - 2*damu_exp_SM, amu_exp_SM + 2*damu_exp_SM])
    am1 = plt.contourf(xi, yi, zi, colors=['green'],
                       levels = [amu_exp_SM - damu_exp_SM, amu_exp_SM + damu_exp_SM])

    plt.savefig(outputfile)
    plt.close()


msi, mci, am, da = get_grid(r'scan.dat')

plot(msi, mci, am, r'scan.pdf')
