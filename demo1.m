% [Data File]: fox.data, tiger.data, elephant.data
% [Link]: http://www.miproblems.org/datasets/foxtigerelephant/
% [Description]: 10 runs, 10-fold cross-validation
% [Measurement]: mean accuracy (threshold=0.5)
% [Script]:      demo1.m
% [Result]
% Fox:       0.61
% Tiger:     0.81
% Elephant:  0.82
disp('*****************************************************');
disp('demo 1: Fox, Tiger, Elephant experiment');
names = {'fox', 'tiger', 'elephant'};
PARAMS = SetParamsDemo1;
nRuns = 1;

for n = 1 : numel(names)
    accs = zeros(nRuns, 1); 
    aucs = accs; 
    for k = 1 : nRuns
        fprintf('experiment (%s) run (%d)\n', names{n}, k);
        PARAMS.dataFile = fullfile('data', [names{n} '.data']);
        PARAMS.modelFile = fullfile([names{n} '_mil_cross'], ...
            ['run' num2str(k)]);
        [accs(k), aucs(k)] = MCILBoost(PARAMS);
    end
    fprintf('\n(%s)result over (%d) runs:\n', names{n}, nRuns);
    fprintf('mean_acc=%3.3f, mean_auc=%3.3f\n\n', mean(accs), mean(aucs));
end
disp('end demo1');
disp('*****************************************************');
