function [accuracy, p_value] = classify_pairwise_loo(data, y)


nclasses = length(unique(y));
c = zeros(1, nclasses);
for i = 1:nclasses, c(i) = sum(y==i);end

accuracy = zeros(nclasses);
conf = zeros(nclasses);
p_value = zeros(nclasses);

for p1 = 1:nclasses
    for p2 = p1+1:nclasses
        mission = ['_' num2str(p1) '_' num2str(p2) '_pairs'];
        % create balance between classes in SVM
        flags = [' -w1 ' num2str(c(p2)/c(p1))];

        % create a binary classification problem between p1 and p2
        data12 = [data(:, y==p1) data(:, y==p2)];
        y12 = [ones(c(p1), 1); -ones(c(p2), 1)];
       
        n = c(p1)+c(p2);
        ry = zeros(n, 1);
        rw = zeros(n, 1);
        
        % learn loo models
        for i = 1:n
            tr = data12(:, setdiff(1:n, i));
            y_tr = y12(setdiff(1:n, i));
            [tr,stats] = normalize_std_mean(tr);
            tst = normalize_std_mean(data12(:, i), stats);
            MODEL = train(y_tr, sparse(tr'), [flags ' -B 1 ']);
            [ry(i),a, rw(i)] = predict(y12(i), sparse(tst'),MODEL);
        end
        % evaluate accuracy
        accuracy(p1, p2) = mean(ry==y12);
        accuracy(p2, p1) = accuracy(p1, p2);
        p_value(p1, p2) = ranksum(rw(1:c(p1)), rw(c(p1)+1:end));       
        p_value(p2, p1) = p_value(p1, p2);
    end     % end 2nd class   
end % end 1st class



