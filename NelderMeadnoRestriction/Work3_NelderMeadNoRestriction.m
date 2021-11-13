%%
clear all; close all; clc;
%% Método de Otimização
% Método de Nelder-Mead sem restrições

rng(321); % random seed -> para reproducibilidade

tic % To get Optimization Time

totalIt = 30;
% pre-allocate Size
d = zeros(totalIt,4);
Kp0 = zeros(totalIt,1);
Ki0 = zeros(totalIt,1);
Kp = zeros(totalIt,1);
Ki = zeros(totalIt,1);
ts = zeros(totalIt,1);
Mp = zeros(totalIt,1);
Und = zeros(totalIt,1);
Erampa = zeros(totalIt,1);
%

for i = 1:1:totalIt
    
    while (Kp(i,1) <= -2 || Kp(i,1) >= 3 || Ki(i,1) <= 0) % just as precaution
    
        d(i,:) = [3.0+3.0*rand(),0.05+0.1*rand(),0.05+0.1*rand(),2.0+1.5*rand()];
        Kp0(i,1) = -2 + 5*rand();
        Ki_sup = (Kp0(i,1)-3)*(Kp0(i,1)+2)/(Kp0(i,1)-4);
        Ki0(i,1) = Ki_sup*rand();

        x0 = [Kp0(i,1), Ki0(i,1)];
        J = @(x) cost_function(d(i,:), x);
        x = fminsearch(J, x0);
        valores = var_analise(x);

        Kp(i,1) = x(1);
        Ki(i,1) = x(2);
        ts(i,1) = valores(1);
        Mp(i,1) = valores(2);
        Und(i,1) = valores(3);
        Erampa(i,1) = valores(4);
    end
    
end
tableOpt = table(Kp, Ki, ts, Mp, Und, Erampa);

toc

%%
clear all; close all; clc;
%% Gráfico de Resultados Ótimos

%Kp = [0.183188489516079;0.676130876959941;0.247511031568209; ...
%    0.120478331417029;0.485841797500900;0.368169366491300];
%Ki = [0.472724317396447;0.724891954430572;0.503612269109657; ...
%    0.515523122997371;0.653663782784662;0.547660250671736];

ts = [6.78000000000000;4.04000000000000;6.34000000000000; ...
    6.18000000000000;4.70000000000000;5.78000000000000];
Mp = [0.0322474104183128;0.0492961874218769;0.0333331256772158; ...
    0.0791882426506179;0.0585939237411819;0.0269860729729881];
Und = [0.0702417053615262;0.180361937245472;0.0821449662602555; ...
    0.0686205355297025;0.136513575429206;0.105522924098771];
Erampa = [4.23079568027112;2.75903186368108;3.97130912544253; ...
    3.87955439975521;3.05967693587035;3.65189914284794];

tableSelect = table(ts, Mp, Und, Erampa);

figure();
    p = parallelplot(tableSelect);
    set(gcf,'color','w');
    title("Soluções Ótimas em Coordenadas Paralelas");




