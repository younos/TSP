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

% Run the tests for the Best Insertion method
method = BestInsertionHeuristic(DM);
method.runTests;

% Run the tests for the Shortest Edge method
method = ShortestEdgeHeuristic(DM);
method.runTests;

% Run the tests for the Saving Heuristics method
%method = SavingHeuristicsHeuristic(DM);
%method.runTests;

% Run the tests for the Greedy Local Search method
%ApplyTests('LocalSearch', DM);
%method = LocalSearchHeuristic(DM);
%method.runTests;

% Run the tests for the Simulated Annealing method
%method = SimulatedAnnealingHeuristic(DM);
%method.runTests;
