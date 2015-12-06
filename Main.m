% Probabilistic Algorithms Project
% Autumn 2015
% Younos Cherkaoui


% Import functions adding subpaths
addpath('Construction Heuristics');
addpath('Improvement Heuristics');

% Import the data
nodes = importdata('TSP_411.txt', ' ');
% Compute the distance matrix
DM = squareform(pdist(nodes(:,2:3)));


% Run the tests for the Best Insertion method

method = BestInsertionHeuristic(DM);
method.runTests;


% Run the tests for the Shortest Edge method

method = ShortestEdgeHeuristic(DM);
method.runTests;


% Run the tests for the Saving Heuristics method

method = SavingHeuristic(DM);
method.runTests;


% Run the tests for the Greedy Local Search method

method = LocalSearchHeuristic(DM);

% Firstly, using swap moves
method.setMoveType('swap');
method.runTests;
% Secondly, using translation moves
method.setMoveType('translation');
method.runTests;
% Thirdly, using inversion moves
method.setMoveType('inversion');
method.runTests;
% And finally, using mixed moves
method.setMoveType('mixed');
method.runTests;


% Run the tests for the Simulated Annealing method

method = SimulatedAnnealingHeuristic(DM);

% Using Metropolis criterion
method.setCriterion('metropolis');
% Firstly, using swap moves
method.setMoveType('swap');
method.runTests;
% Secondly, using translation moves
method.setMoveType('translation');
method.runTests;
% Thirdly, using inversion moves
method.setMoveType('inversion');
method.runTests;
% And finally, using mixed moves
method.setMoveType('mixed');
method.runTests;

% Using Heat Bath condition
method.setCriterion('heatbath');
% Firstly, using swap moves
method.setMoveType('swap');
method.runTests;
% Secondly, using translation moves
method.setMoveType('translation');
method.runTests;
% Thirdly, using inversion moves
method.setMoveType('inversion');
method.runTests;
% And finally, using mixed moves
method.setMoveType('mixed');
method.runTests;
