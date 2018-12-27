clc;
clear all;
close all;
%==========================================================================

nameOfChemical='NaCl'; %<=== fill this data (automaticaly add to title of graph)---------
M_value='2.0M'; % <===  if distilled '' if conc '0.5M'
url='./Analysis/Analysis.xlsx';% file address
sheet_number=3; % <====== sheet_number=1 is Distilled water

%==========================================================================

sheet='';

switch(sheet_number)
    case 1
        sheet='Distilled water';
    case 2
        sheet='0.5MNacl';
    case 3
        sheet='2MNacl';
end

full_name=[M_value,' ',nameOfChemical];

[ml0_Time,ml2_Time,ml4_Time,ml6_Time]=allData_Pressure_time_volume_voltage_frequncy(url,sheet);

figure, % figure one
plot(ml0_Time{1},ml0_Time{2},':o');
hold on;
plot(ml2_Time{1},ml2_Time{2},':+');
hold on;
plot(ml4_Time{1},ml4_Time{2},':*');
hold on;
plot(ml6_Time{1},ml6_Time{2},':x');
title(['Pressure of the bubble (Pa) vs time (s) for ',full_name]);
ylabel('Pressure of the bubble (Pa)');
xlabel('time (s)');
legend('0ml Bubble one','2ml Bubble one','4ml Bubble one','6ml Bubble one','Orientation','horizontal');
hold off;

list_leg=[];
if(~isempty(ml0_Time{5}))
    list_leg=[list_leg;'0ml Bubble 1'];
end
if(~isempty(ml0_Time{7}))
    list_leg=[list_leg;'0ml Bubble 2'];
end
if(~isempty(ml2_Time{5}))
    list_leg=[list_leg;'2ml Bubble 1'];
end
if(~isempty(ml2_Time{7}))
    list_leg=[list_leg;'2ml Bubble 2'];
end
if(~isempty(ml4_Time{5}))
    list_leg=[list_leg;'4ml Bubble 1'];
end
if(~isempty(ml4_Time{7}))
    list_leg=[list_leg;'4ml Bubble 2'];
end
if(~isempty(ml6_Time{5}))
    list_leg=[list_leg;'6ml Bubble 1'];
end
if(~isempty(ml6_Time{7}))
    list_leg=[list_leg;'6ml Bubble 2'];
end

figure, % figure two
plot(ml0_Time{5},ml0_Time{6},'o');
hold on;
plot(ml0_Time{7},ml0_Time{8},'o');
hold on;
plot(ml2_Time{5},ml2_Time{6},'o');
hold on;
plot(ml2_Time{7},ml2_Time{8},'o');
hold on;
plot(ml4_Time{5},ml4_Time{6},'o');
hold on;
plot(ml4_Time{7},ml4_Time{8},'o');
hold on;
plot(ml6_Time{5},ml6_Time{6},'o');
hold on;
plot(ml6_Time{7},ml6_Time{8},'o');
title({['Pressure of the bubble (Pa) vs Volume (mm3)'],[' for ',full_name]});
ylabel('Pressure of the bubble (Pa)');
xlabel('Volume (mm3)');
legend(list_leg);
hold off; %,'Orientation','horizontal'




function [ml0_Time,ml2_Time,ml4_Time,ml6_Time]=allData_Pressure_time_volume_voltage_frequncy(url,sheet) % this function implemt given below read_data.. two functions
   ml0_Time={};
   ml2_Time={};
   ml4_Time={};
   ml6_Time={};
    %
    [time1_ml0,time2__ml0,vol_bub1__ml0,vol_bub2__ml0,press_bub1__ml0,press_bub2__ml0]=read_data_Pressure_time_volume(url,sheet,2);
    
    [time1_ml2,time2__ml2,vol_bub1__ml2,vol_bub2__ml2,press_bub1__ml2,press_bub2__ml2]=read_data_Pressure_time_volume(url,sheet,6);
    
    [time1_ml4,time2__ml4,vol_bub1__ml4,vol_bub2__ml4,press_bub1__ml4,press_bub2__ml4]=read_data_Pressure_time_volume(url,sheet,10);
    
    [time1_ml6,time2__ml6,vol_bub1__ml6,vol_bub2__ml6,press_bub1__ml6,press_bub2__ml6]=read_data_Pressure_time_volume(url,sheet,14);
    
     ml0_Time={time1_ml0,press_bub1__ml0,time2__ml0,press_bub2__ml0,vol_bub1__ml0,press_bub1__ml0,vol_bub2__ml0,press_bub2__ml0};
     ml2_Time={time1_ml2,press_bub1__ml2,time2__ml2,press_bub2__ml2,vol_bub1__ml2,press_bub1__ml2,vol_bub2__ml2,press_bub2__ml2};
     ml4_Time={time1_ml4,press_bub1__ml4,time2__ml4,press_bub2__ml4,vol_bub1__ml4,press_bub1__ml4,vol_bub2__ml4,press_bub2__ml4};
     ml6_Time={time1_ml6,press_bub1__ml6,time2__ml6,press_bub2__ml6,vol_bub1__ml6,press_bub1__ml6,vol_bub2__ml6,press_bub2__ml6};
end

function [time1,time2,vol_bub1,vol_bub2,press_bub1,press_bub2]=read_data_Pressure_time_volume(url,sheet,steps)% read sheet 1 datas
        [num,~,~]= xlsread(url,sheet); % read excel file
        
        timeR=num(:,1);
        
        vol_bub1R=num(:,steps);
        press_bub1R=num(:,steps+1);
        
        vol_bub2R=num(:,steps+2);
        press_bub2R=num(:,steps+3);
        
        time1=[];
        vol_bub1=[];
        press_bub1=[];
        
        time2=[];
        vol_bub2=[];
        press_bub2=[];
        % removing NaN & null values
    for r=1:1:length(timeR)
        if(~isnan(vol_bub1R(r)))&&(~isnan(press_bub1R(r)))&&(~isnan(timeR(r)))
            time1=[time1,timeR(r)];
            vol_bub1=[vol_bub1,vol_bub1R(r)];
            press_bub1=[press_bub1,press_bub1R(r)];
        end
        
         if(~isnan(vol_bub2R(r)))&&(~isnan(press_bub2R(r)))&&(~isnan(timeR(r)))
            time2=[time2,timeR(r)];
            vol_bub2=[vol_bub2,vol_bub2R(r)];
            press_bub2=[press_bub2,press_bub2R(r)];
        end
    end
end