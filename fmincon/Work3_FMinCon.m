clear all; close all; clc;

%% build-up

rng(321);

tic

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


for i = 1:1:totalIt
        % init
    d(i,:) = [3.0+3.0*rand(),0.05+0.1*rand(),0.05+0.1*rand(),2.0+1.5*rand()];
    Kp0(i,1) = -2 + 5*rand();
    Ki_sup = (Kp0(i,1)-3)*(Kp0(i,1)+2)/(Kp0(i,1)-4);
    Ki0(i,1) = Ki_sup*rand();
        % - optimization
    x0 = [Kp0(i,1), Ki0(i,1)];
    J = @(x) cost_function(d(i,:), x);
    % x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options) 
    lb = [-2,0];
    ub = [3,Inf];
    % Opções de Algoritmos que suportam esse problema
    %options = optimoptions('fmincon','Algorithm','interior-point');
    options = optimoptions('fmincon','Algorithm','sqp');
    %
    x = fmincon(J,x0,[],[],[],[],lb,ub,'constraint_function',options);
    % seize
    valores = var_analise(x);
    Kp(i,1) = x(1);
    Ki(i,1) = x(2);
    ts(i,1) = valores(1);
    Mp(i,1) = valores(2);
    Und(i,1) = valores(3);
    Erampa(i,1) = valores(4);
end

tableOpt = table(Kp, Ki, ts, Mp, Und, Erampa)

toc

%%
clear all; close all; clc;
%% Gráfico de Resultados Ótimos

%% IPM

% 4.34    0.035139     0.16751     2.919
% 6.67    0.051716    0.064414    4.1841
% 6.01     0.07763    0.073674    3.7757
% 6.55     0.02516    0.081216    4.0826
% 7.55    0.022775     0.05829    4.6771
% 5.41     0.08231    0.093174    3.4167

ts = [4.34;6.67;6.01; ...
    6.55;7.55;5.41];
Mp = [0.035139;0.051716;0.07763; ...
    0.02516;0.022775;0.08231];
Und = [0.16751;0.064414;0.073674; ...
    0.081216;0.05829;0.093174];
Erampa = [2.919;4.1841;3.7757; ...
    4.0826;4.6771;3.4167];

tableSelect = table(ts, Mp, Und, Erampa);

figure();
    p = parallelplot(tableSelect);
    set(gcf,'color','w');
    title("Soluções Ótimas em Coordenadas Paralelas para IPM");

%% SQP

% 5.07    0.085493     0.10701    3.2215
% 4.83    0.055328      0.1311    3.1303
% 4.1    0.041204     0.17958    2.8001
% 6.51    0.060241    0.065487    4.0877
% 7.56    0.022628    0.058181    4.6827
% 5.92    0.049945    0.087002    3.7324

ts = [5.07;4.83;4.1; ...
    6.51;7.56;5.92];
Mp = [0.085493 ;0.055328;0.041204; ...
    0.060241;0.022628;0.049945];
Und = [0.10701;0.1311;0.17958; ...
    0.065487;0.058181;0.093174];
Erampa = [3.2215;3.1303;0.087002; ...
    4.0877;4.6827;3.7324];

tableSelect = table(ts, Mp, Und, Erampa);

figure();
    p = parallelplot(tableSelect);
    set(gcf,'color','w');
    title("Soluções Ótimas em Coordenadas Paralelas para SQP");


