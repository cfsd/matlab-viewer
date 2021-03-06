a='0';b='0';
S.fh = figure('units','pixels',...
    'position',[100 100 1000, 600],...
    'menubar','none','name','move_fig',...
    'numbertitle','off',...
    'keypressfcn',@f_capturekeystroke);

S.tx = uicontrol('style','text',...
    'units','normalized', ...
    'position',[.01 .5 .1 .1],...
    'fontweight','bold');

guidata(S.fh,S)

dim = [.01 .85 0 0];
str = ['Controls for player:\n', ...
        'Play/pause: space\n', ...
        'Forward: up arrow\n', ...
        'Rewind: down arrow\n', ...
        'Step forward: right arrow\n', ...
        'Step backward: left arrow\n', ...
        'Increase speed: f\n', ...
        'Decrease speed: h\n', ...
        'Stop player: escape'];
str = sprintf(str);
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);

function  f_capturekeystroke(H,E)
% capturing and logging keystrokes
S2 = guidata(H);
P = get(S2.fh,'position');
str = sprintf('Last keypress:\n');
set(S2.tx,'string',[str, E.Key])

assignin('base','a',E.Key)    % passing 1 keystroke to workspace variable
%evalin('base','b=[b a]');  % accumulating to catch combinations like ctrl+S

end
