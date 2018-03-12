function [out]=NNx_structural_properties_31_12_17(in)
% function that calculates and returns structural properties of sequences 
% in ... input sequences in cell array format
% out ... output sturctures in cell array format 

%tmp=fastaread(fasta);
%[tmps,~]=size(tmp);
tmps=length(in);
x=length(in{1});
NNx=cell(tmps,66);
load('NN_structural_properties.mat')
load('NNN_structural_properties.mat')

for i = 1:tmps
    NNx{i,1}= in{i};%tmp(i).Sequence;
    NNx{i,2}=nt2int(in{i}); %tmp(i).Sequence);
    
    for j=1:53 % size NN structural properties
        
        for k=1:x-1  % size of nn
            % transform nn int to matrix NNsp - 4x(n1-1)+n2
            NNx{i,2+j}(k) = NNsp{2+j,(6 + (4*(NNx{i,2}(k)-1)+NNx{i,2}(k+1)))};
        end
        
        %sum if specified in matrix
        if strcmp(NNsp{2+j,5},'Y')
            for kk=1:x-1-9
                NNx2{i,2+j}(1,kk) = sum(NNx{i,2+j}(kk:kk+9));
            end
        elseif strcmp(NNsp{2+j,5},'M')
            for kk=1:x-1-9
                NNx2{i,2+j}(1,kk) = mean(NNx{i,2+j}(kk:kk+9));
            end
        elseif strcmp(NNsp{2+j,5},'I')
            for kk=1:x-1-9
                NNx2{i,2+j}(1,kk) = 10/sum(1./NNx{i,2+j}(kk:kk+9)); %width/sum(1./a(i:i+(width-1)));
            end
        else                                                % elseif strcmp(NNsp{2+j,5},'N')
            for kk=1:x-1-9
                NNx2{i,2+j}(1,kk) = mean(NNx{i,2+j}(kk:kk+9));  % NNx{i,2+j}(x) = [];  % matrix index is out of range for deletion
            end
        end
        
    end
    
    for j=1:4 %size NNN structural properties - shift by NN!
  
        for k=1:x-2 % size of nnn
            l=1;
            while (strcmp(NNNsp{l,1}(1:3),NNx{i,1}(k:k+2)) || strcmp(NNNsp{l,1}(5:7),NNx{i,1}(k:k+2))) == 0; %loop breaks when NNN is found
                l=l+1;
            end
            NNx{i,2+53+j}(k) = NNNsp{l,1+j};
        end
        for kk=1:x-2-9
            NNx2{i,2+53+j}(1,kk) = mean(NNx{i,2+53+j}(kk:kk+9)); %mean dnaze data
        end
        
    end
    
end



out=NNx2(:,3:end);
end