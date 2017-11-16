clear all
clc
close all
load  Indian_datafiles.mat
tic
[greedy_scores_tsunami,ce_tsunami,c_tsunami,scores_tsunami,T_tsunami ] = resilience(adj_IRN,adj_IRN_weighted, nodes_irn,tsunami,"OD","tsunami");
x = 1
toc
tic
[greedy_scores_cyber,ce_cyber,c_cyber,scores_cyber,T_cyber ] = resilience(adj_IRN,adj_IRN_weighted, nodes_irn,cyber,"OD","cyber");
x = 2
toc
tic
[greedy_scores_grid,ce_grid,c_grid,scores_grid,T_grid ] = resilience(adj_IRN,adj_IRN_weighted, nodes_irn,grid,"OD","grid");
x = 3
toc
save IRN_Partial_recovery_optimization_OD.mat