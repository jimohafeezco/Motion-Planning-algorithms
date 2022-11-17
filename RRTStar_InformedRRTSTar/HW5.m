close all; 
clear, clc
load('Obstacles.mat'); 
% load('A.mat')
% axes('XLim',[0,100], 'YLim',[0,100], 'XGrid','on', 'YGrid','on', 'XMinorGrid','on', 'YMinorGrid','on')
% hold on
plot(polyObs);
hold on
s = ginput(1); g = ginput(1);
prompt= "Number of iterations: ";
n = input(prompt);
%%
% prompt= "Number of samples: ";
% ns = input(prompt);
close gcf
%%
% RRT(s,g, A,n);
%%
% rng(100)
% RRTx_(s,g, A,n);
% %%
% rng(100)
% RRTx_old (s ,g, A, n)
%%
G= RRTx_IF(s,g,polyObs,n);
%% sPRM
% [Gs, path]= sPRM(s, g, ns);
% figure (5)
% plot(A)
% title('sPRM')
% hold on 
% Gs.plot%('labels');
%  Pathas= Gs.vertexlist(:,path);
%  plot(Pathas(1,:), Pathas(2,:), 'y', 'Linewidth',5 )