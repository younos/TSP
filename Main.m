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

best_insertion_method = BestInsertionHeuristic(nodes);
best_insertion_method.runTests;
BestInsertionTable = best_insertion_method.statisticsTable
best_insertion_method.bestSolutionPlot('BestInsertion')


%% Shortest Edge method

shortest_edge_method = ShortestEdgeHeuristic(nodes);
shortest_edge_method.runTests;
ShortestEdgeTable = shortest_edge_method.statisticsTable
shortest_edge_method.bestSolutionPlot('ShortestEdge')


%% Saving Heuristics

saving_heuristics_method = SavingHeuristic(nodes);
saving_heuristics_method.runTests;
SavingHeuristicsTable = saving_heuristics_method.statisticsTable
saving_heuristics_method.bestSolutionPlot('SavingHeuristics')


%% Greedy Local Search method using swap moves

local_search_swap_method = LocalSearchHeuristic(nodes, 'swap');
local_search_swap_method.runTests;
GreedyLocalSearchSwapMoveTable = local_search_swap_method.statisticsTable
local_search_swap_method.bestSolutionPlot('GreedyLocalSearchSwapMove')
local_search_swap_method.performancePlot('GreedyLocalSearchSwapMove')

%% Greedy Local Search method using translation moves

local_search_translation_method = LocalSearchHeuristic(nodes, 'translation');
local_search_translation_method.runTests;
GreedyLocalSearchTranslationMoveTable = local_search_translation_method.statisticsTable
local_search_translation_method.bestSolutionPlot('GreedyLocalSearchTranslationMove')
local_search_translation_method.performancePlot('GreedyLocalSearchTranslationMove')

%% Greedy Local Search method using inversion moves

local_search_inversion_method = LocalSearchHeuristic(nodes, 'inversion');
local_search_inversion_method.runTests;
GreedyLocalSearchInversionMoveTable = local_search_inversion_method.statisticsTable
local_search_inversion_method.bestSolutionPlot('GreedyLocalSearchInversionMove')
local_search_inversion_method.performancePlot('GreedyLocalSearchInversionMove')

%% Greedy Local Search method using mixed moves

local_search_mixed_method = LocalSearchHeuristic(nodes, 'mixed');
local_search_mixed_method.runTests;
GreedyLocalSearchMixedMoveTable = local_search_mixed_method.statisticsTable
local_search_mixed_method.bestSolutionPlot('GreedyLocalSearchMixedMove')
local_search_mixed_method.performancePlot('GreedyLocalSearchMixedMove')


%% Simulated Annealing method with Metropolis criterion and swap moves

simulated_annealing_metropolis_swap_method = SimulatedAnnealingHeuristic(nodes, 'metropolis', 'swap');
simulated_annealing_metropolis_swap_method.runTests;
SimulatedAnnealingMetropolisSwapMoveTable = simulated_annealing_metropolis_swap_method.statisticsTable
simulated_annealing_metropolis_swap_method.bestSolutionPlot('SimulatedAnnealingMetropolisSwapMove')
simulated_annealing_metropolis_swap_method.performancePlot('SimulatedAnnealingMetropolisSwapMove')

%% Simulated Annealing method with Metropolis criterion and translation moves

simulated_annealing_metropolis_translation_method = SimulatedAnnealingHeuristic(nodes, 'metropolis', 'translation');
simulated_annealing_metropolis_translation_method.runTests;
SimulatedAnnealingMetropolisTranslationMoveTable = simulated_annealing_metropolis_translation_method.statisticsTable
simulated_annealing_metropolis_translation_method.bestSolutionPlot('SimulatedAnnealingMetropolisTranslationMove')
simulated_annealing_metropolis_translation_method.performancePlot('SimulatedAnnealingMetropolisTranslationMove')

%% Simulated Annealing method with Metropolis criterion and inversion moves

simulated_annealing_metropolis_inversion_method = SimulatedAnnealingHeuristic(nodes, 'metropolis', 'inversion');
simulated_annealing_metropolis_inversion_method.runTests;
SimulatedAnnealingMetropolisInversionMoveTable = simulated_annealing_metropolis_inversion_method.statisticsTable
simulated_annealing_metropolis_inversion_method.bestSolutionPlot('SimulatedAnnealingMetropolisInversionMove')
simulated_annealing_metropolis_inversion_method.performancePlot('SimulatedAnnealingMetropolisInversionMove')

%% Simulated Annealing method with Metropolis criterion and mixed moves

simulated_annealing_metropolis_mixed_method = SimulatedAnnealingHeuristic(nodes, 'metropolis', 'mixed');
simulated_annealing_metropolis_mixed_method.runTests;
SimulatedAnnealingMetropolisMixedMoveTable = simulated_annealing_metropolis_mixed_method.statisticsTable
simulated_annealing_metropolis_mixed_method.bestSolutionPlot('SimulatedAnnealingMetropolisMixedMove')
simulated_annealing_metropolis_mixed_method.performancePlot('SimulatedAnnealingMetropolisMixedMove')

%% Simulated Annealing method with Heat Bath criterion and swap moves

simulated_annealing_heatbath_swap_method = SimulatedAnnealingHeuristic(nodes, 'heatbath', 'swap');
simulated_annealing_heatbath_swap_method.runTests;
SimulatedAnnealingHeatBathSwapMoveTable = simulated_annealing_heatbath_swap_method.statisticsTable
simulated_annealing_heatbath_swap_method.bestSolutionPlot('SimulatedAnnealingHeatBathSwapMove')
simulated_annealing_heatbath_swap_method.performancePlot('SimulatedAnnealingHeatBathSwapMove')

%% Simulated Annealing method with Heat Bath criterion and translation moves

simulated_annealing_heatbath_translation_method = SimulatedAnnealingHeuristic(nodes, 'heatbath', 'translation');
simulated_annealing_heatbath_translation_method.runTests;
SimulatedAnnealingHeatBathTranslationMoveTable = simulated_annealing_heatbath_translation_method.statisticsTable
simulated_annealing_heatbath_translation_method.bestSolutionPlot('SimulatedAnnealingHeatBathTranslationMove')
simulated_annealing_heatbath_translation_method.performancePlot('SimulatedAnnealingHeatBathTranslationMove')

%% Simulated Annealing method with Heat Bath criterion and inversion moves

simulated_annealing_heatbath_inversion_method = SimulatedAnnealingHeuristic(nodes, 'heatbath', 'inversion');
simulated_annealing_heatbath_inversion_method.runTests;
SimulatedAnnealingHeatBathInversionMoveTable = simulated_annealing_heatbath_inversion_method.statisticsTable
simulated_annealing_heatbath_inversion_method.bestSolutionPlot('SimulatedAnnealingHeatBathInversionMove')
simulated_annealing_heatbath_inversion_method.performancePlot('SimulatedAnnealingHeatBathInversionMove')

%% Simulated Annealing method with Heat Bath criterion and mixed moves

simulated_annealing_heatbath_mixed_method = SimulatedAnnealingHeuristic(nodes, 'heatbath', 'mixed');
simulated_annealing_heatbath_mixed_method.runTests;
SimulatedAnnealingHeatBathMixedMoveTable = simulated_annealing_heatbath_mixed_method.statisticsTable
simulated_annealing_heatbath_mixed_method.bestSolutionPlot('SimulatedAnnealingHeatBathMove')
simulated_annealing_heatbath_mixed_method.performancePlot('SimulatedAnnealingHeatBathMove')
