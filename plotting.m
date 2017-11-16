function p = plotting(greedy_scores, centrality_scores,ce_scores, scores,type,hazard,network)
 %p = plotting(greedy_scores_cyber, c_cyber,ce_cyber, scores_cyber,"LargeC","cyber","IRN")
 %p = plotting(greedy_scores_cyber, c_cyber,ce_cyber, scores_cyber,"OD","cyber","IRN")
% greedy_scores: Combined recovery and breakdown scores
% centrality_scores: Recovery scores from centrality measures
% CE_scores: Recovery scores from Cross Entropy
%scores: only failure scores
f = figure();
addpath('~/Documents/MATLAB/altmany-export_fig-0f706b6/')
% greedy
plot(greedy_scores/max(greedy_scores),'cyan','linewidth',3)
hold on
Scores2 = [scores; centrality_scores.scores.ucc]; % combine failure and recovery scores
plot(Scores2/max(Scores2),'red','linewidth',6)
Scores2 = [scores; centrality_scores.scores.ud]; % combine failure and recovery scores
plot(Scores2/max(Scores2),'green','linewidth',3)
Scores2 = [scores; centrality_scores.scores.ubc]; % combine failure and recovery scores
plot(Scores2/max(Scores2),'black','linewidth',3)
Scores2 = [scores; centrality_scores.scores.ueig]; % combine failure and recovery scores
plot(Scores2/max(Scores2),'blue','linewidth',3)

Scores2 = [scores; ce_scores.scores]; % combine failure and recovery scores
plot(Scores2/max(Scores2),'m','linewidth',3)
% plots vertical line at intersection of resilience and recovery
plot([length(greedy_scores)/2 length(greedy_scores)/2],[min(greedy_scores)/max(greedy_scores) 1],'--','color',[0.5 0.5 0.5])

xlim([0 length(greedy_scores)])
ylim([min(scores)/max(scores) max(scores)/max(scores)])
xlabel('Edge')
if strcmp(type,'OD')
    ylabel('OD flow')
elseif strcmp(type,'LargeC')
    ylabel('Largest component')
end
head = "Resilience curve for "+ hazard;
title(head)
set(gca,'fontsize',16)          % change font size
legend({'greedy','closeness','degree','betweenness','eigenvector','cross entropy'},'location','southeast')
legend('boxoff')
set(gca,'fontsize',16)          % change font size
grid on
h = gcf;
set(h,'PaperPositionMode','auto');         
set(h,'PaperOrientation','landscape');
hold off
export_fig(sprintf('rec%s_%s.png', hazard,type)) % save as pdf file
p = 1;
end
