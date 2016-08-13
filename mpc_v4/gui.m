%Author: Anton Pytel
%improvement of algorithm written by Elling W. Jacobsen, S3-Reglerteknik 050222 

function varargout = gui(varargin)
% GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 25-Apr-2013 11:31:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function tfn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tfn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tfn_Callback(hObject, eventdata, handles)
% hObject    handle to tfn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tfn as text
%        str2double(get(hObject,'String')) returns contents of tfn as a double
% density = str2double(get(hObject, 'String'));
% if isnan(density)
%     set(hObject, 'String', 0);
%     errordlg('Input must be a number','Error');
% end

% Save the new tfn value
% handles.metricdata.density = density;
% guidata(hObject,handles)

s=tf('s');
G = (get(hObject, 'String'));
if isnan(G)
    set(hObject, 'String', 0);
    errordlg('System zadany v nespravnom tvare','Error');
end

handles.system.G = G;
guidata(hObject,handles)




% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volume as text
%        str2double(get(hObject,'String')) returns contents of volume as a double
% volume = str2double(get(hObject, 'String'));
% if isnan(volume)
%     set(hObject, 'String', 0);
%     errordlg('Input must be a number','Error');
% end
% 
% % Save the new volume value
% handles.metricdata.volume = volume;
% guidata(hObject,handles)


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
% if isfield(handles, 'system') && ~isreset
%     return;
% end
% if isfield(handles, 'params') && ~isreset
%     return;
% end
% if isfield(handles, 'constr') && ~isreset
%     return;
% end
% if isfield(handles, 'simulation') && ~isreset
%     return;
% end
% 
% handles.system.G = 0;
% handles.system.T = 0;

% handles.metricdata.tfn = 0;
% handles.metricdata.volume  = 0;
% 
% set(handles.tfn, 'String', handles.metricdata.density);
% 
% set(handles.mass, 'String', 0);
% 
% set(handles.unitgroup, 'SelectedObject', handles.english);
% 
% set(handles.text4, 'String', 'lb/cu.in');
% set(handles.text5, 'String', 'cu.in');
% set(handles.text6, 'String', 'lb');

% Update handles structure
guidata(handles.figure1, handles);



function ymax_Callback(hObject, eventdata, handles)
% hObject    handle to ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymax as text
%        str2double(get(hObject,'String')) returns contents of ymax as a double


% --- Executes during object creation, after setting all properties.
function ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymin_Callback(hObject, eventdata, handles)
% hObject    handle to ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymin as text
%        str2double(get(hObject,'String')) returns contents of ymin as a double


% --- Executes during object creation, after setting all properties.
function ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function umax_Callback(hObject, eventdata, handles)
% hObject    handle to umax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umax as text
%        str2double(get(hObject,'String')) returns contents of umax as a double


% --- Executes during object creation, after setting all properties.
function umax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function umin_Callback(hObject, eventdata, handles)
% hObject    handle to umin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umin as text
%        str2double(get(hObject,'String')) returns contents of umin as a double


% --- Executes during object creation, after setting all properties.
function umin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Np_Callback(hObject, eventdata, handles)
% hObject    handle to Np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Np as text
%        str2double(get(hObject,'String')) returns contents of Np as a double


% --- Executes during object creation, after setting all properties.
function Np_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Qy_Callback(hObject, eventdata, handles)
% hObject    handle to Qy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Qy as text
%        str2double(get(hObject,'String')) returns contents of Qy as a double


% --- Executes during object creation, after setting all properties.
function Qy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Qy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sy_Callback(hObject, eventdata, handles)
% hObject    handle to Sy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sy as text
%        str2double(get(hObject,'String')) returns contents of Sy as a double


% --- Executes during object creation, after setting all properties.
function Sy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Qu_Callback(hObject, eventdata, handles)
% hObject    handle to Qu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Qu as text
%        str2double(get(hObject,'String')) returns contents of Qu as a double


