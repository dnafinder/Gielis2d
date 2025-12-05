function varargout = Gielis2d(varargin)
%GIELIS2D
% The superformula is a generalization of the superellipse and was first
% proposed by Johan Gielis.
%
% Gielis suggested that the formula can be used to describe many complex
% shapes and curves that are found in nature. Others point out that the
% same can be said about many formulas with a sufficient number of
% parameters.
%
% Gielis, Johan (2003), "A generic geometric transformation that unifies a
% wide range of natural and abstract shapes", American Journal of Botany
% 90(3): 333-338.
%
% Notes:
% This function is a GUIDE-based GUI and requires the companion Gielis2d.fig
% file to run correctly.
%
% The GUI provides:
% - Parameters A, B, M, N1, N2, N3 through edit7..edit12
% - Plot type selection via radiobutton7..9
%   (polar plot, XY plot, comet plot)
% - Curve type selection via radiobutton10..12
%   (superellipse, superroses, superspirals)
%
% Created by Giuseppe Cardillo
% Email: giuseppe.cardillo.75@gmail.com
% GitHub: https://github.com/dnafinder
%
% To cite this file, this would be an appropriate format:
% Cardillo G. (2006). Superformula Generator 2d: a GUI interface to trace a
% 2d plot of the parametric Gielis Superformula.
% Available at: https://github.com/dnafinder/Gielis2d

% Begin initialization code - DO NOT EDIT
ws = warning('query','MATLAB:dispatcher:InexactMatch');
warning('off','MATLAB:dispatcher:InexactMatch')

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gielis2d_OpeningFcn, ...
                   'gui_OutputFcn',  @Gielis2d_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

warning(ws.state,'MATLAB:dispatcher:InexactMatch')
% End initialization code - DO NOT EDIT


% --- Executes just before Gielis2d is made visible.
function Gielis2d_OpeningFcn(hObject, ~, handles, varargin)
% Choose default command line output for Gielis2d
handles.output = hObject;

% Ensure defaults only if fields are empty/invalid
handles = ensureDefaults(handles);

% Update handles structure
guidata(hObject, handles);

% First automatic render at startup
renderNow(handles, hObject);


function varargout = Gielis2d_OutputFcn(~, ~, handles)
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit11_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit12_CreateFcn(hObject, ~, ~) %#ok<*DEFNU>
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Parameter callbacks (auto-render after validation)
function edit7_Callback(hObject, ~, ~)
checkparameter(hObject,1)
autoRenderFromControl(hObject)

function edit8_Callback(hObject, ~, ~)
checkparameter(hObject,2)
autoRenderFromControl(hObject)

function edit9_Callback(hObject, ~, ~)
checkparameter(hObject,3)
autoRenderFromControl(hObject)

function edit10_Callback(hObject, ~, ~)
checkparameter(hObject,4)
autoRenderFromControl(hObject)

function edit11_Callback(hObject, ~, ~)
checkparameter(hObject,5)
autoRenderFromControl(hObject)

function edit12_Callback(hObject, ~, ~)
checkparameter(hObject,6)
autoRenderFromControl(hObject)


% --- Plot type radiobuttons (mutual exclusion + auto-render)
function radiobutton7_Callback(hObject, ~, handles)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(hObject,'Value',1)
autoRender(handles, hObject)

function radiobutton8_Callback(hObject, ~, handles)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton9,'Value',0)
set(hObject,'Value',1)
autoRender(handles, hObject)

function radiobutton9_Callback(hObject, ~, handles)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton7,'Value',0)
set(hObject,'Value',1)
autoRender(handles, hObject)


% --- Curve type radiobuttons (mutual exclusion + auto-render)
function radiobutton10_Callback(hObject, ~, handles)
set(handles.radiobutton11,'Value',0)
set(handles.radiobutton12,'Value',0)
set(hObject,'Value',1)
autoRender(handles, hObject)

function radiobutton11_Callback(hObject, ~, handles)
set(handles.radiobutton10,'Value',0)
set(handles.radiobutton12,'Value',0)
set(hObject,'Value',1)
autoRender(handles, hObject)

function radiobutton12_Callback(hObject, ~, handles)
set(handles.radiobutton11,'Value',0)
set(handles.radiobutton10,'Value',0)
set(hObject,'Value',1)
autoRender(handles, hObject)

% --- Core render routine
function renderNow(handles, hObject)

