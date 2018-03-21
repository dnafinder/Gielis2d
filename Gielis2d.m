function varargout = Gielis2d(varargin)
% The superformula is a generalization of the superellipse and was first
% proposed by Johan Gielis.
% 
% Gielis suggested that the formula can be used to describe many complex
% shapes and curves that are found in nature. Others point out that the
% same can be said about many formulas with a sufficient number of
% parameters.
% Gielis, Johan (2003), "A generic geometric transformation that unifies a
% wide range of natural and abstract shapes", American Journal of Botany 90(3): 333-338, 
% 
%           Created by Giuseppe Cardillo
%           giuseppe.cardillo-edta@poste.it
%
% To cite this file, this would be an appropriate format:
% Cardillo G. (2006). Superformula Generator 2d: a GUI interface to trace a
% 2d plot of the parametric Gielis Superformula.
% http://www.mathworks.com/matlabcentral/fileexchange/10189

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT

% --- Executes just before Gielis2d is made visible.
function Gielis2d_OpeningFcn(hObject, ~, handles, varargin)
% Choose default command line output for Gielis2d
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

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

function edit7_Callback(hObject, ~, ~)
checkparameter(hObject,1)

function edit8_Callback(hObject, ~, ~)
checkparameter(hObject,2)

function edit9_Callback(hObject, ~, ~)
checkparameter(hObject,3)

function edit10_Callback(hObject, ~, ~)
checkparameter(hObject,4)

function edit11_Callback(hObject, ~, ~)
checkparameter(hObject,5)

function edit12_Callback(hObject, ~, ~)
checkparameter(hObject,6)

function radiobutton7_Callback(~, ~, handles)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)

function radiobutton8_Callback(~, ~, handles)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton9,'Value',0)

function radiobutton9_Callback(~, ~, handles)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton7,'Value',0)

function radiobutton10_Callback(~, ~, handles)
set(handles.radiobutton11,'Value',0)
set(handles.radiobutton12,'Value',0)

function radiobutton11_Callback(~, ~, handles)
set(handles.radiobutton10,'Value',0)
set(handles.radiobutton12,'Value',0)

function radiobutton12_Callback(~, ~, handles)
set(handles.radiobutton11,'Value',0)
set(handles.radiobutton10,'Value',0)

function pushbutton2_KeyPressFcn(~, eventdata, handles)
if strcmp(eventdata.Key,'return')
   pushbutton2_Callback([], [], handles)
end

function pushbutton2_Callback(~, ~, handles)
a=str2double(get(handles.edit7,'String'));
b=str2double(get(handles.edit8,'String'));
m=str2double(get(handles.edit9,'String'));
n1=str2double(get(handles.edit10,'String'));
n2=str2double(get(handles.edit11,'String'));
n3=str2double(get(handles.edit12,'String'));
[n,d]=rat(m); %rational form of m
if get(handles.radiobutton10,'Value')==1
    ft=1;
elseif get(handles.radiobutton11,'Value')==1
    ft=2;
elseif get(handles.radiobutton12,'Value')==1
    ft=3;
end
switch ft
    case 1
        %select the upper bound of theta
        if mod(n,2)==0 || (a==b && n2==n3) 
            u=2*d;
        else
            u=4*d;
        end
        theta=linspace(0,u*pi,500*u);
        ftheta=ones(size(theta));
    case 2
        u=4.*d;
        theta=linspace(0,u*pi,500*u);
        ftheta=cos(2.5.*theta);
    case 3
        theta=linspace(0,8*pi,5000);
        ftheta=exp(0.1.*theta);
end
rho=ftheta.*(abs(cos(m.*theta./4)./a).^n2+abs(sin(m.*theta./4)./b).^n3).^(-1/n1);

%select the plot
if get(handles.radiobutton7,'Value')==1
    dr=1;
elseif get(handles.radiobutton8,'Value')==1
    dr=2;
elseif get(handles.radiobutton9,'Value')==1
    dr=3;
end

switch dr
    case 1
        polar(theta,rho)
    case 2
        [x,y]=pol2cart(theta,rho);
        plot(x,y)
        axis equal
    case 3
        [x,y]=pol2cart(theta,rho);
        axis equal
        comet(x,y)
end

function checkparameter(hObject,flag)
tmp=str2double(get(hObject,'String')); %get value of the text control
p={'A' 'B' 'M' 'N1' 'N2' 'N3'};
if ismember(flag,[1 2 4])
    validation=@(x) isnumeric(x) && isreal (x) && isfinite(x) && ~isnan(x) && ~isempty(x) && (x ~= 0);
    txt=strcat(p{flag},' parameter must be a real, finite and ~=0 number');
    def='1';
else
    validation=@(x) isnumeric(x) && isreal (x) && isfinite(x) && ~isnan(x) && ~isempty(x);
    txt=strcat(p{flag},' parameter must be a real and finite number');
    def='0';
end
if ~validation(tmp) %if is not a valid number...
    errordlg(txt,'Error','modal'); %set the default value in text control
    set(hObject, 'String', def); %and in the parameter array
    uicontrol(hObject)
end
return
