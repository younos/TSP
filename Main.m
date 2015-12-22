%% Probabilistic Algorithms, TSP Project
% Younos Cherkaoui, Autumn 2015

%% Importations, etc

% Import functions adding subpaths
addpath('Construction Heuristics');
addpath('Improvement Heuristics');

% Import the data
node_list = importdata('TSP_411.txt', ' ');
% Set the node list to the Nodes class
nodes = Nodes(node_list);


%% Best Insertion method

method = BestInsertionHeuristic(nodes);
method.runTests;
BestInsertionTable = method.statisticsTable
method.bestSolutionPlot('BestInsertion')


%% Shortest Edge method

method = ShortestEdgeHeuristic(nodes);
method.runTests;
ShortestEdgeTable = method.statisticsTable
method.bestSolutionPlot('ShortestEdge')


%% Saving Heuristics

method = SavingHeuristic(nodes);
method.runTests;
SavingHeuristicsTable = method.statisticsTable
method.bestSolutionPlot('SavingHeuristics')


%% Greedy Local Search method using swap moves

method = LocalSearchHeuristic(nodes);

method.setMoveType('swap');
method.runTests;
GreedyLocalSearchSwapMoveTable = method.statisticsTable
method.bestSolutionPlot('GreedyLocalSearchSwapMove')
method.currMovesPlot('GreedyLocalSearchSwapMove')

%% Greedy Local Search method using translation moves

method.setMoveType('translation');
method.runTests;
GreedyLocalSearchTranslationMoveTable = method.statisticsTable
method.bestSolutionPlot('GreedyLocalSearchTranslationMove')
method.currMovesPlot('GreedyLocalSearchTranslationMove')

%% Greedy Local Search method using inversion moves

method.setMoveType('inversion');
method.runTests;
GreedyLocalSearchInversionMoveTable = method.statisticsTable
method.bestSolutionPlot('GreedyLocalSearchInversionMove')
method.currMovesPlot('GreedyLocalSearchInversionMove')

%% Greedy Local Search method using mixed moves

method.setMoveType('mixed');
method.runTests;
GreedyLocalSearchMixedMoveTable = method.statisticsTable
method.bestSolutionPlot('GreedyLocalSearchMixedMove')
method.currMovesPlot('GreedyLocalSearchMixedMove')


%% Simulated Annealing method with Metropolis criterion and swap moves

method = SimulatedAnnealingHeuristic(nodes);

method.setCriterion('metropolis');

method.setMoveType('swap');
method.runTests;
SimulatedAnnealingMetropolisSwapMoveTable = method.statisticsTable
method.bestSolutionPlot('SimulatedAnnealingMetropolisSwapMove')

%% Simulated Annealing method with Metropolis criterion and translation moves

method.setMoveType('translation');
method.runTests;
SimulatedAnnealingMetropolisTranslationMoveTable = method.statisticsTable
method.bestSolutionPlot('SimulatedAnnealingMetropolisTranslationMove')

%% Simulated Annealing method with Metropolis criterion and inversion moves

method.setMoveType('inversion');
method.runTests;
SimulatedAnnealingMetropolisInversionMoveTable = method.statisticsTable
method.bestSolutionPlot('SimulatedAnnealingMetropolisInversionMove')

%% Simulated Annealing method with Metropolis criterion and mixed moves

method.setMoveType('mixed');
method.runTests;
SimulatedAnnealingMetropolisMixedMoveTable = method.statisticsTable
method.bestSolutionPlot('SimulatedAnnealingMetropolisMixedMove')

%% Simulated Annealing method with Heat Bath criterion and swap moves

method.setCriterion('heatbath');

method.setMoveType('swap');
method.runTests;
SimulatedAnnealingHeatBathSwapMoveTable = method.statisticsTable
method.bestSolutionPlot('SimulatedAnnealingHeatBathSwapMove')

%% Simulated Annealing method with Heat Bath criterion and translation moves

method.setMoveType('translation');
method.runTests;
SimulatedAnnealingHeatBathTranslationMoveTable = method.statisticsTable
method.bestSolutionPlot('SimulatedAnnealingHeatBathTranslationMove')

%% Simulated Annealing method with Heat Bath criterion and inversion moves

method.setMoveType('inversion');
method.runTests;
SimulatedAnnealingHeatBathInversionMoveTable = method.statisticsTable
method.bestSolutionPlot('SimulatedAnnealingHeatBathInversionMove')

%% Simulated Annealing method with Heat Bath criterion and mixed moves

method.setMoveType('mixed');
method.runTests;
SimulatedAnnealingHeatBathMixedMoveTable = method.statisticsTable
method.bestSolutionPlot('SimulatedAnnealingHeatBathMove')
