%For PSOCT only
%For santec OCT only

clearvars

pathname = uigetdir('D:\new_bovine\4');

initial = 1;
final = 250;
numberscan = 250;
depth = 874;
    
bscan = final-initial+1;
databin = zeros(bscan, numberscan, depth);
y = zeros(bscan,depth);

fid = fopen([pathname '/Data.bin'], 'r');
fseek(fid, 0, 'bof');
x = fread(fid, bscan*numberscan*depth, 'float', 'b');
n = 0;
for m = initial:final
    count = (m-1)*n*depth;
    for n = 1:numberscan
        startresizey = (depth*(n-1)+count);
        finalresizey = (depth*(n)+count);
        y(n,:) = x(startresizey+1:finalresizey);
    end
    databin(m,:,:) = y;
end
fclose(fid);

for o = initial:final
    z = databin(o,:,:);
    z = rot90(mat2gray(squeeze(z)),3);
    imwrite(z,[pathname '\' num2str(o) '.tif']);
end
    
% cd(pathname);
% 
% nameholder = [pathname '_x_' num2str(final) '_z_' num2str(numberscan) '_y_num' num2str(depth) 'complete.raw'];
% fid = fopen(nameholder,'w+');
% test = fwrite(fid, databin, 'uint16');
% fclose(fid);