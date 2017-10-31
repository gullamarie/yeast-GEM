%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model = addGeneNames(model)
% 
% Benjam�n S�nchez. Last edited: 2017-10-25
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function model = addGeneNames(model)

%Correct gene ids for proper matching:
model.genes = strrep(model.genes,'_','-');

%Load data:
data        = load('ProtDatabase.mat');
swiss.genes = data.swissprot(:,3);
for i = 1:length(swiss.genes)
    swiss.genes{i} = strsplit(swiss.genes{i},' ');
end

%Get gene names:
for i = 1:length(model.genes)
    for j = 1:length(swiss.genes)
        if sum(strcmp(swiss.genes{j},model.genes{i})) > 0
            model.geneNames{i} = swiss.genes{j}{1}; %First occurence is the gene name
        end
    end
    disp(['Adding gene names: Ready with gene #' int2str(i)])
end

%Revert gene ids for SBML compatibility:
model.genes = strrep(model.genes,'-','_');

%Save model:
cd ..
saveYeastModel(model)

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%