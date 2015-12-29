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

best_insertion_method = BestInsertion(nodes);
best_insertion_method.runTests;
BestInsertionTable = best_insertion_method.statisticsTable
best_insertion_method.bestSolutionPlot()


%% Shortest Edge method

shortest_edge_method = ShortestEdge(nodes);
shortest_edge_method.runTests;
ShortestEdgeTable = shortest_edge_method.statisticsTable
shortest_edge_method.bestSolutionPlot()


%% Saving Heuristics

saving_heuristics_method = SavingHeuristics(nodes);
saving_heuristics_method.runTests;
SavingHeuristicsTable = saving_heuristics_method.statisticsTable
saving_heuristics_method.bestSolutionPlot()


%% Greedy Local Search method using swap moves

local_search_swap_method = GreedyLocalSearch(nodes, 'Swap');
local_search_swap_method.runTests;
GreedyLocalSearchSwapMoveTable = local_search_swap_method.statisticsTable
local_search_swap_method.bestSolutionPlot()
local_search_swap_method.performancePlot()

%% Greedy Local Search method using translation moves

local_search_translation_method = GreedyLocalSearch(nodes, 'Translation');
local_search_translation_method.runTests;
GreedyLocalSearchTranslationMoveTable = local_search_translation_method.statisticsTable
local_search_translation_method.bestSolutionPlot()
local_search_translation_method.performancePlot()

%% Greedy Local Search method using inversion moves

local_search_inversion_method = GreedyLocalSearch(nodes, 'Inversion');
local_search_inversion_method.runTests;
GreedyLocalSearchInversionMoveTable = local_search_inversion_method.statisticsTable
local_search_inversion_method.bestSolutionPlot()
local_search_inversion_method.performancePlot()

%% Greedy Local Search method using mixed moves

local_search_mixed_method = GreedyLocalSearch(nodes, 'Mixed');
local_search_mixed_method.runTests;
GreedyLocalSearchMixedMoveTable = local_search_mixed_method.statisticsTable
local_search_mixed_method.bestSolutionPlot()
local_search_mixed_method.performancePlot()


%% Simulated Annealing method with Metropolis criterion and swap moves

simulated_annealing_metropolis_swap_method = SimulatedAnnealing(nodes, 'Metropolis', 'Swap');
simulated_annealing_metropolis_swap_method.runTests;
SimulatedAnnealingMetropolisSwapMoveTable = simulated_annealing_metropolis_swap_method.statisticsTable
simulated_annealing_metropolis_swap_method.bestSolutionPlot()
simulated_annealing_metropolis_swap_method.performancePlot()

%% Simulated Annealing method with Metropolis criterion and translation moves

simulated_annealing_metropolis_translation_method = SimulatedAnnealing(nodes, 'Metropolis', 'Translation');
simulated_annealing_metropolis_translation_method.runTests;
SimulatedAnnealingMetropolisTranslationMoveTable = simulated_annealing_metropolis_translation_method.statisticsTable
simulated_annealing_metropolis_translation_method.bestSolutionPlot()
simulated_annealing_metropolis_translation_method.performancePlot()

%% Simulated Annealing method with Metropolis criterion and inversion moves

simulated_annealing_metropolis_inversion_method = SimulatedAnnealing(nodes, 'Metropolis', 'Inversion');
simulated_annealing_metropolis_inversion_method.runTests;
SimulatedAnnealingMetropolisInversionMoveTable = simulated_annealing_metropolis_inversion_method.statisticsTable
simulated_annealing_metropolis_inversion_method.bestSolutionPlot()
simulated_annealing_metropolis_inversion_method.performancePlot()

%% Simulated Annealing method with Metropolis criterion and mixed moves

simulated_annealing_metropolis_mixed_method = SimulatedAnnealing(nodes, 'Metropolis', 'Mixed');
simulated_annealing_metropolis_mixed_method.runTests;
SimulatedAnnealingMetropolisMixedMoveTable = simulated_annealing_metropolis_mixed_method.statisticsTable
simulated_annealing_metropolis_mixed_method.bestSolutionPlot()
simulated_annealing_metropolis_mixed_method.performancePlot()

%% Simulated Annealing method with Heat Bath criterion and swap moves

simulated_annealing_heatbath_swap_method = SimulatedAnnealing(nodes, 'Heatbath', 'Swap');
simulated_annealing_heatbath_swap_method.runTests;
SimulatedAnnealingHeatBathSwapMoveTable = simulated_annealing_heatbath_swap_method.statisticsTable
simulated_annealing_heatbath_swap_method.bestSolutionPlot()
simulated_annealing_heatbath_swap_method.performancePlot()

%% Simulated Annealing method with Heat Bath criterion and translation moves

simulated_annealing_heatbath_translation_method = SimulatedAnnealing(nodes, 'Heatbath', 'Translation');
simulated_annealing_heatbath_translation_method.runTests;
SimulatedAnnealingHeatBathTranslationMoveTable = simulated_annealing_heatbath_translation_method.statisticsTable
simulated_annealing_heatbath_translation_method.bestSolutionPlot()
simulated_annealing_heatbath_translation_method.performancePlot()

%% Simulated Annealing method with Heat Bath criterion and inversion moves

simulated_annealing_heatbath_inversion_method = SimulatedAnnealing(nodes, 'Heatbath', 'Inversion');
simulated_annealing_heatbath_inversion_method.runTests;
SimulatedAnnealingHeatBathInversionMoveTable = simulated_annealing_heatbath_inversion_method.statisticsTable
simulated_annealing_heatbath_inversion_method.bestSolutionPlot()
simulated_annealing_heatbath_inversion_method.performancePlot()

%% Simulated Annealing method with Heat Bath criterion and mixed moves

simulated_annealing_heatbath_mixed_method = SimulatedAnnealing(nodes, 'Heatbath', 'Mixed');
simulated_annealing_heatbath_mixed_method.runTests;
SimulatedAnnealingHeatBathMixedMoveTable = simulated_annealing_heatbath_mixed_method.statisticsTable
simulated_annealing_heatbath_mixed_method.bestSolutionPlot()
simulated_annealing_heatbath_mixed_method.performancePlot()
