% Initialize default configuration
    locations = [7.7176 0.8955;
    9.8397 9.8352;
    1.3001 7.7070;
    4.6141 0.0784;
    9.0204 4.8838;
    1.5651 3.3703;
    6.4311 6.1604;
    8.0298 5.5397;
    8.2941 1.2147;
    0.6621 2.5383;
    9.6546 0.5923;
    6.8045 9.2022;
    8.0196 2.8386;
    8.1590 7.1041;
    8.0531 1.8498];
    distance = [];
    popuSize    = 100;
    numIter     = 100;
    if isempty(distance)
        nPoints = size(locations,1);
        a = meshgrid(1:nPoints);
        distance = reshape(sqrt(sum((locations(a,:)-locations(a',:)).^2,2)),nPoints,nPoints);
    end
    [N,dims] = size(locations);
     n = N;
    % Initialize the Population
    popu = zeros(popuSize,n);
    popu(1,:) = (1:n);
    for k = 2:popuSize
        popu(k,:) = randperm(n);
    end
    
    % Run the GA
    globalMin = Inf;
    totalDist = zeros(1,popuSize);
    distHistory = zeros(1,numIter);
    tmpPopu = zeros(4,n);
    newPopu = zeros(popuSize,n);
    hAx = gca;
    for iter = 1:numIter
        % Evaluate Each Population Member (Calculate Total Distance)
        for p = 1:popuSize
            d = distance(popu(p,n),popu(p,1)); % Closed Path
            for k = 2:n
                d = d + distance(popu(p,k-1),popu(p,k));
            end
            totalDist(p) = d;
        end
        
        % Find the Best Route in the Population
        [minDist,index] = min(totalDist);
        distHistory(iter) = minDist;
        if minDist < globalMin
            globalMin = minDist;
            optRoute = popu(index,:);
                % Plot the Best Route
                rte = optRoute([1:n 1]);
                if dims > 2, plot3(hAx,locations(rte,1),locations(rte,2),locations(rte,3),'r.-');
                else plot(hAx,locations(rte,1),locations(rte,2),'r.-'); end
                title(hAx,sprintf('Total Distance = %1.4f, Iteration = %d',minDist,iter));
                drawnow;
        end
        
        % Genetic Algorithm Operators
        randomOrder = randperm(popuSize);
        for p = 4:4:popuSize
            rtes = popu(randomOrder(p-3:p),:);
            dists = totalDist(randomOrder(p-3:p));
            [ignore,idx] = min(dists); 
            bestOf4Route = rtes(idx,:);
            routeInsertionPoints = sort(ceil(n*rand(1,2)));
            I = routeInsertionPoints(1);
            J = routeInsertionPoints(2);
            for k = 1:4 % Mutate the Best to get Three New Routes
                tmpPopu(k,:) = bestOf4Route;
                switch k
                    case 2 % Flip
                        tmpPopu(k,I:J) = tmpPopu(k,J:-1:I);
                    case 3 % Swap
                        tmpPopu(k,[I J]) = tmpPopu(k,[J I]);
                    case 4 % Slide
                        tmpPopu(k,I:J) = tmpPopu(k,[I+1:J I]);
                    otherwise % Do Nothing
                end
            end
            newPopu(p-3:p,:) = tmpPopu;
        end
        popu = newPopu;
    end
        % Plots the GA Results
        figure('Name','TSP_GA | Results','Numbertitle','off');
        subplot(2,2,1);
        pclr = ~get(0,'DefaultAxesColor');
        if dims > 2, plot3(locations(:,1),locations(:,2),locations(:,3),'.','Color',pclr);
        else plot(locations(:,1),locations(:,2),'.','Color',pclr); end
        title('City Locations');
        subplot(2,2,2);
        imagesc(distance(optRoute,optRoute));
        title('Distance Matrix');
        subplot(2,2,3);
        rte = optRoute([1:n 1]);
        if dims > 2, plot3(locations(rte,1),locations(rte,2),locations(rte,3),'r.-');
        else plot(locations(rte,1),locations(rte,2),'r.-'); end
        title(sprintf('Total Distance = %1.4f',minDist));
        subplot(2,2,4);
        plot(distHistory,'b','LineWidth',2);
        title('Best Solution History');
        set(gca,'XLim',[0 numIter+1],'YLim',[0 1.1*max([1 distHistory])]);    