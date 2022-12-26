% This program is for Apnea Detection using Electrocardiography (ECG)

% Name : Sanjana Vijayakumar Nambiar
% Date Created : December 4, 2021     
% Assignment 4: Bioengineering Assignment  
% ENGR-UH 1000 Computer Programming for Engineers, NYUAD 
% Problem: Is to develop a program for Apena Detection using Electrocardiography (ECG) 

disp('This program is for Apnea Detection using Electrocardiography (ECG)')
disp('Given the ECG data it give 75% correct prediction of apnea')

% loading ecg data from the file
ecgData = load("a01.txt");
%getting the first column of time data from the matrix
timeFull = ecgData(:,1);
%getting the time data for the first four hours
time = timeFull(1:1440000,:);
%getting the second column of ecg data from the matrix
signalFull = ecgData(:,2);
%getting the ecg data for the first four hours
signal = signalFull(1:1440000,:);
%Converting the ECG signal to Volt
volt = (signal./200);

%opening a new window to graph time vs volt
figure
plot(time,volt);
title ('ECG Data'); %providing title to the graph
%labeling the axes
xlabel('Time');
ylabel('Voltage');

%extracting the 2 second data from time and volt
sec2Time_0 = time(1:1000,:);
sec2Data_0 = volt(1:1000,:);

Fs = 500;
[resampleData, resampleTime] = resample(volt, time, Fs);
resampleData = spline(resampleTime, resampleData, resampleTime);

%extracting the 2 second data from resampleTime and resampleData
sec2Time_1 = resampleTime(1:1000,:);
sec2Data_1 = resampleData(1:1000,:);

figure
plot(sec2Time_0,sec2Data_0,'r');
hold on; 
plot(sec2Time_1,sec2Data_1,'y');
hold off;
title ('Normal Data and Resampled Data'); %providing title to the graph
%labeling the axes
xlabel('Time');
ylabel('ECG Data');
legend('Normal Data','Resampled Data');

d = designfilt('lowpassfir', 'Filterorder', 5, 'CutoffFrequency', 25, 'SampleRate', Fs);
filteredData = filter(d, resampleData);

%extracting the 2 second data from resampledTime and filteredData
sec2Time_2 = resampleTime(1:1000,:);
sec2Data_2 = filteredData(1:1000,:);

figure
plot(sec2Time_1,sec2Data_1,'r');
hold on;
plot(sec2Time_2,sec2Data_2,'y');
hold off;
title("Comparison between filtered data and unfiltered data"); %providing title to the graph
%labeling the axes
xlabel('Time');
ylabel('ECG Data');
legend('Resampled Data', 'FilteredData');

%extracting the 60 second data from filteredData and resampledTime
sec60Data1 = filteredData(1:30000,:);
sec60Time1 = resampleTime(1:30000,:);
figure
plot(sec60Time1,sec60Data1);
title("Sixty Second Data"); %providing title to the graph
%labeling the axes
xlabel('Time');
ylabel('ECG Data');

Peaks1 =[];
% finding the time at which the peaks occur
for a=2:length(sec60Data1)-1
    if sec60Data1(a)>0.003 && (sec60Data1(a)>sec60Data1(a+1)) && (sec60Data1(a)>sec60Data1(a-1))
        Peaks1 = [Peaks1, sec60Time1(a)];
    end
end

len1 = length(Peaks1);
RRinterval1 = [];
% finding the differences between successive peaks
for b = 2:len1
   diff1 = Peaks1(b) - Peaks1(b-1);
   RRinterval1 = [diff1, RRinterval1];
end
HR1 = (1./RRinterval1).*60;

avgHR1 = mean(HR1);
maxHR1 = max(HR1);
minHR1 = min(HR1);

avgHR = [];
maxHR = [];
minHR = [];
for c = 1:30000:length(filteredData)-30000
    d = c+30000;

    %extracting the 60 second data from filteredData and resampledTime
    sec60Data = filteredData(c:d,:);
    sec60Time = resampleTime(c:d,:);

    % finding the time at which the peaks occur
    Peaks=[];
    for e=2:length(sec60Data)-1
        if sec60Data(e)>0.003 && (sec60Data(e)>sec60Data(e+1)) && (sec60Data(e)>sec60Data(e-1))
            Peaks = [Peaks sec60Time(e)];
        end
    end
    Peaks = Peaks.';
    
    RRinterval = [];
    len = length(Peaks);
    % finding the differences between successive peaks
    for f = 2:len
        diff = Peaks(f) - Peaks(f-1);
        RRinterval = [diff, RRinterval];
    end
    RRinterval = RRinterval.';
    HR = (1./RRinterval).*60;
    
    avgHR = [avgHR, mean(HR)];
    maxHR = [maxHR, max(HR)];
    minHR = [minHR, min(HR)];
end

time4Hours = 1:length(avgHR);
figure
plot(time4Hours, avgHR);
title('Average Heart Rate for 4 Hrs'); %providing title to the graph
%labeling the axes
xlabel('Time');
ylabel('Heart Rate Data');

Fs = 4;
DownsampleTime1 = resample(sec60Time1,4,500);
DownsampleData1 = resample(sec60Data1,4,500);
FFTData1 = fft(DownsampleData1);
frequency1 = 1./DownsampleTime1;
N = length(DownsampleData1);
powerDensityData1 = (1/(Fs*N))* abs(FFTData1).^2;

figure
plot(frequency1,powerDensityData1);
title ('Power Spectral Density'); %providing title to the graph
%labeling the axes
xlabel('Frequency (Hz)');
ylabel('Power');

frequency2 = [];
FFTDat =[];
powerDensityData2 = [];
PSDarray = [];
hz4Time = [];
for g = 1:30000:length(filteredData)-30000
    h = g+30000;

    %extracting the 60 second data from filteredData and resampledTime
    sec60Data3 = filteredData(g:h,:);
    sec60Time3 = resampleTime(g:h,:);
   
    DownsampleData2 = resample(sec60Data3,4,500);
    DownsampleTime2 = resample(sec60Time3,4,500);
    hz4Time = [hz4Time; DownsampleTime2];

    FFTData2 = fft(DownsampleData2);
    FFTDat = [FFTDat; FFTData2];
    N = length(DownsampleData2);
    frequency2 = [frequency2; 1./DownsampleTime2];
    powerDensityData2 = [powerDensityData2; (1/(Fs*N))* abs(FFTData2).^2];
    PSDarray = [PSDarray, (1/(Fs*N))* abs(FFTData2).^2];
end

figure
plot (frequency2, powerDensityData2);
title("Frequency vs Power for 4 hrs"); %providing title to the graph
%labeling the axes
xlabel('Frequency (Hz)');
ylabel('Power');

pcolor(PSDarray);
shading flat;
hold all;
plot(avgHR,'r');
title ('Spectrogram of the signal'); %providing title to the graph
%labeling the axes
xlabel('time(minutes)');
ylabel('Heart rate');

apnea = [''];
for i= 1:length(avgHR)
   if(avgHR(i)>68)
        apnea = [apnea; 'N'];
   else
       apnea = [apnea; 'A'];
   end 
end 
disp(apnea);
