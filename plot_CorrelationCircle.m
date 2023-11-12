function plot_CorrelationCircle(correlationCircle, nameVariables, ...
                                nbAxes, figNumber, ...
                                varargin)

%plot_CorrelationCircle Plot the correlation circles
%
%   plot_CorrelationCircle(correlationCircle, nameVariables, nbAxes, figNumber)
%
%   This function plots the correlation circles.
%
%   Inputs:
%       _ correlationCircle is a P-by-P matrix where the j-th column is the
%       correlation coefficients between the initial variables and the j-th
%       principal component. Each row is the correlation coefficients
%       between an initial variable and all the principal components.
%       _ nameVariables is a cell-array containing the name of the initial
%       variables.
%       _ nbAxes is a number of principal components kept to display the
%       PCA
%       _ figNumber is the number of the figure.
%
%   plot_CorrelationCircle(...,'PARAM1',VAL1,'PARAM2',VAL2,...) specifies 
%   additional parameters and their values.  
%   Valid parameters are the following (ALL OF THEM MUST BE USED):
%
%     Parameter                 Value
%      'additionalCorrCircle'    is a P-by-P matrix where the (i,j)-th entry
%                                is the correlation coefficient between the
%                                i-th additional variable and the j-th
%                                principal component
%                   
%      'additionalVariableNames'    is a cell-array containing the name of 
%                                   the additional variables.




%% Parameters
nbVariables = size(correlationCircle, 2);



% parse parameters
p = inputParser;
defaultAdditionalObs = [];
defaultAdditionalVariableNames = [];
validSizeObs = @(x) (size(x,2) == nbVariables);
addOptional(p,'additionalCorrCircle', defaultAdditionalObs, validSizeObs);
addOptional(p,'additionalVariableNames', defaultAdditionalVariableNames);

parse(p,varargin{:})






%% Display
nbColums = ceil(sqrt(nchoosek(nbAxes,2)));
nbRows   = ceil(nchoosek(nbAxes,2)/nbColums);

fig = figure(figNumber); clf
    fig.Name = 'Correlation circles';
indPlot = 0;
for indPlot1 = 1:nbAxes
    for indPlot2 = indPlot1+1:nbAxes
        indPlot = indPlot + 1;
        axs = subplot(nbRows, nbColums, indPlot);
        
        
            %%%%%%%%%% COMPLETER LE CODE ICI
            biplot(correlationCircle(:,[indPlot1 indPlot2]),'VarLabels',nameVariables);
            rectangle('position', [-1 -1 2 2], 'curvature', 1)
            axis equal
            
            
            
            %%%%%%%%%% FIN COMPLETER LE CODE
            
            
            if ~isempty(p.Results.additionalCorrCircle)
                plt = biplot(p.Results.additionalCorrCircle(:, [indPlot1, indPlot2]), ...
                        'VarLabels', p.Results.additionalVariableNames); hold on
                plt(1).Color = axs.ColorOrder(2,:);
                plt(2).Color = axs.ColorOrder(2,:);
                plt(1).LineWidth = 2;
            end
            
            xlabel(['Component ' num2str(indPlot1)])
            ylabel(['Component ' num2str(indPlot2)])
    end

end
