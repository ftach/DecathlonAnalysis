clear all
close all
clc


load('data_score.mat');
indexSelectedPoints = 1:57;
N = 59;
nameVariables = {'100m' ; 'longueur' ; 'poids' ; ...
'hauteur' ; '400m' ; '110m' ; 'disque' ; ...
'perche' ; 'javelot' ; '1500m' ; 'score'};
 [scoreClassed,I] = sort(Data(:,end), 1, 'descend');

 Y = Data(I,:);


 %Y = Y( indexSelectedPoints, :);

 % Y = tableau trié, I=tableau des

%% Analyse descriptive des données
% données centrées
g = Y'*ones(N,1) / N;
A = mean(Y, 1);
X_Centered = Y - ones(N,1) * g.';
% Covariance
D_W = eye(N)*(1/N);
X_Cov = X_Centered' * D_W * X_Centered;

% Corrélation
x_var = var(Y, 1);
D_sigma = diag(1./sqrt(x_var));

X_Cor = D_sigma * X_Cov * D_sigma;

% tableau centré réduit
X_Normalized = X_Centered*D_sigma;



%% représentation
plot_SignificantCorrelation(X_Cor, 0.7, Y, nameVariables, I, 1)
figure(3)
boxplot(X_Normalized, nameVariables)


%% ACP
indexDeletedColumn =1:10;
X_Normalized = X_Normalized(:,indexDeletedColumn);
X_Cor = X_Cor(indexDeletedColumn,indexDeletedColumn);
Y = Y(:, indexDeletedColumn)
x_var = var(Y, 1);

% vecteur propres et val propres
[L,B] = eig(X_Cor);
lambda = diag(B);
[lambda, index] = sort(lambda,1,'descend');
V = L(:,index);


%normalisation
M = eye(10); % car on travaille avec X tilde
%beta = ones(1, 10);
%for i=1:10
    %beta(i) = sqrt(x_var(i)/(V(:,i)'*V(:,i)));
    %V(:,i) = V(:,i)*beta(i); % axes principaux
    %(1/x_var(i))*(V(:,i)'*V(:,i)) % verification = 1
%end

% facteurs principaux



% composantes principales
X_Centered = X_Centered(:,indexDeletedColumn);
C = X_Normalized*V

% Vérifications
trace(D) % =10
C(:, 1)'*D_W*C(:, 1) % =lambda1 normalement
C(:, 1)'*D_W*C(:, 2) % =0 normalement

% Interprétations
bar(D) % diagramme de coude ou critère de Kaiser (vp>1)
% qualité globale
% cercle de corrélation (angle petit et distance proche du cercle unité)


