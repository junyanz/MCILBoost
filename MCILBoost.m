% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% Please kindly cite the following paper if you use our code.
% "Multiple Clustered Instance Learning for Histopathology Cancer Image
% Segmentation, Clustering, and Classification"
% Yan Xu*, Jun-Yan Zhu*, Eric Chang and Zhuowen Tu. (*equal contribution)
% main entry function
function [mean_acc, auc] = MCILBoost(PARAMS)
CLF = PARAMS.CLF;
dataFile = PARAMS.dataFile;
modelFile = PARAMS.modelFile;
resultFile = PARAMS.resultFile;
nFold = PARAMS.nFold;
thres = PARAMS.thres;
isFix = PARAMS.isFix;
mean_acc = 0;
auc = 0;

switch PARAMS.mode
    case 'train'
        TrainModel(CLF, dataFile, modelFile);
    case 'test'
        TestModel(CLF, dataFile, modelFile, resultFile);
        result = ReadResult(resultFile);
        [mean_acc, auc] = MeasureResult(result, thres);
    case 'cross-validate'
        [mean_acc, auc] = CrossValidate(dataFile, modelFile, CLF, nFold, isFix, thres);
    otherwise
        disp('wrong mode input');
end
end