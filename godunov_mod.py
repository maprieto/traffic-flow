import numpy as np

def godunov_mod(a,b,N,T,cfl,w0,um,rhom):
    # [a,b]: intervalo de definición.
    # N: número de pasos en espacio.
    # T: tempo final.
    # cfl: número de Courant.
    # w0: condiciún inicial (lambda function).
    # um: velocidade máxima.
    # rhom: densidade máxima.
    # 
    # Método de Godunov aplicado á ecuación do tráfico.
    # Versión con fluxo nulo no punto x=0 (asúmese a<0<b). 

    # Mallas:
    deltax=(b-a)/N
    x=np.linspace(a,b,N+1)
    w1=w0(x) # Condición inicial.
    lambd=um # Maxima velocidade posible de propagación da información. 
    deltat=cfl*deltax/lambd
    M=np.int(T/deltat)
    t=np.linspace(0,M,M+1)*deltat

    # Busqueda da fronteira máis próxima a cero:
    x0,k=np.min(np.abs(x))
    #print('Numerical method: Godunov with discontinuous flux')
    #print('Flux cutting point:',x0)

    # Información sobre a discretización:
    #print('Numerical method: Godunov')
    #print('Discretization setting:')
    #print('delta_x =',deltax)
    #print('delta_t =',deltat)
    #print('Number of time steps: M =',M,'. Final time:',t[M])

    # Inicialización:
    w=np.zeros((N+1,M+1))
    w[:,0]=w1 # Almacenamento da condición inicial.
    # w1 xa se inicializou ao construilas mallas.
    w2=np.zeros((1,N+1))
    wfront=np.zeros((1,N))
    ffront=np.zeros((1,N))

    # Bucle en tempo:
    for j in range(1,M+1):
        # En wfront[i] gardase o resultado, no punto x_{i+1/2} de resolver o problema de Riemann
        # plantexado entre as celdas i e i+1. ffront[i] é o fluxo evaluado en
        # wfront[i].
        for i in range(0,N):
            if i==k: # Fluxo nulo no punto de corte.
                ffront[i]=0
            if (w1[i]<=w1[i+1]): # Onda de choque (ou continuidade).
                s=um*(1-(w1[i]+w1[i+1])/rhom)
                if s<0:
                    wfront[i]=w1[i+1]
                elif s>=0:
                    wfront[i]=w1[i]
            else: # Onda de enrarecemento.
                if w1[i]<rhom/2:
                    wfront[i]=w1[i]
                elif w1[i+1]>rhom/2:
                    wfront[i]=w1[i+1]
                else: #w1[i]>=rhom/2>=w1[i+1]
                    wfront[i]=rhom/2

            ffront[i]=um*wfront[i]*(1.-wfront[i]/rhom)
        # Cálculo do seguinte iterante:
        w2[0]=w1[0]
        w2[1:N]=w1[1:N]-deltat/deltax*(ffront[1:N]-ffront[0:N-1])
        w2[N]=w1[N]

        # Actualización e almacenamento:
        w1=w2
        w[:,j]=w2

    return (x,t,w)