functoin analyze_pairwise_loo(data, y)
nclasses = length(unique(y));

for i = 1:nclasses, c(i) = sum(y==i); end
clear acc_mat p_mat confmat

for t = 1:length(types_names)
    acc_mat{t} = zeros(nclasses);
    p_mat{t} = zeros(nclasses);
    confmat{t} = zeros(nclasses);
    for p1 = 1:nclasses
        for p2 = p1+1:nclasses
            mission = [types_names{t} '_' num2str(p1) '_' num2str(p2) '_pairs'];
            if ~exist(['all_pairs_loo/' mission '.mat'], 'file')
                disp(['all_pairs_loo/' mission '.mat'])
            end
   
        
            load(['all_pairs_loo/' mission '.mat']);
            %'acc','conf12','conf21', 'p');
            acc_mat{t}(p1, p2) = acc;
            confmat{t}(p1,p2) = conf12;
            confmat{t}(p2, p1) = conf21;
            p_mat{t}(p1, p2) = p;
         end     % end 2nd class   
    end % end 1st class        
end % end type
save('pairs.mat','acc_mat','confmat','p_mat','cdirectories')   
a = acc_mat{3};
s='%s\t';
for i = 1:12,s = [s '%0.3f\t '];end
fprintf('\t\t');for i = 1:12, fprintf('%s\t',cdirectories{i});end;fprintf('\n');
for i = 1:12
fprintf([s '\n'], cdirectories{i}, a(i,:));
end