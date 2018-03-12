function out=weka_run_NN_2_9_17(klas,names)
 
%t=getCurrentTask(); % vseen ce se prepise
%bla=sprintf('tmp_%d',t.ID);

name{1} = sprintf('count_W5_sum_T1_w00_rand.arff');
zero=zeros(size(klas));
para(1,:) = [5,0,3,1]; %W(width), wide(neighboring), 3, T(treshold)

i=1;
    bla=sprintf('tmp%d',names);

    name2 = PBDNN_make_arff_euk_nerand(bla,klas,zero,para(i,1),para(i,2),para(i,3),para(i,4));
    
    baba = [bla,'.test'];
    command = ['java -cp weka.jar weka.classifiers.trees.M5P -t ',name{i},' -T ',name2,' -classifications "weka.classifiers.evaluation.output.prediction.CSV -file ',baba,'"'];
    [~]=unix(command);
    bobr=dlmread(baba,',',1,0);
    
    out=bobr(:,3);
