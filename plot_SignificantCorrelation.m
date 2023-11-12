function plot_SignificantCorrelation(R, thresholdSignificantCorrelation, ...
                                     X, nameVariables, indexSelectedPoints, ...
                                     figNumber)



%plot_SignificantCorrelation Plot the scatter plots of significant correlation.
%
%   plot_SignificantCorrelation(R, thresholdSignificantCorrelation, ...
%       X, nameVariables, indexSelectedPoints, figNumber)
%
%   This function plots the scatter plots of pair of variables detected as
%   a significant correlation (in absolute value).
%
%   Inputs:
%       _ R is the P-by-P correlation matrix of the observations.
%       _ thresholdSignificantCorrelation is the value of the threshold
%       used to detect significant correlation.
%       _ X is the N-by-P matrix of the observations.
%       _ nameVariables is a cell-array containing the name of the initial
%       variables.
%       _ indexSelectedPoints is the N vector of the indexes of the
%       selected observations to compute the PCA among the original data.
%       _ figNumber is the number of the figure.
%




nbVariables = size(R,1);
indexVariablesCorrelated = [];
variablesCorrelated = abs(R) > thresholdSignificantCorrelation;
for ind1 = 1:nbVariables
    for ind2 = ind1+1:nbVariables
        if variablesCorrelated(ind1, ind2) == 1
            indexVariablesCorrelated = [indexVariablesCorrelated ; [ind1 ind2]];
        end
    end
end


nbColumns = ceil(sqrt(size(indexVariablesCorrelated,1)));
nbRows    = ceil(size(indexVariablesCorrelated,1) / nbColumns);
fig = figure(figNumber); clf
    %fig.Name = 'Significant correlation';
for indPlot = 1:size(indexVariablesCorrelated, 1)
    axs = subplot(nbRows, nbColumns, indPlot);
        plt = plot(X(:,indexVariablesCorrelated(indPlot,1)), X(:,indexVariablesCorrelated(indPlot,2)), 'o');
            %plt.MarkerFaceColor = axs.ColorOrder(1,:);

        xlabel(nameVariables(indexVariablesCorrelated(indPlot,1)))
        ylabel(nameVariables(indexVariablesCorrelated(indPlot,2)))
        title(['r = ' num2str(R(indexVariablesCorrelated(indPlot,1), indexVariablesCorrelated(indPlot,2)))])

        grid on
        axis equal

        dcm_obj = datacursormode(fig);
        set(dcm_obj,'UpdateFcn',{@myupdatefcn, indexSelectedPoints})
end





function txt = myupdatefcn(~,event_obj, indexSelectedPoints)
% Customizes text of data tips
pos = get(event_obj,'Position');
I = get(event_obj, 'DataIndex');
txt = {['X: ',num2str(pos(1))],...
       ['Y: ',num2str(pos(2))],...
       ['I: ',num2str(indexSelectedPoints(I))]};
