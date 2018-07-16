
if i == 0 || i > length(t_objt)
    playAnimation = false;
    disp('i out of bound')
else
    if ObjectId(i)==0
        t_current = t_objt(i);
        surfIdx = find(t_surface>t_current);
        if ~isempty(surfIdx)
            surfIdx = surfIdx(1);
            while localPath(surfIdx,end)~=0
                surfIdx=surfIdx+1;
            end
            if surfIdx < length(localPath)
                surfIdx=surfIdx+1;
            end
            NumbOfPatches = 0;
            while localPath(surfIdx+NumbOfPatches,end)~=0
                NumbOfPatches = NumbOfPatches+1;
            end
        else
            surfIdx=1;
        end
        cla
        axis(windowSize)
        plot(0,0,'^','MarkerSize',10)
        hold on
        timeStamp = sprintf('Time stamp: %15.6f',t_objt(i));
        XLim = xlim;
        YLim = ylim;
        text(XLim(2)*0.2,0.9*YLim(2),timeStamp,'FontSize',12)
        for k = 0:NumbOfPatches
            patch(-localPath(surfIdx+k,5:8),localPath(surfIdx+k,1:4),'r')
        end
        plot(AimPointDistanceInterp(i)*[0 cos(AimPointAngleInterp(i)+pi/2)],AimPointDistanceInterp(i)*[0 sin(AimPointAngleInterp(i)+pi/2)],'k--o')
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
end
