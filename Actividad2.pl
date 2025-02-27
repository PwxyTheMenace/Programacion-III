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