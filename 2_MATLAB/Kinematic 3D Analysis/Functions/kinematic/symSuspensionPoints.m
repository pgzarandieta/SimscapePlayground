function Xsym = symSuspensionPoints(X)
if isrow(X)
    Xa = X(:);
else
    Xa = X;
end
s = length(Xa(:,1,1,1));
sym = zeros(s,1);
for i = 3:3:s
    sym(i-2:i) = [1 -1 1];
end
Xsym = Xa.*sym;
if isrow(X)
    Xsym = Xsym';
end
end