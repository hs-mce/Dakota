clc
clear all

%%%% experimental coordinates %%%%

data_exp= dlmread('outputR-2000000.txt',' ',9,0);
Natoms = size(data_exp,1);
exp_cords =[];
   for line=1:Natoms 
       id = data_exp(line,1);
          x = data_exp(line,3);
          y = data_exp(line,4);
          z = data_exp(line,5);
   
exp_cords =[exp_cords; id x y z];
   end

%%% read the final equailibrated state of FS potential %%%

    readfile = 326; 
%     textFileName = ['output-' num2str(readfile) '.txt'];
    textFileName = ['relaxed_fin.lmp'];
        Natoms = 8213;
        
	if exist(textFileName, 'file')
%        data = dlmread(textFileName,' ',9,0);       
%         data = dlmread(textFileName,' ',16,0);
        data = dlmread(textFileName,' ',[17 0 8229 7]);
    
%     Natoms = size(data,1);

%%%% calculating the least square distance %%%%% 

 obj=0;
     for line=1:Natoms 
       id = data(line,1);
          x = data(line,3);
          y = data(line,4);
          z = data(line,5);
      
          
      %% if only want to consider the core of the dislocation
      % y_new = y - y_org;
      % z_new = z - z_org;
      % r = sqrt(y_new^2 + z_new^2);

      %%% calculate the objective function %%%
      kk = find(abs(exp_cords(:,1)-id) < 1e-5);
      x_exp = exp_cords(kk,2);
      y_exp = exp_cords(kk,3);
      z_exp = exp_cords(kk,4);

     % if (r<=10) 
      obj = obj+ sqrt((x-x_exp).^2 + (y-y_exp).^2 + (z-z_exp).^2);
      %end

     end

    else
		fprintf('File %s does not exist.\n', textFileName);
    
    end

     obj = obj/Natoms

%%%%%%%

