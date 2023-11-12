function plot_CorrelationCircle_QualityObservation(correlationCircle, nameVariables, ...
                    QLT, C, indexSelectedPoints, ...
                    nbAxes, figNumber, ...
                    varargin)

%plot_CorrelationCircle_QualityObservation Plot both correlation circles
%and the quality of the observations.
%
%   plot_CorrelationCircle_QualityObservation(correlationCircle, 
%   nameVariables, QLT, C, indexSelectedPoints, nbAxes, figNumber)
%
%   This function plots on the same figure the correlation circles and the
%   quality of the observations.
%
%   Inputs:
%       _ correlationCircle is a P-by-P matrix where the j-th column is the
%       correlation coefficients between the initial variables and the j-th
%       principal component. Each row is the correlation coefficients
%       between an initial variable and all the principal components.
%       _ nameVariables is a cell-array containing the name of the initial
%       variables.
%       _ QLT is a N-by-P matrix where the (i,j)-th entry is the quality of
%       the i-th observation on the j-th principal component.
%       _ C is the N-by-P matrix of the principal components.
%       _ indexSelectedPoints is the N vector of the indexes of the
%       selected observations to compute the PCA among the original data.
%       _ nbAxes is a number of principal components kept to display the
%       PCA
%       _ figNumber is the number of the figure.
%
%   plot_CorrelationCircle_QualityObservation(...,'PARAM1',VAL1,'PARAM2',VAL2,...) 
%   specifies additional parameters and their values.  
%   Valid parameters are the following (ALL OF THEM MUST BE USED):
%
%     Parameter             Value
%      'additionalQuality'    is a M-by-P matrix where the (i,j)-th entry
%                             is the quality of M additional observations.
%                   
%      'additionalC'          is the M-by-P matrix of the principal
%                             components of M additional observations.
%
%      'indexAdditionalObservations'    is the M vector of the indexes of the
%                                       additional observations among the 
%                                       original data.




%% Parse parameters
nbVariables = size(correlationCircle, 2); % Number of variables

% Parse optinal parameters
p = inputParser;
defaultAdditionalQLT = [];
defaultAdditionalC = [];
defaultIndexAdditionalObs = [];
validSizeObs = @(x) (size(x,2) == nbVariables);
addOptional(p,'additionalQuality', defaultAdditionalQLT, validSizeObs);
addOptional(p,'additionalC', defaultAdditionalC, validSizeObs);
addOptional(p,'indexAdditionalObservations', defaultIndexAdditionalObs);

parse(p,varargin{:})
if length(p.Results.indexAdditionalObservations) ~= size(p.Results.additionalQuality,1) || ...
        length(p.Results.indexAdditionalObservations) ~= size(p.Results.additionalC,1)
    error('Length of index must be equal to number of additional observations')
end



%% Display
nbColums = ceil(sqrt(nchoosek(nbAxes,2)));      % Nb of columns for the subplot
nbRows   = ceil(nchoosek(nbAxes,2)/nbColums);   % Nb of rows for the subplot

fig = figure(figNumber); clf
    fig.Name = 'Correlation circles & quality of the observations';
    
    
indPlot = 0;
for indPlot1 = 1:nbAxes
    for indPlot2 = indPlot1+1:nbAxes
        indPlot = indPlot + 1;
        figure(); 
        %axs = subplot(nbRows, nbColums, indPlot);
            % Correlation circle
            biplot(correlationCircle(:, [indPlot1, indPlot2]), ...
                    'VarLabels', nameVariables(1:nbVariables)); hold on
            rectangle('Position', [-1 -1 2 2], 'curvature', 1)

            % Quality of the observations
            plt = plot(QLT(:,indPlot1).^(1/2).*sign(C(:,indPlot1)), QLT(:, indPlot2).^(1/2).*sign(C(:,indPlot2)), 'o');
                %set(plt, 'MarkerFaceColor', axs.ColorOrder(1,:))
            text(QLT(:,indPlot1).^(1/2).*sign(C(:,indPlot1))+.01, ...
                 QLT(:,indPlot2).^(1/2).*sign(C(:,indPlot2))-.01, ...
                 num2str(indexSelectedPoints(:)))
            
            if ~isempty(p.Results.additionalQuality)
                addX = p.Results.additionalQuality(:, indPlot1).^(1/2) .* sign(p.Results.additionalC(:, indPlot1));
                addY = p.Results.additionalQuality(:, indPlot2).^(1/2) .* sign(p.Results.additionalC(:, indPlot1));
                plt = plot(addX, addY, 'd'); hold on
                    %set(plt, 'MarkerFaceColor', axs.ColorOrder(2,:))
                text(addX+.01, addY-.01, num2str(p.Results.indexAdditionalObservations(:)))
            end
            
            axis equal
            xlim([-1.1 1.1])
            ylim([-1.1 1.1])
        
            
            
            xlabel(['Component ' num2str(indPlot1)])
            ylabel(['Component ' num2str(indPlot2)])
    end

end




