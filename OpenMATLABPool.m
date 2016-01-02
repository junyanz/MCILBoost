% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% Open MATLAB pool
function [size] = OpenMATLABPool(n)
if matlabpool('size') == 0 && n ~= 1
    if n <= 0
        n = 8;
    end
    defaultProfile = parallel.defaultClusterProfile;
    myCluster = parcluster(defaultProfile);
    myCluster.NumWorkers = n;
    matlabpool(myCluster, 'open');
    
end

size = matlabpool('size');
end