% Read parameters
a  = str2double(get(handles.edit7,'String'));
b  = str2double(get(handles.edit8,'String'));
m  = str2double(get(handles.edit9,'String'));
n1 = str2double(get(handles.edit10,'String'));
n2 = str2double(get(handles.edit11,'String'));
n3 = str2double(get(handles.edit12,'String'));

% Safety fallback to defaults if any value is invalid
if ~isfinite(a)  || a==0,  a=1;  set(handles.edit7,'String','1'); end
if ~isfinite(b)  || b==0,  b=1;  set(handles.edit8,'String','1'); end
if ~isfinite(m),        m=0;  set(handles.edit9,'String','0'); end
if ~isfinite(n1) || n1==0, n1=1; set(handles.edit10,'String','1'); end
if ~isfinite(n2),       n2=1; set(handles.edit11,'String','1'); end
if ~isfinite(n3),       n3=1; set(handles.edit12,'String','1'); end

% Rational form of m
[n,d] = rat(m);

% Curve type
if get(handles.radiobutton10,'Value')==1
    ft = 1; % superellipse
    curveName = 'Superellipse';
elseif get(handles.radiobutton11,'Value')==1
    ft = 2; % superroses
    curveName = 'Superroses';
elseif get(handles.radiobutton12,'Value')==1
    ft = 3; % superspirals
    curveName = 'Superspirals';
else
    ft = 1;
    curveName = 'Superellipse';
    set(handles.radiobutton10,'Value',1)
    set(handles.radiobutton11,'Value',0)
    set(handles.radiobutton12,'Value',0)
end

switch ft
    case 1
        % select the upper bound of theta
        if mod(n,2)==0 || (a==b && n2==n3)
            u = 2*d;
        else
            u = 4*d;
        end
        theta  = linspace(0, u*pi, 500*u);
        ftheta = ones(size(theta));
    case 2
        u = 4*d;
        theta  = linspace(0, u*pi, 500*u);
        ftheta = cos(2.5.*theta);
    case 3
        theta  = linspace(0, 8*pi, 5000);
        ftheta = exp(0.1.*theta);
end

rho = ftheta .* ...
    (abs(cos(m.*theta./4)./a).^n2 + abs(sin(m.*theta./4)./b).^n3).^(-1/n1);

% Plot type
if get(handles.radiobutton7,'Value')==1
    dr = 1; % polar
    plotName = 'Polar';
elseif get(handles.radiobutton8,'Value')==1
    dr = 2; % XY
    plotName = 'XY';
elseif get(handles.radiobutton9,'Value')==1
    dr = 3; % comet
    plotName = 'Comet';
else
    dr = 1;
    plotName = 'Polar';
    set(handles.radiobutton7,'Value',1)
    set(handles.radiobutton8,'Value',0)
    set(handles.radiobutton9,'Value',0)
end

% Target axes (as specified by the .fig)
ax = handles.axes2;
axes(ax);
cla(ax);

% If a previous polaraxes exists, hide it by default
if isfield(handles,'pax2') && isgraphics(handles.pax2)
    try
        set(handles.pax2,'Visible','off');
    catch
    end
end

switch dr
    case 1
        % POLAR PLOT (modern replacement for deprecated polar)
        parentFig = ancestor(ax,'figure');
        axUnits = get(ax,'Units');
        axPos   = get(ax,'Position');

        if ~isfield(handles,'pax2') || ~isgraphics(handles.pax2) || ...
                ~isa(handles.pax2,'matlab.graphics.axis.PolarAxes')
            handles.pax2 = polaraxes('Parent', parentFig);
        end

        try
            set(handles.pax2,'Units',axUnits,'Position',axPos);
        catch
        end

        try
            set(handles.pax2,'Color','none','Visible','on');
        catch
        end

        cla(handles.pax2);
        polarplot(handles.pax2, theta, rho, 'LineWidth', 1.2);

        title(handles.pax2, ['Gielis 2D - ' curveName ' / ' plotName]);

    case 2
        % XY PLOT
        if isfield(handles,'pax2') && isgraphics(handles.pax2)
            try, cla(handles.pax2); set(handles.pax2,'Visible','off'); end
        end

        [x,y] = pol2cart(theta, rho);
        plot(ax, x, y, 'LineWidth', 1.2);
        axis(ax, 'equal');
        axis(ax, 'tight');

        title(ax, ['Gielis 2D - ' curveName ' / ' plotName]);

    case 3
        % COMET PLOT
        if isfield(handles,'pax2') && isgraphics(handles.pax2)
            try, cla(handles.pax2); set(handles.pax2,'Visible','off'); end
        end

        [x,y] = pol2cart(theta, rho);
        comet(ax, x, y);
        axis(ax, 'equal');
        axis(ax, 'tight');

        title(ax, ['Gielis 2D - ' curveName ' / ' plotName]);
