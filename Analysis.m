clear all; close all; clc;

%% Simbólico para coletar expressões
syms s P I

G(s) = (1-s)/((s+1)*(s+2));

K(s) = (P*s+I)/s;

T(s) = K*G/(1+K*G);

[N,D] = numden(T);
N_sim = collect(N(s));
D_sim = collect(D(s)); % de olho no denominador
%%
clear all; close all; clc;
%% Visualizando a resposta em malha aberta e fechada simples
% Útil para ver qual a respota "natural" e ordem de grandeza temporal

s = tf('s');

G = (1-s)/((s+1)*(s+2));
T = G/(1+G); % uncontrolled

figure();
step(G)
stepinfo(G)
figure();
step(T)
stepinfo(T)

% ramp
figure();
step(G/s)
stepinfo(G/s)
figure();
step(T/s)
stepinfo(T/s)

%% Visualização em Coordenadas Paralelas

% Força Bruta - "Passo Largo"

count = 1;
KpArray = -1.9:0.1:2.9;
KiStep = 10;
% pre-allocate Size
Kp = zeros(length(KpArray)*KiStep,1);
Ki = zeros(length(KpArray)*KiStep,1);
ts = zeros(length(KpArray)*KiStep,1);
Mp = zeros(length(KpArray)*KiStep,1);
Und = zeros(length(KpArray)*KiStep,1);
Erampa = zeros(length(KpArray)*KiStep,1);

for i = KpArray
    Ki_sup = (i-3)*(i+2)/(i-4); % estritamente é o supremo
    epsilon = Ki_sup/100; % limite arbitrário
    KiArray = (epsilon):(Ki_sup/KiStep):(Ki_sup-epsilon); % 10 valores
    for j = KiArray
        k = [i j];
        valores = var_analise(k);
        %
        Kp(count,1) = i;
        Ki(count,1) = j;
        ts(count,1) = valores(1);
        Mp(count,1) = valores(2);
        Und(count,1) = valores(3);
        Erampa(count,1) = valores(4);
        %
        count = count + 1;
    end
end
tableBF = table(Kp, Ki, ts, Mp, Und, Erampa);

% Gráfico
figure();
parallelplot(tableBF);
set(gcf,'color','w');
title("Representação de Espaço Discretizado em Coordenadas Paralelas");
