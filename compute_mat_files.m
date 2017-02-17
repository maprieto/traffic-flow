% Create those mat-files associated to each simulation case

% File for ronda 1
clear all
delete initial_condition_uniform_100vechicles_ronda.mat
rho0=0.1;
a=-5000; %m
b=5000; %m
save initial_condition_uniform_100vechicles_ronda.mat

% File for ronda 2
clear all
delete initial_condition_jam_ronda.mat
load('./data/rho0_ronda','rho_ronda_2min')
rho0=rho_ronda_2min';
clear rho_ronda_2min
a=-5000; %m
b=5000; %m
save initial_condition_jam_ronda.mat

% File for horreo 1
clear all
delete initial_condition_uniform_140vechicles_horreo.mat
rho0=0.140;
a=-350; %m
b=150; %m
save initial_condition_uniform_140vechicles_horreo.mat

% File for horreo 2
clear all
delete initial_condition_jam_horreo.mat
load('./data/rho0_horreo','rho_horreo_10seg')
rho0=rho_horreo_10seg';
clear rho_horreo_10seg
a=-350; %m
b=150; %m
save initial_condition_jam_horreo.mat
