function [X, gt, c] = getData(data, infRes)
    Data_ori = ones(1,1)
    if data == 4
         mat = csvread('./Data/opt/optdigits.data');
         gt = mat(:,65);
         Data_ori = mat(:,1:64)';
         c = 10;
         for i = 1 : size(gt)
             if gt(i,1) == 0
                 gt(i,1) = 10;
             end
         end
    end
    if  data == 2
         mat = csvread('./Data/Wine/wine.data');
         Y = mat(:,1);
         X = mat(:,2:14);
         c = 3;
         gt = Y;
         Data_ori = X';
    end
    if  data == 1
         mat = csvread('./Data/UMIST/UMIST.data');
         Data_ori = mat';
         gt = [];
         c = 20;
         for k=1:c
             nn = 19;
             ind = k*ones(nn,1);
             gt = [gt; ind];
         end
    end     
    if  data ==  3
         mat = csvread('./Data/Ionosphere/ionosphere.data');
         Y = mat(:,35);
         X = mat(:,1:34)';
         c = 2;
         gt = Y;
         Data_ori = X;     
    end
    [~,n]=size(Data_ori);
    %PCA
    X1 = Data_ori;
    thresh = infRes;
    X1 = zscore(X1');
    [~, SCORE, latent]=princomp(X1); 
    contr = cumsum(latent)./sum(latent);
    k = find(contr>=thresh,1);
    X = (SCORE(:,1:k))';

    H = eye(n) - 1/n*ones(n);
    X = X*H;                    
end


