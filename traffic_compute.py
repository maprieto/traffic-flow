import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt
import ipywidgets as widgets
from IPython.display import display, clear_output
from godunov import *
from godunov_mod import *
# %matplotlib inline
#def traffic_compute(N,T,cfl,rhom,um,godunov_compute,filename,handles):

# Variables para facelas chamadas:
N=100 # INPUT
T=1 #min# INPUT
cfl=0.95# INPUT
rhom=250 #coches/km # INPUT
um=50 #  km/h
jam =0 # jam or not
filename='initial_condition_jam_horreo.mat'

# Load rho0 and define w0 from filename
content = sio.loadmat(filename)
rho0 = content['rho0'][0]
a = content['a'][0][0]
b = content['b'][0][0]
if(np.size(rho0)==1):
    w0=lambda x: rho0*np.ones(np.size(x))
else:
    w0=lambda x: rho0

# Parámetros para a representación:
extrax=(b-a)/10.
extray=rhom/10.
liminf=0.
limsup=rhom+extray

# Solución aproximada
if jam == 0:
    x,t,rho_aprox=godunov(a,b,N,T*60,cfl,w0,um*1000/3600,rhom/1000)
else:
    x,t,rho_aprox=godunov_mod(a,b,N,T*60,cfl,w0,um*1000/3600,rhom/1000)

Mt=np.size(t)-1
dt=t[1]-t[0]
rho_aprox[0,:]=np.nan
rho_aprox[-1,:]=np.nan

# Representación:
# Estado inicial:
plt.plot(x,1000*rho_aprox[:,0])
plt.xlim(a-extrax,b+extrax)
plt.ylim(liminf,limsup)
plt.title('t = 0 min')
plt.xlabel('$x$ [m]')
plt.ylabel('$\rho$ [vehicles/km]')

# ----------------------- Bucle en tiempo: --------------------------------
for j in range(1,Mt+1):
    # Plot vehicle density
    plt.plot(x,1000*rho_aprox[:,j])
    plt.xlim(a-extrax,b+extrax)
    plt.ylim(liminf,limsup)
    plt.title('t = '+'%.3f' % ((t[j]+dt)/60)+' min')
    plt.xlabel('$x$ [m]')
    plt.ylabel('$\rho$ [vehicles/km]')
