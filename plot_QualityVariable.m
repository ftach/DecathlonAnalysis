function plot_QualityVariable(QLTVariables, nameVariables, nbAxes, figNumber)




%plot_QualityVariable Plot the quality of the variables.
%
%   plot_QualityVariable(QLTVariables, nameVariables, nbAxes, figNumber)
%
%   This function plots the quality of the variables after the PCA.
%
%   Inputs:
%       _ QLTVariables is a P-by-P matrix where the (i,j)-th entry is the 
%       quality of the i-th initial variable on the j-th principal component.
%       _ nameVariables is a cell-array containing the name of the initial
%       variables.
%       _ nbAxes is a number of principal components kept to display the
%       PCA
%       _ figNumber is the number of the figure.
%




nbVariablesPCA = size(QLTVariables,1);

nbColumns = ceil(sqrt(nbVariablesPCA));
nbRows    = ceil(nbVariablesPCA/nbColumns);

fig = figure(figNumber); clf
    fig.Name = 'Quality of the variables';
for indPlot = 1:nbVariablesPCA
    axs = subplot(nbRows, nbColumns, indPlot);
        bar(QLTVariables(indPlot,:)); hold on
        plt = bar(nbVariablesPCA + 1, sum(QLTVariables(indPlot, 1:nbAxes)));
        
        axs.XTick = 1:nbVariablesPCA+1;
        axs.XTickLabel{nbVariablesPCA+1} = 'Total';
        
        ylabel('QLT var')
        xlabel('principal component')
        
        ylim([0 1])
        grid on
        
        title(nameVariables(indPlot))
end
