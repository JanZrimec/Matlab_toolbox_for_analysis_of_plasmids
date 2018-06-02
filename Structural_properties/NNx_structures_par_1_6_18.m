function [out]=NNx_structures_par_1_6_18(in,tidd)
% function that calculates and returns structural properties of sequences 
% in ... input sequences in cell array format
% out ... output sturctures in cell array format 
% tidd ... add predictions of tidd properties

tmps=length(in);
x=length(in{1});
out=cell(tmps,1);
pp = ParforProgress; %https://se.mathworks.com/matlabcentral/fileexchange/48705-parforprogress-class

parfor i = 1:tmps
    tmp=NN_sliced(in,tidd,i,x);
    out{i}=tmp;
    iteration_number = step(pp, i);
    fprintf('Finished iteration %d of %d\n', iteration_number, i); 
end

end