% --- Executes during object creation, after setting all properties.
function Qu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Qu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tvz_Callback(hObject, eventdata, handles)
% hObject    handle to Tvz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tvz as text
%        str2double(get(hObject,'String')) returns contents of Tvz as a double


% --- Executes during object creation, after setting all properties.
function Tvz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tvz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sim_len_Callback(hObject, eventdata, handles)
% hObject    handle to sim_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sim_len as text
%        str2double(get(hObject,'String')) returns contents of sim_len as a double


% --- Executes during object creation, after setting all properties.
function sim_len_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sim_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_signal_Callback(hObject, eventdata, handles)
% hObject    handle to ref_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_signal as text
%        str2double(get(hObject,'String')) returns contents of ref_signal as a double


% --- Executes during object creation, after setting all properties.
function ref_signal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dumax_Callback(hObject, eventdata, handles)
% hObject    handle to dumax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dumax as text
%        str2double(get(hObject,'String')) returns contents of dumax as a double


% --- Executes during object creation, after setting all properties.
function dumax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dumax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dumin_Callback(hObject, eventdata, handles)
% hObject    handle to dumin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dumin as text
%        str2double(get(hObject,'String')) returns contents of dumin as a double


% --- Executes during object creation, after setting all properties.
function dumin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dumin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_delay_Callback(hObject, eventdata, handles)
% hObject    handle to input_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_delay as text
%        str2double(get(hObject,'String')) returns contents of input_delay as a double


% --- Executes during object creation, after setting all properties.
function input_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in show_step.
function show_step_Callback(hObject, eventdata, handles)
% hObject    handle to show_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_step

function dymax_Callback(hObject, eventdata, handles)
% hObject    handle to dymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dymax as text
%        str2double(get(hObject,'String')) returns contents of dymax as a double


% --- Executes during object creation, after setting all properties.
function dymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dymin_Callback(hObject, eventdata, handles)
% hObject    handle to dymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dymin as text
%        str2double(get(hObject,'String')) returns contents of dymin as a double


% --- Executes during object creation, after setting all properties.
function dymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in examples.
function examples_Callback(hObject, eventdata, handles)
% hObject    handle to examples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns examples contents as cell array
%        contents{get(hObject,'Value')} returns selected item from examples


popup_sel_index = get(handles.examples, 'Value');
switch popup_sel_index
    case 1
        set(handles.tfn, 'String', '1/(s*(s+1))');
        set(handles.Tvz, 'String',0.1);
        set(handles.input_delay, 'String',0.5);
    case 2
        set(handles.tfn, 'String', '1/(s^2 + 2*s + 1)');
        set(handles.Tvz, 'String',0.1);
        set(handles.input_delay, 'String',0.5);
    case 3
        set(handles.tfn, 'String', '1/(s^2 + s + 2)');
        set(handles.Tvz, 'String',0.1);
        set(handles.input_delay, 'String',0.5);
    case 4
        set(handles.tfn, 'String', '1/(s^2 + s + 0.4)');
        set(handles.Tvz, 'String',0.1);
        set(handles.input_delay, 'String',0.5);
    case 5 %start up
        set(handles.tfn, 'String', '((z^-1*(1.04 + 0.23 * z^-1)))/((1-0.99*z^-1)*(1-5.1e-3*z^-1))');
        set(handles.Tvz, 'String',0.25);
        set(handles.input_delay, 'String',0);
    case 6 %Idle
        set(handles.tfn, 'String', '((z^-1*(1.29 + 0.28 * z^-1)))/((1-0.99*z^-1)*(1-4.6e-3*z^-1))');
        set(handles.Tvz, 'String',0.25);
        set(handles.input_delay, 'String',0);
    case 7 %Midway
        set(handles.tfn, 'String', '((z^-1*(2.085 + 0.3692 * z^-1)))/((1-0.99*z^-1)*(1-1.3e-3*z^-1))');
        set(handles.Tvz, 'String',0.25);
        set(handles.input_delay, 'String',0);
   case 8 %Max
        set(handles.tfn, 'String', '((z^-1*(1.68 + 0.1 * z^-1)))/((1-0.99*z^-1)*(1-4.3e-3*z^-1))');
        set(handles.Tvz, 'String',0.25);
        set(handles.input_delay, 'String',0);

