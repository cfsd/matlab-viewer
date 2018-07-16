%%
% Blue cones are drawn as [0 0 1] ('b')
% Yellow cones are drawn as [1 1 0] ('y')
% Orange cones are drawn as [1 0.5 0]
% Unclassified cones are drawn as grey [0.5 0.5 0.5]



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
t_ssr = data.data(:,5) + data.data(:,6)*1e-6;
SwitchStateReading = data.data(:,7);

tevent = t_ssr(1);     % unix time. Add the time for when you want
                          % animation to start. Use online converter
                          % if you know the specific time of day.
                          
tstop  = t_ssr(end);      % if you want specfic duation just copy 
                          % tevent and add the duration. Otherwise
                          % just enter the time to stop the animation


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
AimPointDistance = data.data(:,9);

A = importdata('opendlv.logic.perception.GroundSurfaceArea-211.csv');
t_surface =  (A.data(:,5) + A.data(:,6)*1e-6);
SurfaceID = A.data(:,7);
SurfaceX1 = A.data(:,8);
SurfaceY1 = A.data(:,9);
SurfaceX2 = A.data(:,10);
SurfaceY2 = A.data(:,11);
SurfaceX3 = A.data(:,12);
SurfaceY3 = A.data(:,13);
SurfaceX4 = A.data(:,14);
SurfaceY4 = A.data(:,15);
localPath = [SurfaceX1, SurfaceX2, SurfaceX4, SurfaceX3, SurfaceY1, SurfaceY2, SurfaceY4, SurfaceY3, SurfaceID];

%% Animation 

[~,t0] = min(abs(t_objt-tevent));
[~,tend] = min(abs(t_objt-tstop));
t = t_objt(t0:tend);


ObjectPositionX = ObjectDistance.*cosd(ObjectAngle+90);
ObjectPositionY = ObjectDistance.*sind(ObjectAngle+90);

AimPointAngleInterp = interp1(t_aim,AimPointAngle,t_objt);
AimPointDistanceInterp = interp1(t_aim,AimPointDistance,t_objt);

L  = 1.525;
l1 = 0.55*L;
l2 = 0.45*L;
w1 = 1.25/2;
w2 = 1.2/2;

X1 = w2;
Y1 = -l2;
X2 = -w2;
Y2 = -l2;
X3 = -w1;
Y3 = l1+0.7;
X4 = w1;
Y4 = l1+.7;