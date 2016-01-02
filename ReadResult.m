% Jun-Yan Zhu (junyanz at eecs dot berkeley dot edu)
% University of California, Berkeley
% Read Matlab result data from text file
function [result] = ReadResult(resultFile)
result = [];

fid = fopen(resultFile, 'rt');
if fid == -1
    fprintf('cannot read file (%s)\n', resultFile);
else
    tmp = textscan(fid, '#bags=%d #clusters=%d\n');
    numBags = tmp{1};
    numClass = tmp{2};
    bags = cell(numBags, 1);
    for n = 1 : numBags
        tmp = textscan(fid, 'bag_id=%d #insts=%d label=%d #clusters=%d pred=%f');
        bag.id = tmp{1};
        bag.numInsts = tmp{2};
        bag.label = tmp{3};
        bag.numClass = tmp{4};
        bag.pred = tmp{5};
        
        tmp = textscan(fid, 'cluster_id=%d pred=%f', bag.numClass);
        bag.class_pred = tmp{2};
        
        bag.insts = cell(bag.numInsts, 1);
        for k = 1 : bag.numInsts
            tmp = textscan(fid, 'inst_id=%d pred=%f ');
            inst.pred = tmp{2};
            tmp = textscan(fid, 'cluster_id=%d pred=%f ',bag.numClass*2);
            inst.class_pred = tmp{2};
            bag.insts{k} = inst;
        end
        bags{n} = bag;
    end
    result.numBags = numBags;
    result.bags = bags;
    result.numClass = numClass;
end

end

