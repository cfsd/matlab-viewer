close all
%%
% Blue cones are drawn as [0 0 1] ('b')
% Yellow cones are drawn as [1 1 0] ('y')
% Orange cones are drawn as [1 0.5 0]
% Unclassified cones are drawn as grey [0.5 0.5 0.5]


tevent = 1530901418.035430;     % unix time. Add the time for when you want
                                % animation to start. Use online converter
                                % if you know the specific time of day.
tstop  = 1530901418.035430 + 15; % if you want specfic duation just copy 
                                % tevent and add the duration. Otherwise
                                % just enter the time to stop the animation
pauseTime = 0.5;                % Amount of time between each frame
windowSize = [-7 7 -4 10];      % The window size in [m].
csvFilePath = [''];             % Add the path to the csv files here or put
                                % this script in the same folder as the csv
                                % files. Don't put csv files in the git
                                % folder since it will clog the repo.
                                % Leaving it blank is fine you don't want to
                                % add a folder to the path.

if ~strcmp(csvFilePath,'')
    addpath(csvFilePath)
end

%%
% Useful to see the AS state (ready signal, etc.)
data = importdata('opendlv.proxy.SwitchStateReading-1401.csv');
t_ssr = -(data.data(1,5) + data.data(1,6)*1e-6) + (data.data(:,5) + data.data(:,6)*1e-6);
SwitchStateReading = data.data(:,7);


% Cone type
data = importdata('opendlv.logic.perception.ObjectType-118.csv');
t_objt = (data.data(:,5) + data.data(:,6)*1e-6);
ObjectId = data.data(:,7);
ObjectType = data.data(:,8);
blueCones = ObjectType==1;
blueId = ObjectId(blueCones);

% Cone direction
data = importdata('opendlv.logic.perception.ObjectDirection-118.csv');
ObjectAngleId = data.data(:,7);
ObjectAngle = data.data(:,8);

% Cone distance
data = importdata('opendlv.logic.perception.ObjectDistance-118.csv');
ObjectDistanceId = data.data(:,7);
ObjectDistance = data.data(:,8);

% Aimpoint (heading request)
data = importdata('opendlv.logic.action.AimPoint-221.csv');
t_aim =  (data.data(:,5) + data.data(:,6)*1e-6);
AimPointAngle = data.data(:,7);
AimPointDistance = data.data(:,8);


%% Animation 

[~,t0] = min(abs(t_objt-tevent));
[~,tend] = min(abs(t_objt-tstop));
t = t_objt(t0:tend);


ObjectPositionX = ObjectDistance.*cosd(ObjectAngle+90);
ObjectPositionY = ObjectDistance.*sind(ObjectAngle+90);

AimPointAngleInterp = interp1(t_aim,AimPointAngle,t_objt);
AimPointDistanceInterp = interp1(t_aim,AimPointDistance,t_objt);

figure;

for i = t0:tend
    if ObjectId(i)==0
        pause(pauseTime)
        clf
        plot(0,0,'^','MarkerSize',10)
        hold on
        axis(windowSize)
        timeStamp = sprintf('Time stamp: %15.6f',t_objt(i));
        XLim = xlim;
        YLim = ylim;
        text(mean(XLim),0.8*YLim(2),timeStamp)
    end
    h = plot(ObjectPositionX(i), ObjectPositionY(i),'o');
    set(h,'MarkerSize',9)
    set(h,'MarkerEdgeColor',[0.5 0.5 0.5])
    switch ObjectType(i)
        case 1
            set(h,'MarkerFaceColor','b')
        case 2 
            set(h,'MarkerFaceColor','y')
        case 3 
            set(h,'MarkerFaceColor',[1 0.5 0])
        case 4
            set(h,'MarkerFaceColor','r')
        case 666
            set(h,'MarkerFaceColor',[0.5, 0.5, 0.5])
    end
    
    plot(AimPointDistanceInterp*[0 cos(AimPointAngleInterp(i)+pi/2)],AimPointDistanceInterp*[0 sin(AimPointAngleInterp(i)+pi/2)],'k-o')

end


