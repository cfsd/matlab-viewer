% All parameteres users needs to tweak are within this section
close all; clear all;


windowSize = [-7 7 -4 10];      % The window size in [m].


% Add the path to the csv files here or put
% Them in the same folder as this matlab script
% <<<<<<<<<<<<<<<<-------- IMPORTANT!! % <<<<<<<<<<<<<<<<-------- IMPORTANT!!
                          % <<<<<<<<<<<<<<<<-------- IMPORTANT!!
                          % <<<<<<<<<<<<<<<<-------- IMPORTANT!! Enter the path to the csv files  
csvFilePath = [''];       % <<<<<<<<<<<<<<<<-------- IMPORTANT!! you want to use
                          % <<<<<<<<<<<<<<<<-------- IMPORTANT!!
% <<<<<<<<<<<<<<<<-------- IMPORTANT!!% <<<<<<<<<<<<<<<<-------- IMPORTANT!!


pauseTime = 0.05;         % This is only the initial time. It is possible
                          % to speed up or down after start (use f or h).

%%
loadCsvData;
playAnimation = true;
play = true;
playForward = true;
guiFeature;
subplot(1,2,2, 'units', 'normalized', 'position', [0.2,0.1,0.7,.8]);
i = 1;

while playAnimation
if strcmp(a,'escape')
    playAnimation = false;
    break;
end

if i >= length(ObjectId) && playForward
    if play
        disp('Reached end of recording')
    end
    play = false;
    if strcmp(a,'rightarrow') || strcmp(a,'space')
        a = '';
    end
end
    
if strcmp(a,'rightarrow')
    plotFunction;
    i=i+1;
    while ObjectId(i) ~= 0
        plotFunction;
        i = i+1;
    end
    a = '';
    play = false;
end

if strcmp(a,'leftarrow')
    i=i-1;
    while ObjectId(i) ~= 0
    i = i-1;
    end
    i0 = i;
    plotFunction
    i=i+1;
    while ObjectId(i) ~= 0
        plotFunction;
        i = i+1;
    end
    i = i0;
    a = '';
    play = false;
end

if strcmp(a,'uparrow')
    playForward = true;
end

if strcmp(a,'downarrow')
    playForward = false;
end

if strcmp(a,'f')
	if pauseTime > 0.02
        pauseTime = pauseTime-0.01;
    end
    a = '';
end

if strcmp(a,'h')
	if pauseTime < 1.5
        pauseTime = pauseTime+0.01;
    end
    a = '';
end

if playForward && play
    plotFunction;
    i=i+1;
    while ObjectId(i) ~= 0
        plotFunction;
        i = i+1;
    end
end

if ~playForward && play
    i=i-1;
    while ObjectId(i) ~= 0
    i = i-1;
    end
    i0 = i;
    plotFunction
    i=i+1;
    while ObjectId(i) ~= 0
        plotFunction;
        i = i+1;
    end
    i = i0;
end

if strcmp(a,'space')
    play = ~play;
    a = '';
end
pause(pauseTime);
end
close all;