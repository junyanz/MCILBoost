% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% Test a model 
function [] = TestModel(CLF, dataFile, modelFile, resultFile)
if nargin == 3
    resultFile = [dataFile '.result'];
end
if ispc
    binPath = 'MCILBoost.exe';
elseif isunix
    binPath = './MCILBoost';
else
    fprintf('not working for the current OS\n');
end

testCmd = sprintf('%s -v %d -t 1 -s %d -n %d -c %d -r %f %s %s %s',...
    binPath, CLF.verbose, CLF.softmaxType, ...
    CLF.numWeakClfs, CLF.numCls, CLF.r, dataFile, modelFile, resultFile);
if CLF.verbose >= 1
    disp(testCmd);
end
system(testCmd);
end

