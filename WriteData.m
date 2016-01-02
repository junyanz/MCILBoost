% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% Write Matlab data to a text file
function [] = WriteData(data, dataFile)
fid = fopen(dataFile, 'wt');
if fid == -1
    fprintf('cannot write file (%s)\n', dataFile);
else
    fprintf(fid, '%d %d\n', data.numInsts, data.numFtrs);
    countInst = 0;
    numFtrs = data.numFtrs;
    for n = 1 : data.numBags
        bag = data.bags{n};
        label = bag.label; 
        bagId = bag.id; 
        %         id = bag.bag
        for k = 1 : bag.numInst
            inst = bag.insts{k};
            fprintf(fid, '%d:%d:%d ', countInst, bagId, label);
            countInst = countInst + 1;
            tmp = zeros(numFtrs*2,1);
            tmp(1:2:end) = 1 : numFtrs; 
            tmp(2:2:end) = inst.ftr; 
%             for l = 1 : numFtrs
            fprintf(fid, '%d:%f ', tmp);
%             end
            fprintf(fid, '\n');
        end
    end
    
    fclose(fid);
end

end

