% compute area under ROC curve 
function [auc] = AUC(preds, labels)
thres = unique(preds);
num_thres= numel(thres);
tp = zeros(num_thres, 1); 
tn = zeros(num_thres, 1); 
for n = 1 : num_thres
    t = thres(n);
    tp(n) = sum(labels==1 & (preds>=t)) / sum(labels==1);
    tn(n) = sum(labels==0 & (preds <t)) / sum(labels==0);
end
xroc=flipud([1; 1-tn; 0]); yroc=flipud([1; tp; 0]); %ROC points
auc=trapz(xroc,yroc);
end

