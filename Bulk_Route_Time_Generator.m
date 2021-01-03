close all
clear all

% set village
village = 'Caveman';

% list of all the routes to test
routesList = readmatrix('sailor_cossack_caveman_any%_routes');

% initialize list of each route's time
% invalid routes are represented by a 0
timesList = zeros(length(routesList),1);

% load the times table to run the routes through
% times are stored in the variable `timesTable`
load(strcat(village, 'TimesTable.mat'));

% step through each time in the list
% really innefficieicnent way to do this but w/e
for currentRoute = 1:length(routesList)
    
    % get the route and its times
    route = routesList(currentRoute,:);
    times = routeTimes(timesTable,route);
    
    % throw out route if subboss is unopened
    % (subboss is always in position 2 in the timesTable)
    if find(route==2) <= 4
        continue
    end
    
    % throw out route if it has untimed segments
    % (untimed segments are just 0's in the timesTable)
    if sum(times==0) > 0
        continue
    end
   
    % add penalty if doing kart before it is unlocked
    
    % store time
    timesList(currentRoute) = sum(times);
end