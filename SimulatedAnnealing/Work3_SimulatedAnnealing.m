clear all; close all; clc;

%% Método de Otimização
% Método de Nelder-Mead com inclusão de restrições

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
x = [0.01,0.01];

for i = 1:1:totalIt
    while true  % Ki non-linear constraint
        % init
        d(i,:) = [3.0+3.0*rand(),0.05+0.1*rand(),0.05+0.1*rand(),2.0+1.5*rand()];
        Kp0(i,1) = -2 + 5*rand();
        Ki_sup = (Kp0(i,1)-3)*(Kp0(i,1)+2)/(Kp0(i,1)-4);
        Ki0(i,1) = Ki_sup*rand();
            % - optimization
        x0 = [Kp0(i,1), Ki0(i,1)];
        J = @(x) cost_function(d(i,:), x);
        % x = simulannealbnd(FUN,X0,LB,UB)
        lb = [-2,0];
        ub = [3,Inf];
        nvars = 2;
        x = simulannealbnd(J,x0,lb,ub);
        if x(2) - (x(1)-3)*(x(1)+2)/(x(1)-4) < 0
            break;
        end
    end
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

% 3.95    0.048947     0.18677    2.7196
% 6.51    0.040268    0.073277    4.0779
% 5.72    0.049151    0.094652    3.6178
% 5.04    0.028288     0.13522    3.2647
% 4.66    0.018419     0.15955    3.0897
% 4.38    0.041879     0.16204    2.9273

ts = [3.95;6.51;5.72; ...
    5.04;4.66;4.38];
Mp = [0.048947;0.040268;0.049151; ...
    0.028288;0.018419;0.041879];
Und = [0.18677;0.073277;0.094652; ...
    0.13522;0.15955;0.16204];
Erampa = [2.7196;4.0779;3.6178; ...
    3.2647;3.0897;2.9273];

tableSelect = table(ts, Mp, Und, Erampa);

figure();
    p = parallelplot(tableSelect);
    set(gcf,'color','w');
    title("Soluções Ótimas em Coordenadas Paralelas para SA");




