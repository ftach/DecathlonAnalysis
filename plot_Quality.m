function plot_Quality(QLT, indexSelectedPoints, ...
    thresholdGood, thresholdBad, ...
    nbObs, nbAxes, figNumber, ...
    varargin)



%plot_Quality Plot the quality of the observations.
%
%   plot_Quality(QLT, indexSelectedPoints, thresholdGood, thresholdBad, ...
%    nbObs, nbAxes, figNumber)
%
%   This function plots the quality of the observations after the PCA.
%
%   Inputs:
%       _ QLT is a N-by-P matrix where the (i,j)-th entry is the quality of
%       the i-th observation on the j-th principal component.
%       _ indexSelectedPoints is the N vector of the indexes of the
%       selected observations to compute the PCA among the original data.
%       _ thresholdGood is the value of the threshold considered as a
%       "good" quality.
%       _ thresholdBad is the value of the threshold considered as a "poor"
%       quality.
%       _ nbObs is the total number of observations in the original data.
%       _ nbAxes is a number of principal components kept to display the
%       PCA
%       _ figNumber is the number of the figure.
%
%   plot_Quality(...,'PARAM1',VAL1,'PARAM2',VAL2,...) specifies 
%   additional parameters and their values.  
%   Valid parameters are the following (ALL OF THEM MUST BE USED):
%
%     Parameter             Value
%      'additionalQuality'    is a M-by-P matrix where the (i,j)-th entry
%                             is the quality of M additional observations.
%                   
%      'indexAdditionalObservations'    is the M vector of the indexes of the
%                                       additional observations among the 
%                                       original data.




% Parse parameters
nbVariables = size(QLT,2);


p = inputParser;
defaultAdditionalObs = [];
defaultIndexAdditionalObs = [];
validSizeObs = @(x) (size(x,2) == nbVariables);
addOptional(p,'additionalQuality', defaultAdditionalObs, validSizeObs);
addOptional(p,'indexAdditionalObservations', defaultIndexAdditionalObs);

parse(p,varargin{:})
if length(p.Results.indexAdditionalObservations) ~= size(p.Results.additionalQuality,1)
    error('Length of index must be equal to number of additional observations')
end




fig = figure(figNumber); clf
    fig.Name = 'Quality of observations';
    for indPlot = 1:nbAxes
        axs = subplot(nbAxes+1, 1, indPlot);
        
        
        
            %%%%%%%%%%%%%% COMPLETER LE CODE ICI

            plt = bar(indexSelectedPoints, QLT(:,indPlot) *100); 
            hold on
            plt = plot([0 nbObs+1], 100*thresholdGood * ones(1,2));
            set(plt, 'LineWidth', 2)
            plt = plot([0 nbObs+1], 100*thresholdBad * ones(1,2));
            set(plt, 'LineWidth', 2)           
            
            %%%%%%%%%%%%%% FIN COMPLETER LE CODE
            
            
            
            if ~isempty(p.Results.indexAdditionalObservations)
                plt = bar(p.Results.indexAdditionalObservations, p.Results.additionalQuality(:,indPlot) * 100); hold on
                    plt.FaceColor = axs.ColorOrder(2,:);
            end
            
            
            
            grid on
            ylim([0 100])
            ylabel(['QLT (axe ' num2str(indPlot) ') [%]'])
            xlabel('individu')
    end
    axs = subplot(nbAxes+1, 1, nbAxes+1);
        bar(indexSelectedPoints, sum(QLT(:,1:nbAxes), 2) * 100); hold on
        plt = plot([0 nbObs+1], 100*thresholdGood * ones(1,2));
            set(plt, 'LineWidth', 2)
        plt = plot([0 nbObs+1], 100*thresholdBad * ones(1,2));
            set(plt, 'LineWidth', 2)
            
        if ~isempty(p.Results.indexAdditionalObservations)
            plt = bar(p.Results.indexAdditionalObservations, sum(p.Results.additionalQuality(:,1:nbAxes),2) * 100); hold on
                plt.FaceColor = axs.ColorOrder(2,:);
        end
            

        ylim([0 100])
        grid on
        ylabel(['QLT (axes ' num2str(1:nbAxes) ') [%]'])
        xlabel('individu')
