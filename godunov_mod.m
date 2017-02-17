function [x,t,w]=godunov_mod(a,b,N,T,cfl,w0,um,rhom)
%
% [x,t,w]=godunov(a,b,N,T,cfl,w0,um,rhom)
% 
% [a,b]: intervalo de definici�n.
% N: n�mero de pasos en espacio.
% T: tempo final.
% cfl: n�mero de Courant.
% w0: condici�n inicial (punteiro a unha funci�n .m).
% um: velocidade m�xima.
% rhom: densidade maxima.
% 
% M�todo de Godunov aplicado � ecuaci�n do tr�fico.
% Versi�n con fluxo nulo no punto x=0 (as�mese a<0<b).

% Mallas:
deltax=(b-a)/N;
x=linspace(a,b,N+1);
w1=feval(w0,x); % Condici�n inicial.
lambda=um; % M�xima velocidade posible de propagaci�n da informaci�n.
deltat=cfl*deltax/lambda;
M=floor(T/deltat);
t=[0:M]*deltat;

% Busqueda da fronteira m�is pr�xima a cero:
[x0,k]=min(abs(x));
fprintf('Numerical method: Godunov with discontinuous flux\n')
fprintf('Flux cutting point: %.2f\n',x0);

% Informaci�n sobre a discretizaci�n:
fprintf('Discretization setting:\n')
fprintf('\t delta_x = %f\n',deltax)
fprintf('\t delta_t = %f\n',deltat)
fprintf('\t Number of time steps: M = %i. Final time: %f\n\n',M,t(M+1));

% Inicializaci�n:
w=zeros(N+1,M+1);
w(:,1)=w1'; % Almacenamento da condici�n inicial.
% w1 xa se inicializou � construilas mallas.
w2=zeros(1,N+1);
wfront=zeros(1,N);
ffront=zeros(1,N);

% Bucle en tempo:
for j=2:M+1
    % En wfront(i) gardase o resultado, no punto x_{i+1/2} de resolver o problema de Riemann
    % plantexado entre as celdas i e i+1. ffront(i) � o fluxo evaluado en
    % wfront(i).
    for i=1:N
        if i==k % Fluxo nulo no punto de corte.
            ffront(i)=0;
            continue
        end
        if w1(i)<=w1(i+1) % Onda de choque (ou continuidade).
            s=um*(1-(w1(i)+w1(i+1))/rhom);
            if s<0
                wfront(i)=w1(i+1);
            elseif s>=0
                wfront(i)=w1(i);
            end
        else % Onda de enrarecemento.
            if w1(i)<rhom/2
                wfront(i)=w1(i);
            elseif w1(i+1)>rhom/2
                wfront(i)=w1(i+1);
            else %w1(i)>=rhom/2>=w1(i+1)
                wfront(i)=rhom/2;
            end
        end
        ffront(i)=um*wfront(i)*(1-wfront(i)/rhom);
    end
    % C�lculo do seguinte iterante:
    w2(1)=w1(1);
    w2(2:N)=w1(2:N)-deltat/deltax*(ffront(2:N)-ffront(1:N-1));
    w2(N+1)=w1(N+1);
    
    % Actualizaci�n e almacenamento:
    w1=w2;
    w(:,j)=w2';
end

return