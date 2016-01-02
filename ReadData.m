% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% Read Matlab data from a text file.
function [data] = ReadData(dataFile)
fid = fopen(dataFile, 'rt');
data = [];

if fid == -1
    fprintf('cannot read data file (%s)\n', dataFile);
else
    bagIds = [];
    tmp = textscan(fid, '%f %f\n', 1);
    numInsts = tmp{1};
    numFtrs = tmp{2};
    
    data.numInsts = numInsts;
    data.numFtrs = numFtrs;
    numBags = 0;
    bags = cell(numInsts, 1);
    
    for n = 1 : numInsts
        bags{n}.numInst = 0;
        bags{n}.label = -1;
    end
    %     try
    for n = 1 : numInsts
        %         if n==2410
        %             fprintf('error');
        %         end
        tmp = textscan(fid, '%d:%d:%d', 1);
        instId = tmp{1};
        bagId = tmp{2};
        store_id = strfind(bagIds, bagId);
        
        if isempty(store_id)
            bagIds = [bagIds, bagId];
            numBags = numBags + 1;
            store_id = numBags;
        end
        
        bags{store_id}.numInst = bags{store_id}.numInst + 1;
        label = tmp{3};
        line = fgetl(fid);
        tmp = textscan(line, '%d:%f');
        ftr = zeros(numFtrs, 1);
        ftr(tmp{1}) = tmp{2};
        inst.ftr = ftr;
        inst.id = instId;
        bags{store_id}.insts{bags{store_id}.numInst}= inst;
        bags{store_id}.label = label;
        bags{store_id}.id    = bagId;
    end
    %     catch
    %         fprintf('error');
    %     end
    bags = bags(1:numBags);
    data.bags = bags;
    data.numBags = numBags;
    fclose(fid);
end

end

