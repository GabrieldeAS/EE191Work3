clear all; close all; clc;

%% Método de Otimização
% Método de algoritmo evolutivo

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
        % init
    d(i,:) = [3.0+3.0*rand(),0.05+0.1*rand(),0.05+0.1*rand(),2.0+1.5*rand()];
    Kp0(i,1) = -2 + 5*rand();
    Ki_sup = (Kp0(i,1)-3)*(Kp0(i,1)+2)/(Kp0(i,1)-4);
    Ki0(i,1) = Ki_sup*rand();
        % - optimization
    x0 = [Kp0(i,1), Ki0(i,1)];
    J = @(x) cost_function(d(i,:), x);
    % [x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],lb,ub,ConstraintFunction,options)
    options.InitialPopulationMatrix = x0;
    lb = [-2,0];
    ub = [3,Inf];
    nvars = 2;
    % Visualization
    %options = optimoptions("ga",'PlotFcn',{@gaplotbestf,@gaplotmaxconstr}, ...
    %           'Display','iter');
    %
    x = ga(J,nvars,[],[],[],[],lb,ub,'constraint_function',options);
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

% 4.52     0.01788     0.16683    3.0264
% 6.22    0.060308     0.07306    3.9092
% 4.19      0.0178      0.1847    2.8796
% 5.65    0.047905    0.097957    3.5788
% 5.22    0.048865     0.11544    3.3421
% 5.71    0.077005    0.083578    3.5961

ts = [4.52;6.22;4.19; ...
    5.65;5.22;5.71];
Mp = [0.01788;0.060308;0.0178; ...
    0.047905;0.048865;0.077005];
Und = [0.16683;0.07306;0.1847; ...
    0.097957;0.11544;0.083578];
Erampa = [3.0264;3.9092;2.8796; ...
    3.5788;3.3421;3.5961];

tableSelect = table(ts, Mp, Und, Erampa);

figure();
    p = parallelplot(tableSelect);
    set(gcf,'color','w');
    title("Soluções Ótimas em Coordenadas Paralelas com GA");