end
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function examples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to examples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simulate.
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('start')
%T=0.1; % sampling time
T = str2double(get(handles.Tvz, 'String'));
if T == 0 
    disp('Perioda vzorkovania nemoze byt 0');
    return
end

%input delay
Delay = str2double(get(handles.input_delay, 'String'));

% oneskorenie (s)
%---------------- = pocet vzoriek o ktore oneskoreit
%  perioda vz (s)

inp_del = Delay/T;

if mod(inp_del,1) || inp_del == 1
    disp('Perioda vzorkovania musi byt zvolena tak, aby bolo dopravne oneskorenie jej celociselnym N nasobkom, (kde N>1)');
    return;
end

%G=1/(s*(s+1));
if length(findstr(get(handles.tfn, 'String'),'s')) > 0     
    s=tf('s');
    G = eval(get(handles.tfn, 'String'));
    % system
    [a,b,c,d]=ssdata(G); %G - transfer funcion, a,b,c,d state space parameters

    % Temporary data to compare with inputdelay
    %Gd1=c2d(G, T)
    %[a1,b1,c1,d1]=ssdata(Gd1);
    % figure;
    % step(Gd1)

    % oneskorenie
    G = ss(a,b,c,d,'inputdelay',Delay);

    % cont. to discr.
    Gd=c2d(G, T) 
    [a,b,c,d]=ssdata(Gd);
elseif length(findstr(get(handles.tfn, 'String'),'z')) > 0
    z=tf('z',T);
    G = eval(get(handles.tfn, 'String'));
    [a,b,c,d]=ssdata(G);
    Gd = ss(a,b,c,d,T,'inputdelay',inp_del);
    [a,b,c,d]=ssdata(Gd);
else
    disp('Wrong format of system');
end

%zobrazenie step-u
if get(handles.show_step, 'Value') == 1 
    figure;
    step(Gd);
end


% Weightings:
%Qy=1.0; 
Qy = str2double(get(handles.Qy, 'String'));
Qx=c'*Qy*c;   % Output weight -> state weight for 1<i<Np-1;
%Sy=1.0; 
Sy = str2double(get(handles.Sy, 'String'));
S=c'*Sy*c;    % Terminal weight at i=Np

Qu = str2double(get(handles.Qu, 'String'));
%Qu=.01;              % Input weight for 0<i<Np-1

% Constraints (implemented as hard here):
umin=str2double(get(handles.umin, 'String')); 
umax=str2double(get(handles.umax, 'String'));
dumin=str2double(get(handles.dumin, 'String')); 
dumax=str2double(get(handles.dumax, 'String'));
ymin=str2double(get(handles.ymin, 'String'));
ymax=str2double(get(handles.ymax, 'String'));
dymin=str2double(get(handles.dymax, 'String'));
dymax=str2double(get(handles.dymax, 'String'));

% Horizon is Np (both for objective function and for constraints);
%Np=10;
Np = str2double(get(handles.Np, 'String'));

% % References for outputs, states and inputs:
% yref=1*ones(Np,1);     % Reference for 0<i<Np-1
% xref=pinv(c)*yref(1);  % Translate into state reference:
% for i=2:length(yref),
% xref=[xref;pinv(c)*yref(i)];
% end
% uref=zeros(Np,1);      % Input reference is here assumed zero 


