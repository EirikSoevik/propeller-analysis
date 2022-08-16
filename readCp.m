function [alpha,x,y,cp] = readCp(i)

filename = strcat('cpny/cp',num2str(i),'.txt');
fid = fopen(filename,'r');
[~] =  fscanf(fid, '%s',[1, 3]);
alpha = fscanf(fid, '%f',[1, 1]);
[~] =  fscanf(fid, '%s',[1, 11]);
A = fscanf(fid,'%f',[3,inf])';
x = A(:,1);
y = A(:,2);
cp = A(:,3);
fclose(fid);



end