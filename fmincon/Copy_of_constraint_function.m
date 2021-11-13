function [C,Ceq] = constraint_function(parametros)


%% Coleta

Kp = parametros(1);
Ki = parametros(2);

%% Desigualdade de Ki

C = Ki - (Kp-3)*(Kp+2)/(Kp-4);
Ceq = [];

end