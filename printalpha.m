%to find input in for xFoil
for i=1:length(rR)
    if rR(i) == 0.2 || rR(i)==0.3 || rR(i) == 0.4 || rR(i) == 0.5 || rR(i)==0.6 || rR(i) == 0.7 || rR(i)==0.8 || rR(i)==0.9
        fprintf('alpha(%d)=%f\n',i,alpha(i));
    end
end