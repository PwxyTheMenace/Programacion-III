% Consultas de ejemplo:

% ?- nodo_con_aristas(regina)         % Debería ser true


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

% Regla para determinar si un nodo tiene al menos una arista
nodo_con_aristas(Nodo) :- arista(Nodo, _, _); arista(_, Nodo, _).

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
      
%