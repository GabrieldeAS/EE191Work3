function [valores] = var_analise(k)
num=[-1 1]; den=[1 3 2];
G=tf(num, den);
numk=[k(1) k(2)]; denk=[1 0]; % k(1) e' Kp, k(2) e' Ki
K=tf(numk,denk); % compensador
H=feedback(G*K,1); % planta e compensador em malha unitaria
y = step(H,0:.01:19.99);
[~,index]=max(y>0.9);
ts=(index-1)*.01; % tempo de subida
% Se em 20 segundos o sinal nao atingir
% 90% da referencia ts é estimado por extrapolacao linear do sinal
if ts==0
    ts=18/max(y);
end
Mp=(max(y)-1); % overshoot
Und=abs(min(y)); % undershoot

% tá certo esse erro aqui (?) -> e = 1/Kp
Erampa=2/k(2); % erro de regime para entrada rampa unitaria
% 

valores=[ts;Mp;Und;Erampa];
end

