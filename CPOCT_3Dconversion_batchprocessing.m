%This program mass-converts CP-OCT files inside a folder
%This version adds horizontal distortion correction
%New Dragonfly OCT parameters: 248x257x1024 pixels
%Image spacing: 23.438x23.438x9.524 um
%Authors: Vincent Yang, Yihua Zhu


function batchImageConversion()
    % Select the top-level directory
    topDir = uigetdir('');
    
    % Get a list of all subfolders
    allSubDirs = genpath(topDir);
    dirList = strsplit(allSubDirs, pathsep);
    
    for i = 1:length(dirList)
        currentDir = dirList{i};
        
        % Process each subfolder if it is not empty
        if ~isempty(currentDir)
            processFolder(currentDir);
        end
    end
end

function processFolder(pathname)
    initial = 0;
    final = 255;
    numberscan = 256;
    depth = 1024;
    
    bscan = final - initial + 1;
    databin = zeros(bscan, numberscan, depth);
    
    for m = initial:final
        fid = fopen([pathname '/' num2str(m)], 'r');
        if fid == -1
            continue; % Skip if the file doesn't exist
        end
        
        fseek(fid, 8, 'bof');
        x = fread(fid, numberscan * depth, 'float', 'ieee-be');
        fclose(fid);
        
        for n = 1:numberscan
            startresize = (depth * (n - 1)); % [0, 1024, 2048 ...]
            finalresize = (depth * n); % [1024, 2048, 3072 ...]
            
            databin(m + 1, n, :) = x(startresize + 1:finalresize); % 1:1024, 1025:2048
        end
    end
    
    databin(databin < 0) = 0;
    
    % Define the geometric transform
    p1 = -1.174000000000000e-08;
    p2 = 2.934000000000000e-05;
    p3 = -0.010170000000000;
    p4 = 1.941000000000000;
    p5 = -11.200000000000000;
    g = @(c) [p1 * c(:, 1).^4 + p2 * c(:, 1).^3 + p3 * c(:, 1).^2 + p4 * c(:, 1).^1 + p5, c(:, 2)];
    tform = geometricTransform2d(g);
    
    new_databin = zeros(248,257,1024);
    
    for i = 1:depth
        I = imrotate(databin(:, :, i), 90);
        J = imrotate(imwarp(I, tform), -90);
        new_databin(:, :, i) = J;
    end
    
    % Save images
    nameholder = [pathname '_x_' num2str(248) '_z_' num2str(257) '_y_num' num2str(1024) 'complete.raw'];
    fid = fopen(nameholder, 'w+');
    fwrite(fid, new_databin, 'uint16');
    fclose(fid);
end