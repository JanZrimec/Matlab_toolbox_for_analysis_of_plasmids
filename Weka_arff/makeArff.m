function [] = makeArff(data,label,name,names,name_begin,name_end)
% create arff file
% data ... input data for arff file
% label ... labels of data classes
% name ... name of arff file
% names ... actual class labels used in arff
% name_begin ... name of file containing @RELATION some_name
% name_end ... name of file containing @ATTRIBUTE class {c1,c2,...,cn}

[m,n] = size(data);
dat2=cell(m,n+1);

for i = 1:m   
        for j=1:n
            dat2{i,j}=data(i,j);
        end
    dat2{i,end}=names(label(i)); 
end
dlmcell_rand([name,'.txt'],dat2,', ')

fileID = fopen('arff_name_tmp.txt','w');
for i=1:n
fprintf(fileID,'@ATTRIBUTE att%d numeric\n',i);
end
fclose(fileID);

system(['touch arff_name.txt']);
system(['cat ',name_begin,' >> arff_name.txt']);
system(['cat arff_name_tmp.txt >> arff_name.txt']);
system(['cat ',name_end,' >> arff_name.txt']);
system(['rm arff_name_tmp.txt']);

system(['touch ',name,'.arff']);
system(['cat arff_name.txt >> ',name,'.arff']);
system(['cat ',name,'.txt >> ',name,'.arff']);
system(['rm arff_name.txt']);
system(['rm ',name,'.txt']);

end