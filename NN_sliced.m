function NNxs=NN_sliced(is,tmps,xs,NNxshapes,NNxorchs)
%sliced function for parallel implementation NN_structures_par
    
load('NN_structural_properties.mat')
load('NNN_structural_properties.mat')

    NNxs{1,1}=tmps(is).Sequence;
    NNxs{1,2}=nt2int(tmps(is).Sequence);
    
    for j=1:53 % size NN structural properties
        
        for k=1:xs-1  % size of nn
            % transform nn int to matrix NNsp - 4x(n1-1)+n2
            NNxs{1,2+j}(k) = NNsp{2+j,(6 + (4*(NNxs{1,2}(k)-1)+NNxs{1,2}(k+1)))};
        end
        
        %sum if specified in matrix
        if strcmp(NNsp{2+j,5},'Y')
           NNxs{1,2+j}(2,1) = sum(NNxs{1,2+j}(1:xs-1));
        elseif strcmp(NNsp{2+j,5},'M')
            NNxs{1,2+j}(2,1) = mean(NNxs{1,2+j}(1:xs-1));
        elseif strcmp(NNsp{2+j,5},'I')
            NNxs{1,2+j}(2,1) = xs/sum(1./NNxs{1,2+j}(1:xs-1)); %width/sum(1./a(i:i+(width-1)));
        else                                                % elseif strcmp(NNsp{2+j,5},'N')
            NNxs{1,2+j}(2,1) = mean(NNxs{1,2+j}(1:xs-1));  % NNx{i,2+j}(x) = [];  % matrix index is out of range for deletion
        end
        
    end
    
    for j=1:4 %size NNN structural properties - shift by NN!
  
        for k=1:xs-2 % size of nnn
            l=1;
            while (strcmp(NNNsp{l,1}(1:3),NNxs{1,1}(k:k+2)) || strcmp(NNNsp{l,1}(5:7),NNxs{1,1}(k:k+2))) == 0; %loop breaks when NNN is found
                l=l+1;
            end
            NNxs{1,2+53+j}(k) = NNNsp{l,1+j};
        end
        NNxs{1,2+53+j}(2,1) = mean(NNxs{1,2+53+j}(1:xs-2)); %mean dnaze data
        
    end
    
    %for % count pyrimidine - C 2, T 4, purine A 1, G 3
    
    % append DNAshapeR, Orchid2 and TIDD, oligoprop data
    NNxs{1,60}=cell2mat(NNxshapes{is,2});
    NNxs{1,61}=cell2mat(NNxshapes{is,3});
    NNxs{1,62}=cell2mat(NNxshapes{is,4});
    NNxs{1,63}=cell2mat(NNxshapes{is,5});
    NNxs{1,64}=NNxorchs(is,2:end); %orchid empty for NN5
    
    for j = 1:4
        NNxs{1,2+53+4+j}(2,1) = mean(NNxs{1,2+53+4+j}(1:end));
    end
    
    tmpt=weka_run_NN_10_5_16(NNxs{1,1});
    NNxs{1,65}=tmpt'; %samo na prvem nukleotidu je napoved pri NN5, na ostalih mestih cirkularizirane napovedi 
    NNxs{1,65}(2,1)=NNxs{1,65}(1);
    
    tmpo=oligoprop(NNxs{1,1}); %only correct for sequences larger than 8bp
    NNxs{1,66}=tmpo.Tm;
    NNxs{1,66}(2,1)=NNxs{1,66}(1);
end