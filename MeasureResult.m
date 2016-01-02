% compute accuracy with a givne threshold
% compute area under ROC curve
function [mean_acc, auc] = MeasureResult(result, thres)
numBags = numel(result.bags);
preds = zeros(numBags, 1);
labels = zeros(numBags, 1);
accs = zeros(numBags, 1);

for k = 1 : numBags
    pred  = (result.bags{k}.pred > thres);
    label = min(1, max(0, result.bags{k}.label));
    accs(k) = (pred == label);
    preds(k) = result.bags{k}.pred;
    labels(k)     = label;
end

mean_acc = mean(accs);
auc = AUC(preds, labels);
fprintf('accuracy=%3.3f (thres=%3.3f), auc=%3.3f\n'...
    , mean_acc, thres, auc);

end

