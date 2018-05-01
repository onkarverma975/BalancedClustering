close all;
clear all;
results=zeros(6,1);
% as directed in the paper, we had to take the 
% best out of 10 tests.

% for grid search on parameters

%for i_lam = -3:5
 %   for i_mu = -3:0
 
        best=-10;
        %for test = 1:5
            clearvars -except i_lam i_mu results test best
            gamma = 10^(-5); 
            lam = 100;
            %lam = 10^(i_lam);
            mu = 0.1;
            %mu = 10^(i_mu);
            infRes = 0.90;    
            %choose dataset
            dataSet = 1 ; 
            % 1->UMIST, 2->wine, 3->ionosphere 4-> digit(bad results)
            [X, gt, c]=getData(dataSet, infRes);

            [d,n] = size(X);

            StartInd = randsrc(n,1,1:c);
            class_set = 1:c;
            Y0 = zeros(n, c);
            for cn = 1:c
                Y0((StartInd==class_set(cn)),cn) = 1;
            end;
            [Y, Obj] = Iterations(gamma, lam, mu, X, Y0);
            ys = sum(Y);
            figure; 
            plot(Obj);
            figure; 
            stem(ys);

            sum_a = 0;
            for i=1:c
                Nk = ys(i)+eps;
                sum_a = sum_a + Nk/n * log(Nk/n);
            end
            entropy = -1/(log(c)) * sum(sum_a);
            correct=0;
            
            for i = 1:n
                for j = 1:c
                    if Y(i,j)==1
                        if j==gt(i,1)
                            correct = correct + 1;
                        end
                    end
                end
            end
            if entropy > 0.8
                if correct > best
                    best = correct;
                end
            end
            ACC = correct/n * 100;
            ACC
            entropy
       % end
        %results = [results [mu, lam, entropy, best*100/n, best, n]'];
    %end
%end