function [] = mkdirs(folders )
try 
if iscell(folders)
    for n = 1 : numel(folders)
        if ~exist(folders{n}, 'dir')
            mkdir(folders{n});
        end
    end
else
    if ~exist(folders, 'dir')
        mkdir(folders);
    end
end
catch
    disp('error');
end
end

