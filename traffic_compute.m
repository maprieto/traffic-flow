function traffic_compute(N,T,cfl,rhom,um,godunov_compute,filename,handles)

% Variables para facelas chamadas:
%a=-5000; %m
%b=5000; %m
%N=100;% INPUT
%T=3; %min% INPUT
%cfl=0.95;% INPUT
%rhom=0.218; %coches/m % INPUT
%um=100*1000/3600; % m/min (= 100 km/h)

%w0=@w0_cte; % Condici�n inicial constante
% Estado inicial:
%rho0=0.100; % INPUT
% Load rho0 and define w0 from filename
load(filename,'rho0','a','b')
if(numel(rho0)==1)
    w0=@(x) rho0*ones(1,numel(x));
else
    w0=@(x) rho0;
end

% Par�metros para a representaci�n:
extrax=(b-a)/10;
extray=rhom/10;
liminf=0;
limsup=rhom+extray;

% Soluci�n aproximada:
[x,t,rho_aprox]=godunov_compute(a,b,N,T*60,cfl,w0,um*1000/3600,rhom/1000);
Mt=length(t)-1;
dt=t(2)-t(1);
rho_aprox(1,:)=nan;
rho_aprox(end,:)=nan;

% Representaci�n:
% Estado inicial:
cla(handles.axes1)
axes(handles.axes1)
plot(x,1000*rho_aprox(:,1),'b','LineWidth',2)
axis(handles.axes1,[a-extrax,b+extrax,liminf,limsup])
title(handles.axes1,'t = 0 min')
xlabel(handles.axes1,'x [m]')
ylabel(handles.axes1,'\rho [vehicles/km]')
%--------------- Plot vehicle road ---------------------------------
cla(handles.axes2)
axes(handles.axes2)
% Spatial discretization
hN=(b-a)/N;
vehicles=hN*cumsum(1000*rho_aprox(2:end-1,1));
cumsum_max=hN*N*rhom;
% Vehicle position
nx=min(N/10,10);
n_vehicles=2*nx;
%x_vehicle=linspace(a,b,n_vehicles);
% Length of each vehicle
hx=(b-a)/(nx+1)*4/10;
% Minimum distance between vehicles
h_blank=(b-a)/(nx+1)/10;
M=cumsum_max/n_vehicles;

% Compute vehicle position at initial time
j=0;
x_vehicle=[];
ind_vehicle=[];
while j<=n_vehicles
    j=j+1;
    ind=find((j-1)*M<vehicles & vehicles<=j*M);
    if isempty(ind)
        break
    else
        %ind_vehicle=[ind_vehicle, round(mean(ind))];
        ind_vehicle=[ind_vehicle, ind(end)];
        x_vehicle=[x_vehicle, x(ind_vehicle(j))];
    end
end
% Plot
hold(handles.axes2,'on')
for j=1:numel(x_vehicle)
    rectangle('Position',[x_vehicle(j),0,hx,hx/2],'FaceColor','k')
end
axis(handles.axes2,[a-extrax,b+extrax,-10*hx,10*hx])
set(handles.axes2,'Ytick',[],'Xtick',[])
hold(handles.axes2,'off')
pause(0.1)

% ----------------------- Bucle en tiempo: --------------------------------
for j=2:Mt+1
    % Plot vehicle density
    axes(handles.axes1)
    %numel(x),numel(rho_aprox(:,j)),j,M
    plot(x,1000*rho_aprox(:,j),'b','LineWidth',2)
    axis(handles.axes1,[a-extrax,b+extrax,liminf,limsup])
    title(handles.axes1,['t = ',num2str((t(j)+dt)/60),' min'])
    xlabel(handles.axes1,'x [m]')
    ylabel(handles.axes1,'\rho [vehicles/km]')
    %--------------- Plot vehicle road ---------------------------------
    axes(handles.axes2)
    % Compute velocity
    vel_vehicles=um*(1-1000*rho_aprox(ind_vehicle,j)'/rhom);
    ind1=find(ind_vehicle==1);
    if(~isempty(ind1))
        vel_vehicles(ind1)=um*(1-1000*rho_aprox(2,j)'/rhom);
    end
    ind_last=find(isnan(vel_vehicles));
    if(~isempty(ind_last))
        vel_vehicles(ind_last)=um*(1-1000*rho_aprox(ind_last-1,j)'/rhom);
    end
    % Update position
    if(get(handles.uipanel8,'UserData')==2)
        x_vehicle_new=x_vehicle+dt*vel_vehicles;
    else
        x_vehicle_new=x_vehicle+dt*vel_vehicles;
        ind=find(x_vehicle<=0);
        % No vehicles on the left side can go through x=0
        for k=1:numel(ind)
            if x_vehicle_new(k)>0
                x_vehicle_new(k)=0;
            end
        end
    end
    % Check the minimun distance between two consecutive vehicles
    for k=numel(x_vehicle)-1:-1:1
        if(abs(x_vehicle_new(k)-x_vehicle_new(k+1))<6*h_blank)
            x_vehicle_new(k)=x_vehicle_new(k+1)-6*h_blank;
        end
    end
    x_vehicle=x_vehicle_new;
    
    % Get new indices for each vehicle
    for k=1:numel(x_vehicle)
        [aux,ind_vehicle(k)]=min(abs(x_vehicle(k)-x));
    end
    % Add new vehicles on the right
    dist=x_vehicle(2)-x_vehicle(1);
    if(x_vehicle(1)-a>dist-4*h_blank)
        x_vehicle=[a-4*h_blank, x_vehicle];
        ind_vehicle=[1, ind_vehicle];
    end
    % Delete vehicles on the left
    if(x_vehicle(end)>b-2*h_blank)
        x_vehicle(end)=[];
        ind_vehicle(end)=[];
    end
    
    % Plot new position
    cla(handles.axes2)
    hold(handles.axes2,'on')
    for j=1:numel(x_vehicle)
        rectangle('Position',[x_vehicle(j),0,hx,hx/2],'FaceColor','k')
    end
    axis(handles.axes2,[a-extrax,b+extrax,-10*hx,10*hx])
    hold(handles.axes2,'off')
    pause(0.1)
end
