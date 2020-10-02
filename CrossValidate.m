% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% n-fold cross-validation
function [mean_acc, auc] = CrossValidate(dataFile, saveFold, CLF, nFold, isFix, thres)
data = ReadData(dataFile);
numBags = data.numBags;
labels = zeros(1, numBags);
for n = 1 : numBags
    labels(n) = data.bags{n}.label;
end

mkdirs(saveFold);
fixPath = [dataFile '_fold.mat'];
if isFix && exist(fixPath, 'file')
    fprintf('load data partition (%s)\n', fixPath);
    load(fixPath,'train_ids', 'test_ids');
else
    [train_ids, test_ids] = GenerateFoldIds(labels, nFold);
    save(fixPath, 'train_ids', 'test_ids');
    fprintf('save data partition (%s)\n', fixPath);
end

parfor n = 1 : nFold
    test_id = test_ids{n};
    train_id = train_ids{n};
    test_data = GetSubset(data, test_id);
    train_data = GetSubset(data, train_id);
    fold = fullfile(saveFold, ['fold' num2str(n)]);
    foldTrain = [fold, '_train.data'];
    foldTest  = [fold, '_test.data'];
    foldModel = [fold, '.model'];
    WriteData(test_data, foldTest);
    WriteData(train_data, foldTrain);
    TrainModel(CLF, foldTrain, foldModel);
    TestModel(CLF, foldTest, foldModel);
    results{n} = ReadResult([foldTest '.result']);
end

% results = results{:};
% merge results 
numBags = 0;
for n = 1 : numel(results); 
    numBags = numBags + results{n}.numBags; 
    numClass = results{n}.numClass; 
    
end
all_results.numBags = numBags; 
all_results.numClass = numClass; 
bags = [];

for n =  1: numel(results)
    bags = [bags; results{n}.bags]; 
end
all_results.bags = bags; 
% compute accuracy
[mean_acc, auc] = MeasureResult(all_results, thres);
resultPath = fullfile(saveFold, 'result.mat');
save(resultPath, 'results', 'mean_acc', 'auc', 'CLF');
end

% generate training and test ids for each fold
function [train_ids, test_ids] = GenerateFoldIds(labels, nFold)
posIds = find(labels == 1);
negIds = find(labels ~= 1);
allIds = 1 : numel(labels);
numPos = numel(posIds);
numNeg = numel(negIds);
posIds = posIds(randperm(numPos));
negIds = negIds(randperm(numNeg));
nPos = round(numPos / nFold);
nNeg = round(numNeg / nFold);
train_ids = cell(nFold, 1);
test_ids = cell(nFold, 1);
for n = 1 : nFold
    if (n ~= nFold)
        test_pos_id =  posIds((n-1)*nPos+1:n*nPos);
        test_neg_id = negIds((n-1)*nNeg+1:n*nNeg);
    else
        test_pos_id =  posIds((n-1)*nPos+1:end);
        test_neg_id = negIds((n-1)*nNeg+1:end);
    end
    test_ids{n} = [test_neg_id, test_pos_id];
    train_ids{n} = setdiff(allIds, test_ids{n});
end

end

% get subset given traininng and test data ids
function [sub_data] = GetSubset(data, ids)
sub_data.numFtrs = data.numFtrs;
sub_data.bags = data.bags(ids);
sub_data.numBags = numel(ids);
sub_data.numInsts = 0;
for k = 1 : sub_data.numBags
    sub_data.numInsts = sub_data.numInsts + sub_data.bags{k}.numInst;
end
end