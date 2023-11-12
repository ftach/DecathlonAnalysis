function plot_ProjectionObservation(C, indexSelectedPoints, nbAxes, figNumber, varargin)


%plot_ProjectionObservation Plot the observations on the factorial plans
%
%   plot_ProjectionObservation(C, indexSelectedPoints, nbAxes, figNumber)
%
%   This function plots the projection of the observations on the factorial
%   plans computed by the PCA.
%
%   Inputs:
%       _ C is the N-by-P matrix of the principal components. The (i,j)-th
%       entry is the coordinate of the i-th observation on the j-th
%       principal component.
%       _ indexSelectedPoints is the N vector of the indexes of the
%       selected observations to compute the PCA among the original data.
%       _ nbAxes is a number of principal components kept to display the
%       PCA
%       _ figNumber is the number of the figure.
%
%   plot_ProjectionObservation(...,'PARAM1',VAL1,'PARAM2',VAL2,...) specifies 
%   additional parameters and their values.  
%   Valid parameters are the following (ALL OF THEM MUST BE USED):
%
%     Parameter         Value
%      'additionalC'      is a M-by-P matrix where the (i,j)-th entry is 
%                         the coordinate of the i-th additional observation 
%                         on the j-th principal component.
%                   
%      'indexAdditionalObservations'    is the M vector of the indexes of the
%                                       additional observations among the 
%                                       original data.



% Parse parameters
nbVariables = size(C,2);


p = inputParser;
defaultAdditionalObs = [];
defaultIndexAdditionalObs = [];
validSizeObs = @(x) (size(x,2) == nbVariables);
addOptional(p,'additionalC', defaultAdditionalObs, validSizeObs);
addOptional(p,'indexAdditionalObservations', defaultIndexAdditionalObs);

parse(p,varargin{:})
if length(p.Results.indexAdditionalObservations) ~= size(p.Results.additionalC,1)
    error('Length of index must be equal to number of additional observations')
end



% Plot
nbColumns = ceil(sqrt(nchoosek(nbAxes,2)));
nbRows    = ceil(nchoosek(nbAxes,2)/nbColumns);

fig = figure(figNumber); clf
    fig.Name = 'Projection of the observations';
indPlot = 0;

for indPlot1 = 1:nbAxes
    for indPlot2 = indPlot1+1:nbAxes
        indPlot = indPlot + 1;
        axs = subplot(nbRows, nbColumns, indPlot);
        
        %%%%%%%%%%%%%%%%%% COMPLETER LE CODE ICI
        for k = 1: size(C, 1) % nbr d'ind
            x = C(k, indPlot1); % 
            y = C(k, indPlot2); 
            text(x+.05,y-.05,num2str(k))
        end 
        %%%%%%%%%%%%%%%%%% FIN COMPLETER LE CODE
        
        
            if ~isempty(p.Results.indexAdditionalObservations)
                plt = plot(p.Results.additionalC(:, indPlot1), p.Results.additionalC(:,indPlot2), 'd'); hold on
                    set(plt, 'MarkerFaceColor', axs.ColorOrder(2,:))
                text(p.Results.additionalC(:, indPlot1)+.05, p.Results.additionalC(:,indPlot2)-.05, num2str(p.Results.indexAdditionalObservations(:)))

                valMinX = min([C(:, indPlot1) ; p.Results.additionalC(:, indPlot1)]);
                valMaxX = max([C(:, indPlot1) ; p.Results.additionalC(:, indPlot1)]);
                valMinY = min([C(:, indPlot2) ; p.Results.additionalC(:, indPlot2)]);
                valMaxY = max([C(:, indPlot2) ; p.Results.additionalC(:, indPlot2)]);
            else
                valMinX = min(C(:, indPlot1));
                valMaxX = max(C(:, indPlot1));
                valMinY = min(C(:, indPlot2));
                valMaxY = max(C(:, indPlot2));
                
            end
            
            grid on
            axis equal
            
            xlim(1.1*[valMinX valMaxX])
            ylim(1.1*[valMinY valMaxY])

            xlabel(['Component ' num2str(indPlot1)])
            ylabel(['Component ' num2str(indPlot2)])
    end

end
