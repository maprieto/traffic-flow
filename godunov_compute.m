function godunov_compute(N,T,cfl,rhom,um,filename,handles)

% Variables para facelas chamadas:
a=-5000; %m
b=5000; %m
%N=100;% INPUT
%T=3; %min% INPUT
%cfl=0.95;% INPUT
%rhom=0.218; %coches/m % INPUT
%um=100*1000/60; % m/min (= 100 km/h)

%w0=@w0_cte; % Condici�n inicial constante
% Estado inicial:
%rho0=0.100; % INPUT
% Load rho0 and w0 from filename

% Par�metros para a representaci�n:
extrax=(b-a)/10;
extray=1000*rhom/10;
liminf=0;
limsup=1000*rhom+extray;

% Soluci�n aproximada:
disp('M�todo empregado: Godunov con interrupci�n do fluxo')
[x,t,rho_aprox]=godunov_mod(a,b,N,T,cfl,w0,um,rhom);
        
M=length(t)-1;

% Representaci�n:
% Estado inicial:
figure()
plot(x,1000*rho_aprox(:,1),'b','LineWidth',2)
axis([a-extrax,b+extrax,liminf,limsup])
title('t = 0 min')
xlabel('x (m)')
ylabel('\rho (coches/km)')
pause(1)
% Bucle en tiempo:
for j=2:M+1
    plot(x,1000*rho_aprox(:,j),'b','LineWidth',2)
    axis([a-extrax,b+extrax,liminf,limsup])
    title(['t = ',num2str(t(j)),' min'])
    xlabel('x (m)')
    ylabel('\rho (coches/km)')
    pause(0.1)
end

% Secuencia de imaxes fixas:
[t1,k1]=min(abs(t-1)); % t1 = 1 minutos.
[t2,k2]=min(abs(t-2)); % t2 = 2 minutos.
[t3,k3]=min(abs(t-3)); % t3 = 3 minutos.

figure(2)

subplot(1,3,1)
plot(x,1000*rho_aprox(:,k1),'k','LineWidth',2)
axis([a-extrax,b+extrax,liminf,limsup])
title(['t = 1 minuto'])
xlabel('x (m)')
ylabel('\rho (coches/km)')

subplot(1,3,2)
plot(x,1000*rho_aprox(:,k2),'k','LineWidth',2)
axis([a-extrax,b+extrax,liminf,limsup])
title(['t = 2 minutos'])
xlabel('x (m)')
ylabel('\rho (coches/km)')

subplot(1,3,3)
plot(x,1000*rho_aprox(:,k3),'k','LineWidth',2)
axis([a-extrax,b+extrax,liminf,limsup])
title(['t = 3 minutos'])
xlabel('x (m)')
ylabel('\rho (coches/km)')

% Gardamos en ficheiro para posterior uso:
rho_ronda_2min=rho_aprox(:,k2);
save('rho0_ronda','rho_ronda_2min')
