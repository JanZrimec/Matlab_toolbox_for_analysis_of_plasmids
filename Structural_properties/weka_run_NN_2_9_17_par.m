function [out,name2]=weka_run_NN_2_9_17_par(klas,fname)
 
%t=getCurrentTask(); % vseen ce se prepise
%bla=sprintf('tmp_%d',t.ID);

name{1} = 'count_W10_sum_T1_w06_rand.arff';
zero=zeros(size(klas));
para(1,:) = [10,6,3,1]; %W(width), wide(neighboring), 3, T(treshold)

i=1;
bla=fname;
    
name2 = PBDNN_make_arff_euk_nerand(bla,klas,zero,para(i,1),para(i,2),para(i,3),para(i,4));
    
baba = [bla,'.test'];
command = ['java -cp weka.jar weka.classifiers.trees.M5P -t ',name{i},' -T ',name2,' -classifications "weka.classifiers.evaluation.output.prediction.CSV -file ',baba,'"'];
[~]=unix(command);
bobr=dlmread(baba,',',1,0);
    
out=bobr(:,3);

end
