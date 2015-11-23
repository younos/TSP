% Probabilistic Algorithms Project
% Autumn 2015
% Younos Cherkaoui

% Import functions adding subpaths
addpath('Construction Heuristics');
addpath('Improvement Heuristics');

% Import the data
nodes = importdata('TSP_411.txt', ' ');

% Compute the distance matrix
DM = squareform(pdist(nodes(:,1:2)));

% Apply the tests on the Best Insertion method
ApplyTests('BestInsertion', DM);

% Apply the tests on the Shortest Edge method
ApplyTests('ShortestEdge', DM);

% Apply the tests on the Saving Heuristics method
ApplyTests('SavingHeuristics', DM);

% Apply the tests on the Greedy Local Search method
ApplyTests('LocalSearch', DM);

% Apply the tests on the Simulated Annealing method
ApplyTests('SimulatedAnnealing', DM);


