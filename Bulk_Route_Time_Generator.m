close all
clear all

%% user settings
% set village (no caps, to be safe)
%  - selects proper data files
%  - triggers any village specific computations
village = 'sailor';

% set time to clip through soveena door when it isn't unlocked
squidPenalty = 1;

% set time to clip through kart door when it isn't unlocked
kartPenalty = 0.58;

%% load stuff
% pregenerated list of all the routes to test
if strcmpi(village,'sailor') || strcmpi(village,'cossack') || strcmpi(village,'caveman')
    routesList = readmatrix('routeLists\sailor_cossack_caveman_any%_routes.csv');
elseif strcmpi(village,'inca')
    routesList = readmatrix('routeLists\inca_any%_routes.csv');
end

% initialize list of each route's time
% invalid routes are represented by a 0
timesList = zeros(size(routesList,1),1);

% load the times table to run the routes through
% times are stored in the variable `timesTable`
load(strcat('timesTables\', village, 'TimesTable.mat'));

%% calculate stuff
% step through each time in the list
% really innefficieicnent way to do this but w/e
for currentRoute = 1:size(routesList,1)
    
    % get the route and its times
    route = routesList(currentRoute,:);
    times = routeTimes(timesTable,route);
    
    % throw out route if subboss is unopened and it's not sailor
    % (sailor can clip through door. That penalty is added later)
    % (subboss is always in position 2 in the timesTable)
    if ~strcmpi(village,'sailor') && find(route==2) <= 4
        continue
    end
    
    % throw out route if it has untimed segments
    % (untimed segments are just 0's in the timesTable)
    if sum(times==0) > 0
        continue
    end
    
    % store time
    timesList(currentRoute) = sum(times);
    
    % add penalty if doing soveena before it is unlocked
    if strcmpi(village,'sailor') && find(route==2) <= 4
        timesList(currentRoute) = timesList(currentRoute) + squidPenalty;
    end
    
    % add penalty if doing kart before it is unlocked
    kartPos = find(route==3);
    junglePos = find(route==4);
    minesPos = find(route==5);
    if strcmpi(village,'caveman') && (kartPos<junglePos || kartPos<minesPos)
        timesList(currentRoute) = timesList(currentRoute) + kartPenalty;
    end
end

%% format stuff
% trim invalid routes
% (invalid routes are represented by a 0 in the timesList)
routesList = routesList(timesList~=0,:);
timesList = timesList(timesList~=0);