table = readtable('123.csv');
table([1],:) = [];
Bcsn = cumsum(table.Value)/sum(table.Value);                            % Normalised Frequency Vector
median_idx = find(Bcsn <= 0.5, 1, 'last');          % Index Of Normalised Frequencies <= 0.5
I_median = table.BinEnd(median_idx);                           % Corresponding Element Of nAt
message = sprintf('Median Intensity = %.3f', I_median);msgbox(message); 
fprintf('Median = %f\n', I_median);