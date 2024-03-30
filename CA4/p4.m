%% 4.3
table = readtable('diabetes-training.csv');
predictedLabel=trainedModel.predictFcn(table);

actualLabels = table2array(table(:, end));

comparison = predictedLabel == actualLabels;

similarityPercentage = sum(comparison) / length(comparison) * 100;

disp(['Percentage of Similarity: ', num2str(similarityPercentage), '%']);

%% 4.4
table = readtable('diabetes-validation.csv');
predictedLabel2=trainedModel.predictFcn(table);

actualLabels1 = table2array(table(:, end));

comparison = predictedLabel2 == actualLabels1;

similarityPercentage = sum(comparison) / length(comparison) * 100;

disp(['Percentage of Similarity: ', num2str(similarityPercentage), '%']);