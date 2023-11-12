function plot_Joint_Dendrogram(X, labelObs, name, figNumber, varargin)


% ...
%     ZObs, cutoffObservations, ...
%     ZVar, cutoffVariables)


p = inputParser;
defaultDendrogram = [];
defaultCutoff = [];

addOptional(p,'dendrogramObservations', defaultDendrogram);
addOptional(p,'cutoffObservations', defaultCutoff);

addOptional(p,'dendrogramVariables', defaultDendrogram);
addOptional(p,'cutoffVariables', defaultCutoff);


parse(p,varargin{:})


nbVariables = size(X, 2);

axsWidth  = .5;
axsHeight = .69;
fig = figure(figNumber); clf
    fig.Name = 'Joint dendrograms';

    % matrix of data
    axs = axes;
        axs.Position = [.48+axsWidth/(2*(nbVariables+1)) .3+ axsHeight/(2*length(labelObs)+1) ...
                        axsWidth/(nbVariables+1)*nbVariables axsHeight/(length(labelObs)+1)*length(labelObs)];
        imagesc(X)
        axis xy
        axs.XTickLabel = {};
        axs.YTickLabel = {};


    % Dendrogram observations
    if ~isempty(p.Results.dendrogramObservations)
        axs = axes;
            axs.Position = [.01 .3 .45 axsHeight];
            dendrogram(p.Results.dendrogramObservations, 0, ...
                        'labels', labelObs, ...
                        'ColorThreshold', p.Results.cutoffObservations, ...
                        'Orientation', 'left');
            axs.XTickLabel = {};
    end
        
        
    % Dendrogram variables
    if ~isempty(p.Results.dendrogramVariables)
    axs = axes;
        axs.Position = [.48 .02 axsWidth .25];
        dendrogram(p.Results.dendrogramVariables, 0, ...
            'labels', name(1:nbVariables), ...
            'ColorThreshold', p.Results.cutoffVariables, ...
            'Orientation', 'bottom');
        axs.YTickLabel = {};
    end
