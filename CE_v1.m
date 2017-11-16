% Cross Entropy
%--------------------------------------------------------------
% decision variables
function [ce] = cross_entropy(budget,G, OD, type) 
nedges = budget;     % number of edges to be recovered
nsteps = budget;    % number of recovery steps (if one edge can be recovered at a time, then this is equal to number of edges)

% ce parameters
nsample = 200; % number of samples
nmax = 25;      % maximum number of iterations
tol = 1e-1;     % tolerance for probability
rho = 0.01;     % size of elite sample for updating the probability
alpha = 0.7;    % memory for updating the probability
p0 = ones(nsteps,nedges)/nedges;     % each row is the timestep and each column is the selected edge
% Pij = 1: edge j is recovered at time i
% sum(Pij,1) = 1: each edge is only recovered once
% sum(Pij,2) = 1: one edge is recovered each time  %% this can be modified
% to sum(Pij,2) = budget;
g = zeros(1,nsample);       % vector to store the evaluation function
count = 0;
tic
while 1
    g = zeros(1,nsample);       % vector to store the evaluation function
    % Sample
    % open parallel pool
    % parpool
    sample = sample_discrete(p0,nsample);
    sample_edge = rlist.edge_indx(sample);       % go from indexing to edge index
    % Evaluate
    parfor i = 1:nsample
        g(i) = get_fitness(G,OD,sample_edge(i,:),type);
    end
    %% 
    
    % Update
    [gsort, indx] = sort(g);
    gamma = gsort(round(rho*nsample));
    nelite = sum(gsort <= gamma);
    sample_elite = sample(indx(1:nelite),:);
    for i = 1:nedges
        p = sum(sample_elite == i)/nelite;
        p1(:,i) = p;
    end
    p0 = alpha*p1 + (1-alpha)*p0;
    %     if count < nmax && min(max(p0,[],2))<= 1-tol
   
    Gamma0(count + 1) = gamma;
    Gamma1(count + 1) = gsort(1);
    count = count + 1;
    disp(count)
    disp(gsort(1))
    if count < nmax && (gamma - gsort(1))> 1e-2
        
    else
        break
    end
end

toc
% final solution
ce.edges = rlist.edge_indx(sample_elite(1,:));
[~, ce.scores] = get_fitness(G,OD,ce.edges,type);



%---------------------------------------------------------------