%%%%%%%%%%%%% CHANGE PARAMETERS ABOVE THIS LINE.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Compute mapping from present (initial) state, Ahat, and future inputs, Bhat,
% to future states: x_future=Ahat*x0+Bhat*u_future
nx=length(a);[ny,nu]=size(d);
Ahat=a;Bhat=[b zeros(length(b),Np-1)];
for i=2:Np,
    Ahat=[Ahat;a^i];
    for j=1:Np,
        if (i-j)>-1,
            Bhat_n(:,j)=a^(i-j)*b;
        else
            Bhat_n(:,j)=0*b;
        end
    end
    Bhat=[Bhat;Bhat_n];
end

% Stack up state and output weights in block-diagonal matrices to
% replace summing in objective function by matrix multiplication in QP:
Qhat=[Qx zeros(nx,nx*(Np-1))];
Quhat=[Qu zeros(nu,nu*(Np-1))];
for i=2:Np,
    if i==Np,
        % weight on terminal state (1st sample after optimization horizon)
        Qx=S;
    end
    Qhat_n=[zeros(nx,nx*(i-1)) Qx zeros(nx,nx*(Np-i))];
    Quhat_n=[zeros(nu,nu*(i-1)) Qu zeros(nu,nu*(Np-i))];
    Qhat=[Qhat;Qhat_n];
    Quhat=[Quhat;Quhat_n];
end

% Constraints on states in matrix form: y_min<Hhat*x<y_max
H=c;
Hhat=[c zeros(ny,nx*(Np-1))];
for i=2:Np,
Hhat_n=[zeros(ny,nx*(i-1)) H zeros(ny,nx*(Np-i))];
Hhat=[Hhat;Hhat_n];
end
% a
% b
% c
% d
% Ahat
% Bhat
% Qhat
% Quhat
% Hhat


x0=zeros(nx,1); % First state value is zero:
x00=zeros(nx,1); % initialize previous state
u0=zeros(nu,1); % Prvy akcny zasah
NN=ceil(str2double(get(handles.sim_len, 'String'))/T); % Simulate NN samples:

warning('off');% Turn off warnings from quadprog:

% signal reference handling
yreff = [0;0];
yref_signal = eval(get(handles.ref_signal, 'String')); 
sidx = 1; %index referencneho signalu
smax = size(yref_signal,1); %max index ref. signalu
if yref_signal(sidx,1) == 0 % ak je prvy nastaveny na 0
  % tak dame hned hodnotu
  [yref,xref,uref] = mpc_get_ref(Np,c, yref_signal(1,2));  
  yreff(2) = yref(1);
  % a zvysime index
  sidx = sidx + 1;
else % inak nastavime na 0
  [yref,xref,uref] = mpc_get_ref(Np,c, 0);    
end

% Test controlling different system, than identified
% z=tf('z',0.25);
% G1 = eval('((z^-1*(1.04 + 0.23 * z^-1)))/((1-0.99*z^-1)*(1-5.1e-3*z^-1))'); %start up
% G1 = eval('((z^-1*(1.29 + 0.28 * z^-1)))/((1-0.99*z^-1)*(1-4.6e-3*z^-1))'); % idle
% G1 = eval('((z^-1*(1.68 + 0.1 * z^-1)))/((1-0.99*z^-1)*(1-4.3e-3*z^-1))'); % max
% 
% [a1,b1,c1,d1]=ssdata(G1);



for kk=1:NN,
% Calculate future Np inputs:

if  smax ~= 1
    if ceil(yref_signal(sidx,1)/T) == kk 
      [yref,xref,uref] = mpc_get_ref(Np,c, yref_signal(sidx,2));    
      if sidx < smax 
        sidx = sidx + 1;
      end
    end
end 
yreff = [ yreff; yref(1)];

[u,exitflag]=mpc_calc(Ahat,Bhat,Qhat,Quhat,Hhat,x0,x00,u0,xref,uref,umin,umax,...
                      dumin,dumax,ymin,ymax,dymin,dymax);
if exitflag<0,disp('WARNING: infeasible QP problem'),pause(0.1),end;
% Implement present input:
x=a*x0+b*u(1);
% Save states and input for plotting
U(kk)=u(1);
u0 = u(1);
X(kk,:)=x';
% save last state
x00=x0;
% New initial state for next sample
x0=x;
end

