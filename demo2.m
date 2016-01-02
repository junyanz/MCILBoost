% SIVAL experiment: 
% [Data File]: sival.data
% [Description]: There are 180 positive bags (smileyfacedoll, bluescrunge, greenteabox) 
% and 180 negative bags (checkeredscarf, dirtyrunningshoe, feltflowerrug)
% We rescaled the original features to [0, 1].
% We performed 10-fold cross-validation over 10 runs. 
% [Link]: http://www.cs.wustl.edu/~sg/multi-inst-data/
% [Measurement]: 
% mean_acc: mean accuracy with threshold=0.5
% mean_auc: area under ROC curve
% [Script]:      demo2.m
% [Result]:
% MIL-Boost:  mean_acc = 0.742, mean_auc = 0.824
% MCIL-Boost: mean_acc = 0.879, mean_auc = 0.944

disp('*****************************************************');
disp('demo 2: SIVAL experiment');
disp('positive bags: 180 images (smileyfacedoll, bluescrunge, greenteabox)');
disp('negative bags: 180 images (checkeredscarf, dirtyrunningshoe, feltflowerrug)');
disp('Experiment: MIL-Boost and MCIL-Boost');
nRuns = 10;
nClass = 3;
mil_accs = zeros(nRuns, 1);
mil_aucs = zeros(nRuns, 1);
mcil_accs = zeros(nRuns, 1);
mcil_aucs = zeros(nRuns, 1);

for n = 1 : nRuns
    disp('MIL-Boost');
    PARAMS = SetParamsDemo2;
    PARAMS.mode = 'cross-validate';
    PARAMS.CLF.numCls = 1;
    PARAMS.isFix = false; % update data partition
    PARAMS.modelFile = fullfile('SIVAL_mil_cross', ['run' num2str(n)]);
    [mil_accs(n), mil_aucs(n)] = MCILBoost(PARAMS);
   
    disp('MCIL-Boost');
    PARAMS.mode = 'cross-validate';
    PARAMS.isFix = true; % fix data partition
    PARAMS.CLF.numCls = nClass;
    PARAMS.modelFile = fullfile('SIVAL_mcil_cross', ['run' num2str(n)]);
    [mcil_accs(n), mcil_aucs(n)] = MCILBoost(PARAMS);
end

fprintf('\nresult over (%d) runs:\n', nRuns);
fprintf('MIL-Boost: mean_acc=%3.3f, mean_auc=%3.3f\n', ...
    mean(mil_accs), mean(mil_aucs));
fprintf('MCIL-Boost (c=%d): mean_acc=%3.3f, mean_auc=%3.3f\n', ...
    3, mean(mcil_accs), mean(mcil_aucs));
