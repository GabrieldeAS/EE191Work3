function J = cost_function(pesos, parametros)


%% Coletando Parametros

tsd = pesos(1);
Mpd = pesos(2);
Undd = pesos(3);
Erampad = pesos(4);

%% Calculando a Função Custo

valores = var_analise(parametros);

ts = valores(1);
Mp = valores(2);
Und = valores(3);
Erampa = valores(4);

J = (ts/tsd)^2 + (Mp/Mpd)^2 + (Und/Undd)^2 + (Erampa/Erampad)^2;

end

