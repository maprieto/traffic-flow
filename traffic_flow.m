function varargout = traffic_flow(varargin)
% TRAFFIC_FLOW M-file for traffic_flow.fig
%      TRAFFIC_FLOW, by itself, creates a new TRAFFIC_FLOW or raises the existing
%      singleton*.
%
%      H = TRAFFIC_FLOW returns the handle to a new TRAFFIC_FLOW or the handle to
%      the existing singleton*.
%
%      TRAFFIC_FLOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAFFIC_FLOW.M with the given input arguments.
%
%      TRAFFIC_FLOW('Property','Value',...) creates a new TRAFFIC_FLOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before traffic_flow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to traffic_flow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help traffic_flow

% Last Modified by GUIDE v2.5 17-Nov-2014 19:55:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @traffic_flow_OpeningFcn, ...
                   'gui_OutputFcn',  @traffic_flow_OutputFcn, ...
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


% --- Executes just before traffic_flow is made visible.
function traffic_flow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to traffic_flow (see VARARGIN)

% Choose default command line output for traffic_flow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes traffic_flow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = traffic_flow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rhom=str2double(get(handles.edit5,'String'));
um=str2double(get(handles.edit6,'String'));
cfl=str2double(get(handles.edit4,'String'));
T=str2double(get(handles.edit1,'String'));
N=str2double(get(handles.edit3,'String'));
initial_data=get(handles.edit7,'String');
if(get(handles.uipanel8,'UserData')==1)
    godunov_compute=@godunov_mod;
else
    godunov_compute=@godunov;
end
traffic_compute(N,T,cfl,rhom,um,godunov_compute,initial_data,handles)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1)


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
rhom=str2double(get(handles.edit5,'String'));
um=str2double(get(handles.edit6,'String'));
cfl=str2double(get(handles.edit4,'String'));
T=str2double(get(handles.edit1,'String'));
N=str2double(get(handles.edit3,'String'));
initial_data=get(handles.edit7,'String');
if(exist(initial_data,'file')==2)
    load(initial_data,'rho0')
else
    rho0=nan;
end

if(rhom>0 && um>0 && T>0 && N>0 && cfl>0 && all(rhom>=1000*rho0))
    set(handles.pushbutton2,'Enable','on')
else
    set(handles.pushbutton2,'Enable','off')
end

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
rhom=str2double(get(handles.edit5,'String'));
um=str2double(get(handles.edit6,'String'));
cfl=str2double(get(handles.edit4,'String'));
T=str2double(get(handles.edit1,'String'));
N=str2double(get(handles.edit3,'String'));
initial_data=get(handles.edit7,'String');
if(exist(initial_data,'file')==2)
    load(initial_data,'rho0')
else
    rho0=nan;
end

if(rhom>0 && um>0 && T>0 && N>0 && cfl>0 && all(rhom>=1000*rho0))
    set(handles.pushbutton2,'Enable','on')
else
    set(handles.pushbutton2,'Enable','off')
end

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile('*.mat', 'Select a MAT-file');
if(filename~=0)
    set(handles.edit7,'String',filename);
end
rhom=str2double(get(handles.edit5,'String'));
um=str2double(get(handles.edit6,'String'));
cfl=str2double(get(handles.edit4,'String'));
T=str2double(get(handles.edit1,'String'));
N=str2double(get(handles.edit3,'String'));
initial_data=get(handles.edit7,'String');
if(exist(initial_data,'file')==2)
    load(initial_data,'rho0')
else
    rho0=nan;
end

if(rhom>0 && um>0 && T>0 && N>0 && cfl>0 && all(rhom>=1000*rho0))
    set(handles.pushbutton2,'Enable','on')
else
    set(handles.pushbutton2,'Enable','off')
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
rhom=str2double(get(handles.edit5,'String'));
um=str2double(get(handles.edit6,'String'));
cfl=str2double(get(handles.edit4,'String'));
T=str2double(get(handles.edit1,'String'));
N=str2double(get(handles.edit3,'String'));
initial_data=get(handles.edit7,'String');
if(exist(initial_data,'file')==2)
    load(initial_data,'rho0')
else
    rho0=nan;
end

if(rhom>0 && um>0 && T>0 && N>0 && cfl>0 && all(rhom>=1000*rho0))
    set(handles.pushbutton2,'Enable','on')
else
    set(handles.pushbutton2,'Enable','off')
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
rhom=str2double(get(handles.edit5,'String'));
um=str2double(get(handles.edit6,'String'));
cfl=str2double(get(handles.edit4,'String'));
T=str2double(get(handles.edit1,'String'));
N=str2double(get(handles.edit3,'String'));
initial_data=get(handles.edit7,'String');
if(exist(initial_data,'file')==2)
    load(initial_data,'rho0')
else
    rho0=nan;
end

if(rhom>0 && um>0 && T>0 && N>0 && cfl>0 && all(rhom>=1000*rho0))
    set(handles.pushbutton2,'Enable','on')
else
    set(handles.pushbutton2,'Enable','off')
end

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
rhom=str2double(get(handles.edit5,'String'));
um=str2double(get(handles.edit6,'String'));
cfl=str2double(get(handles.edit4,'String'));
T=str2double(get(handles.edit1,'String'));
N=str2double(get(handles.edit3,'String'));
initial_data=get(handles.edit7,'String');
if(exist(initial_data,'file')==2)
    load(initial_data,'rho0')
else
    rho0=nan;
end

if(rhom>0 && um>0 && T>0 && N>0 && cfl>0 && all(rhom>=1000*rho0))
    set(handles.pushbutton2,'Enable','on')
else
    set(handles.pushbutton2,'Enable','off')
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
rhom=str2double(get(handles.edit5,'String'));
um=str2double(get(handles.edit6,'String'));
cfl=str2double(get(handles.edit4,'String'));
T=str2double(get(handles.edit1,'String'));
N=str2double(get(handles.edit3,'String'));
initial_data=get(handles.edit7,'String');
if(exist(initial_data,'file')==2)
    load(initial_data,'rho0')
else
    rho0=nan;
end

if(rhom>0 && um>0 && T>0 && N>0 && cfl>0 && all(rhom>=1000*rho0))
    set(handles.pushbutton2,'Enable','on')
else
    set(handles.pushbutton2,'Enable','off')
end

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel8.
function uipanel8_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel8 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if(eventdata.NewValue==handles.radiobutton1)
    set(handles.uipanel8,'UserData',1)
else
    set(handles.uipanel8,'UserData',2)
end
