# Traffic flow
Numerical simulation of traffic flow using Godunov schemes. The initial conditions come from some normal of jam traffic cases in two urban tunnels, located in Ronda (A Coruña, Spain) and Horreo (Santiago de Compostela, Spain). The required user data are the vehicle density, the maximum velocity allowed, and the occurrence of a traffic jam. The numerical setting is provided by means of the number of cells and the CFL constant. 

Download
--------

To get the git version of **Traffic flow**, from the command line in a terminal, type:

    $ git clone git://github.com/maprieto/traffic-flow

Installation and usage
--------------------

This software does not need any particular installation. Since it is based in Jupyter notebooks and/or Matlab scripts, 

* Using **MATLAB**: it is required a Matlab installation (possibly with a limited educational license). To use this code, from the MATLAB command window, type 
```
    traffic_flow.m
```
* Using **Jupyter notebooks**: either a local host of Jupyter notebook server should be running or any cloud-based platforms can be used with the notebook
```
   traffic_flow.ipynb
```

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/maprieto/traffic-flow/master?filepath=traffic_flow.ipynb)
