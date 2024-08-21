% clc
% clear all


Nfile = 1001; % File averaging number
startfile = 0; % Start file timestep
fileinc = 2000; % File timestep increment

KE = zeros(Nfile,1); PE = zeros(Nfile,1); x_coord = zeros(Nfile,1); y_coord = zeros(Nfile,1); z_coord = zeros(Nfile,1);

y_org = 85.8404; z_org = 25.6991;  %%% define origin at the dislocation line.
ke_disc=zeros(Nfile,1); pe_disc=zeros(Nfile,1);

tic
for filecount = 1:Nfile
    currentfile = startfile + (filecount-1)*fileinc;
    textFileName = ['output-' num2str(currentfile) '.txt'];
	if exist(textFileName, 'file')
       data = dlmread(textFileName,' ',9,0);
       Natoms = size(data,1);

       ke = sum(data(:,7));
       pe = sum(data(:,8));
       
     for line=1:Natoms 
       id = data(line,1);
          x = data(line,3);
          y = data(line,4);
          z = data(line,5);
       y_new = y - y_org;
       z_new = z - z_org;
       r = sqrt(y_new^2 + z_new^2);

          % if (id==2536)
          % x_id = data(line,3);
          % y_id = data(line,4);
          % z_id = data(line,5);
          % 
          % end
     
    %   %%%%% calcluate quantities around dislocation %%%%%%
    %   if (r<=5)
    % %     'ddd'
    %    ke_disc(filecount,1) = ke_disc(filecount,1) + data(line,7);
    %    pe_disc(filecount,1) = pe_disc(filecount,1) + data(line,8);
    % 
    %   end
      
      end

    else
		fprintf('File %s does not exist.\n', textFileName);
    
    end 


KE(filecount,1) = ke;
PE(filecount,1) = pe;
% x_coord(filecount,1) = x_id;
% y_coord(filecount,1) = y_id;
% z_coord(filecount,1) = z_id;
    
% filecount

end

dt=0.002*500;
time = 0:dt:1000*dt;
time=time';

% figure(1)
% hold on
% plot(time(1:50:end), KE(1:50:end),'*k')
% 
% figure(2)
% hold on
% plot(time(1:50:end),PE(1:50:end),'*k')

% figure(3)
% hold on
% plot(time,x_coord,'+k')
% 
% figure(4)
% hold on
% plot(time,y_coord,'+k')
% 
% figure(5)
% hold on
% plot(time,z_coord,'+k')





