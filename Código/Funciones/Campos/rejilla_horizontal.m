% Rejilla horizontal

function [campo] = rejilla_horizontal(x,a,Lambda,N,L)

[X,Y] = meshgrid(x,x);

campo = rect(X,a);

for i=1:floor(N/2)
    campo = campo + rect(X-i*Lambda,a) + rect(X+i*Lambda,a);
end

campo = campo.*rect(X,L).*rect(Y,L);

end
