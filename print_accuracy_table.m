function print_accuracy_table(accuracy, class_names, precision)

pstr = sprintf('%%.%df\t',precision);
nclasses = length(class_names);
% header line
fprintf('\t\t');
for i = 1:nclasses, fprintf('%s\t\t',class_names{i});end;
fprintf('\n');
for i = 1:nclasses
    fprintf('%s\t',class_names{i})
    for j = 1:nclasses
        fprintf(pstr, accuracy(i,j));
    end
    fprintf('\n')
end