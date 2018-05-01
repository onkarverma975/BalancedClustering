
function [Y, Obj] = Iterations(gamma, lam, mu, X, Y)
    [dim, n] = size(X);

    X = X*(eye(n) - 1/n*ones(n));

    c = size(Y,2);   % number of clusters  
    
    Lambda = zeros(n,c); 
    
    P = eye(dim)/(X*X'+gamma*eye(dim));

    for iter = 1:2000

        b = mean(Y)';
        W = P*(X*Y);
        E = X'*W + ones(n,1)*b' - Y;

        Z = (-2*lam*ones(n)+(mu+2*n*lam)*eye(n))/(mu^2+2*n*lam*mu)*(mu*Y+Lambda);

        V = 1/(2+mu)*(2*X'*W);
        V = V + 1/(2+mu)*(2*ones(n,1)*b');
        V = V + 1/(2+mu)*(mu*Z - Lambda);

        [nul, ind] = max(V,[],2);
        Y = zeros(n,c);
        Y((1:n)' + n*(ind-1)) = 1;

        Lambda = Lambda + mu*(Y-Z);
        mu = min(mu*1.005, 10^5);

        Obj(iter) = trace(E'*E) + gamma*trace(W'*W) + lam*trace(Y'*ones(n)*Y);

    end;
end