% plot time history
figure;
t=0:T:NN*T;t_f=t(length(t));t=[-1 t];
y=[0 0 c*X'];
subplot(311),
% plot(t,y,[-1 0],[0 0],'r:',[0 0],[0 yreff(1)],'r:',[0 t_f],[yreff(1) yreff(1)],...
%        'r:',[-1 t_f],[ymax ymax],'g--')
plot(t,y,[-1 t_f],[ymax ymax],'r--',[-1 t_f],[ymin ymin],'r--')
hold on
stairs(t,yreff, 'g:')
hold off


ylabel('output y')
% show +-10 percent of y
axis([-1 t_f min(y)-0.1*abs(min(y)) max(y)+0.1*abs(max(y))])
subplot(312)
U=[0 U U(length(U))];
plot([-1 t_f],[umax umax],'r--',[-1 t_f],[umin umin],'r--')
hold on
stairs(t,U)
hold off
% show +-10 percent of u
axis([-1 t_f min(U)-0.1*abs(min(U)) max(U)+0.1*abs(max(U))]) 
ylabel('input u')

dU(1) = 0;
for uu = 2: size(U,2)
    dU(uu) = U(uu)-U(uu-1);
end
subplot(313);
plot([-1 t_f],[dumax dumax],'r--',[-1 t_f],[dumin dumin],'r--')
hold on
stairs(t,dU);
hold off
% axis([-1 t_f dumin-0.2*abs(dumin) dumax+0.2*abs(dumax)])
 axis([-1 t_f min(dU)-0.1*abs(min(dU)) max(dU)+0.1*abs(max(dU))])


ylabel('input du')
xlabel('time [s]')
disp('finished');


function [u,iflag]=mpc_calc(Ahat,Bhat,Qhat,Phat,Hhat,x0,x00,u0,xref,uref,umin,umax,dumin,dumax,ymin,ymax,dymin,dymax)
% Sets up objective function and constraints for QP problem and solves.

Xdev=Ahat*x0+Bhat*uref-xref;
Xdev0=Ahat*x00+Bhat*uref-xref;

I=eye(length(uref));

duref=uref; %zeros

Lu_min=I; bu_min=umin-uref;
Lu_max=-I; bu_max=-umax+uref;

Ldu_min=I; bdu_min=dumin+u0-duref;
Ldu_max=-I; bdu_max=-dumax-u0+duref;

Lx_min=Hhat*Bhat; bx_min=ymin-Hhat*(Xdev+xref);
Lx_max=-Hhat*Bhat; bx_max=-ymax+Hhat*(Xdev+xref);

Ldx_min=Hhat*Bhat; bdx_min=dymin + Hhat*(Xdev0+xref)- Hhat*(Xdev+xref);
Ldx_max=-Hhat*Bhat; bdx_max=-dymax - Hhat*(Xdev0+xref)+ Hhat*(Xdev+xref);

L1=-[Lu_min; Lu_max; Ldu_min; Ldu_max; Lx_min; Lx_max; ]; %Ldx_min; Ldx_max
b1=-[bu_min; bu_max; bdu_min; bdu_max; bx_min; bx_max; ]; %bdx_min; bdx_max

H=Bhat'*Qhat*Bhat+Phat;
f=(Xdev'*Qhat*Bhat);
[u,J,iflag]=quadprog(H,f,L1,b1);


function [oyref,oxref,ouref]=mpc_get_ref(xNp,xc,xstep)
    % References for outputs, states and inputs:
    oyref=xstep*ones(xNp,1);     % Reference for 0<i<Np-1
    oxref=pinv(xc)*oyref(1);  % Translate into state reference:
    for i=2:length(oyref),
        oxref=[oxref;pinv(xc)*oyref(i)];
    end
    ouref=zeros(xNp,1);    