end

% Update handles structure
handles.output = hObject;
guidata(hObject, handles);


% --- Auto-render helper when we already have handles
function autoRender(handles, hObject)
if isempty(handles) || ~isstruct(handles)
    try
        handles = guidata(hObject);
    catch
        return
    end
end
renderNow(handles, handles.output);


% --- Auto-render helper for edit callbacks (retrieve handles safely)
function autoRenderFromControl(hObject)
try
    hFig = ancestor(hObject,'figure');
    handles = guidata(hFig);
    renderNow(handles, handles.output);
catch
    % ignore if GUI is not fully initialized
end


% --- Ensure defaults only if GUI fields are empty/invalid
function handles = ensureDefaults(handles)

% Parameter defaults
def = {'1','1','0','1','1','1'};
ed  = {'edit7','edit8','edit9','edit10','edit11','edit12'};

for i = 1:numel(ed)
    if isfield(handles, ed{i}) && isgraphics(handles.(ed{i}))
        s = get(handles.(ed{i}), 'String');
        v = str2double(s);
        if isempty(s) || (ischar(s) && isempty(strtrim(s))) || ~isfinite(v) || isnan(v)
            set(handles.(ed{i}), 'String', def{i});
        end
    end
end

% Enforce non-zero defaults for A, B, N1 if they were set to 0
if isfield(handles,'edit7') && isgraphics(handles.edit7)
    if str2double(get(handles.edit7,'String')) == 0
        set(handles.edit7,'String','1');
    end
end
if isfield(handles,'edit8') && isgraphics(handles.edit8)
    if str2double(get(handles.edit8,'String')) == 0
        set(handles.edit8,'String','1');
    end
end
if isfield(handles,'edit10') && isgraphics(handles.edit10)
    if str2double(get(handles.edit10,'String')) == 0
        set(handles.edit10,'String','1');
    end
end

% Default selections if none is active
% Plot type defaults to polar (radiobutton7)
if isfield(handles,'radiobutton7') && isfield(handles,'radiobutton8') && isfield(handles,'radiobutton9')
    v7 = get(handles.radiobutton7,'Value');
    v8 = get(handles.radiobutton8,'Value');
    v9 = get(handles.radiobutton9,'Value');
    if ~(v7 || v8 || v9)
        set(handles.radiobutton7,'Value',1)
        set(handles.radiobutton8,'Value',0)
        set(handles.radiobutton9,'Value',0)
    end
end

% Curve type defaults to superellipse (radiobutton10)
if isfield(handles,'radiobutton10') && isfield(handles,'radiobutton11') && isfield(handles,'radiobutton12')
    v10 = get(handles.radiobutton10,'Value');
    v11 = get(handles.radiobutton11,'Value');
    v12 = get(handles.radiobutton12,'Value');
    if ~(v10 || v11 || v12)
        set(handles.radiobutton10,'Value',1)
        set(handles.radiobutton11,'Value',0)
        set(handles.radiobutton12,'Value',0)
    end
end


% --- Parameter validation (legacy logic preserved)
function checkparameter(hObject,flag)
tmp = str2double(get(hObject,'String')); % get value of the text control
p = {'A' 'B' 'M' 'N1' 'N2' 'N3'};

if ismember(flag,[1 2 4])
    validation = @(x) isnumeric(x) && isreal(x) && isfinite(x) && ...
        ~isnan(x) && ~isempty(x) && (x ~= 0);
    txt = strcat(p{flag},' parameter must be a real, finite and ~=0 number');
    def = '1';
else
    validation = @(x) isnumeric(x) && isreal(x) && isfinite(x) && ...
        ~isnan(x) && ~isempty(x);
    txt = strcat(p{flag},' parameter must be a real and finite number');
    def = '0';
end

if ~validation(tmp)
    errordlg(txt,'Error','modal');
    set(hObject, 'String', def);
    uicontrol(hObject)
end
return
