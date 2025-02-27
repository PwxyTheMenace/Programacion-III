% Consultas de ejemplo:
% ?- conexion(vancouver, winnipeg, Costo, Ruta)   % Costo = 48,
%Ruta = [(vancouver,0), (edmonton,16), (saskatoon,12), (winnipeg,20)]

% ?- conexiones(regina, ListaConexiones)         % Lista debería ser [(winnipeg, 4)]

% ?- nodo_con_aristas(regina)         % Debería ser true

%?- costo(vancouver, winnipeg, CostoTotal). %Costo = 27


% Hechos que representan las conexiones entre los nodos y sus costos
arista(vancouver, edmonton, 16).
arista(vancouver, calgary, 13).
arista(edmonton, saskatoon, 12).
arista(saskatoon, winnipeg, 20).
arista(saskatoon, calgary, 9).
arista(calgary, regina, 14).
arista(calgary, edmonton, 4).
arista(regina, winnipeg, 4).
arista(regina, saskatoon, 7).

% Regla para determinar si existe una conexión indirecta entre dos nodos, obteniendo el costo y la ruta
conexion(X, Y, Costo, Ruta) :- camino(X, Y, [(X,0)], RutaInvertida, 0, Costo), reverse(RutaInvertida, Ruta).

% Regla auxiliar para construir la ruta y calcular el costo acumulado
camino(X, Y, Visitados, [(Y,Costo)|Visitados], CostoAcum, CostoTotal) :-
    arista(X, Y, Costo),
    CostoTotal is CostoAcum + Costo.
camino(X, Y, Visitados, Ruta, CostoAcum, CostoTotal) :-
    arista(X, Z, Costo),
    \+ member((Z,_), Visitados),
    NuevoCosto is CostoAcum + Costo,
    camino(Z, Y, [(Z,Costo)|Visitados], Ruta, NuevoCosto, CostoTotal).

% Regla para determinar con qué nodos está conectado un nodo y el costo de cada conexión
conexiones(Nodo, ListaConexiones) :-
    findall((Destino, Costo), arista(Nodo, Destino, Costo), ListaConexiones).

% Regla para determinar si un nodo tiene al menos una arista
nodo_con_aristas(Nodo) :- arista(Nodo, _, _); arista(_, Nodo, _).

% Regla para calcular el costo de la ruta más corta entre dos nodos, pasando por un nodo intermedio automáticamente
costo(X, Z, CostoTotal) :-
    arista(X, Y, Costo1),
    arista(Y, Z, Costo2),
    CostoTotal is Costo1 + Costo2.

costo(X, Z, CostoTotal) :-
    arista(X, Y, Costo1),
    arista(Y, Z, Costo2),
    CostoTotal is Costo1 + Costo2,
    !.

costo(X, Z, CostoTotal) :-
    arista(X, Y, Costo1),
    costo(Y, Z, CostoIntermedio),
    CostoTotal is Costo1 + CostoIntermedio.