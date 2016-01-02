% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% Train a model 
function [] = TrainModel(CLF, dataFile, modelFile)
if ispc
    binPath = 'MCILBoost.exe';
elseif isunix
    binPath = './MCILBoost';
else
    fprintf('not working for the current OS\n');
end
trainCmd = sprintf('%s -v %d -t 0 -s %d -n %d -c %d -r %f %s %s',...
    binPath, CLF.verbose, CLF.softmaxType, CLF.numWeakClfs, ...
    CLF.numCls,  CLF.r, dataFile, modelFile);

if CLF.verbose >= 1
    disp(trainCmd);
end
system(trainCmd);
end

