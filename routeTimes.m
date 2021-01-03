function [times] = routeTimes(timesTable,route)
% takes in a times table + a single route
% returns an array of the segment times in that route

% init times
times = [];

% step through each segment of the route
for currentSegment = 1:length(route)-1
    
    fromLevel = route(currentSegment);
    toLevel = route(currentSegment+1);
    
    times = [times timesTable(fromLevel,toLevel)];
end

end

