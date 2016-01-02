% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% Set the parameters for demoMCILBoost
function PARAMS = SetParamsDemo2()
PARAMS.mode      = 'cross-validate'; % train, test, cross-validate
PARAMS.dataFile  = fullfile('data', 'sival.data');  
PARAMS.modelFile = 'sival.expr';  % in train/test model, it's the model name in 'cross-validate' model, it's the name of the folder that stores all the data
PARAMS.resultFile = 'sival.result'; % result file
CLF.verbose      = 0;     % 0: none; 1: some; 2: more
CLF.softmaxType  = 0;     % 0: Gm, 1:Lse
CLF.numWeakClfs  = 150;   % number of weak classifiers
CLF.numCls       = 1;     % number of classes in the positive bags 
CLF.r            = 20.0;  % exponent r used in GM and LSE
PARAMS.CLF       = CLF;   % set classifier parameters
PARAMS.isFix     = true;  % if use the same data partition for cross-validation
PARAMS.nFold     = 10;     % #folds for cross-validation
PARAMS.thres     = 0.5;   % threshold for prediction
end

% corel_2, corel4