function [time] = routeTime(timesTable,route)
% takes in a times table + a single route
% calculates the route time based off the times table

% init time
time = 0;

% step through each segment of the route
for currentSegment = 1:length(route)-1
    
    fromLevel = route(currentSegment);
    toLevel = route(currentSegment+1);
    
    time = time + timesTable(fromLevel,toLevel);
end

end

