close all
clear all

% list of all the routes to test
routesList = readmatrix('sailor_cossack_caveman_any%_routes');

% load the times table to run the routes through
% times are stored in the variable `timesTable`
load('CossackTimesTable.mat');

