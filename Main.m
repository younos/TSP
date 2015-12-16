% Probabilistic Algorithms Project
% Autumn 2015
% Younos Cherkaoui


% Import functions adding subpaths
addpath('Construction Heuristics');
addpath('Improvement Heuristics');

% Import the data
node_list = importdata('TSP_411.txt', ' ');
% Set the node list to the Nodes class
nodes = Nodes(node_list(:, 2:3));


% Run the tests for the Best Insertion method

method = BestInsertionHeuristic(nodes);
method.runTests;
method.statisticsTable


% Run the tests for the Shortest Edge method

method = ShortestEdgeHeuristic(nodes);
method.runTests;
method.statisticsTable


% Run the tests for the Saving Heuristics method

method = SavingHeuristic(nodes);
method.runTests;
method.statisticsTable


% Run the tests for the Greedy Local Search method

method = LocalSearchHeuristic(nodes);

% Firstly, using swap moves
method.setMoveType('swap');
method.runTests;
method.statisticsTable
% Secondly, using translation moves
method.setMoveType('translation');
method.runTests;
method.statisticsTable
% Thirdly, using inversion moves
method.setMoveType('inversion');
method.runTests;
method.statisticsTable
% And finally, using mixed moves
method.setMoveType('mixed');
method.runTests;
method.statisticsTable


% Run the tests for the Simulated Annealing method

method = SimulatedAnnealingHeuristic(nodes);

% Using Metropolis criterion
method.setCriterion('metropolis');
% Firstly, using swap moves
method.setMoveType('swap');
method.runTests;
method.statisticsTable
% Secondly, using translation moves
method.setMoveType('translation');
method.runTests;
method.statisticsTable
% Thirdly, using inversion moves
method.setMoveType('inversion');
method.runTests;
method.statisticsTable
% And finally, using mixed moves
method.setMoveType('mixed');
method.runTests;
method.statisticsTable

% Using Heat Bath condition
method.setCriterion('heatbath');
% Firstly, using swap moves
method.setMoveType('swap');
method.runTests;
method.statisticsTable
% Secondly, using translation moves
method.setMoveType('translation');
method.runTests;
method.statisticsTable
% Thirdly, using inversion moves
method.setMoveType('inversion');
method.runTests;
method.statisticsTable
% And finally, using mixed moves
method.setMoveType('mixed');
method.runTests;
method.statisticsTable
