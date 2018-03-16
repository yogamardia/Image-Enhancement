function varargout = enhance(varargin)
% ENHANCE MATLAB code for enhance.fig
%      ENHANCE, by itself, creates a new ENHANCE or raises the existing
%      singleton*.
%
%      H = ENHANCE returns the handle to a new ENHANCE or the handle to
%      the existing singleton*.
%
%      ENHANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENHANCE.M with the given input arguments.
%
%      ENHANCE('Property','Value',...) creates a new ENHANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before enhance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to enhance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help enhance

% Last Modified by GUIDE v2.5 16-Mar-2018 07:52:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @enhance_OpeningFcn, ...
                   'gui_OutputFcn',  @enhance_OutputFcn, ...
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


% --- Executes just before enhance is made visible.
function enhance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to enhance (see VARARGIN)

% Choose default command line output for enhance
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes enhance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = enhance_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse_btn.
function browse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to browse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
[nama_file, nama_path] = uigetfile('*.png;*.jpg;*.bmp;*.gif','Select Image');
if ~isequal (nama_file,0)
    a = imread(fullfile(nama_path,nama_file));
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(a);
else
    return;
end


% --- Executes on button press in grayscale_btn.
function grayscale_btn_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a;
global gray;
gray = rgb2gray(a);

axes(handles.axes2);
imshow(gray);


% --- Executes on button press in bin_btn.
function bin_btn_Callback(hObject, eventdata, handles)
% hObject    handle to bin_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gray;
bin = imbinarize(gray);

axes(handles.axes3);
imshow(bin);

% --- Executes on button press in exit_btn.
function exit_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close()


% --- Executes on button press in noise_btn.
function noise_btn_Callback(hObject, eventdata, handles)
% hObject    handle to noise_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gray;
global noise;

noise = imnoise(gray,'salt & pepper');
axes(handles.axes4);
imshow(noise);


% --- Executes on button press in lpf3.
function lpf3_Callback(hObject, eventdata, handles)
% hObject    handle to lpf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lpf3
global noise;

f = ones(3,3)/9;
disp(f)
fimage = conv2(noise,f);
axes(handles.axes5);
imshow(uint8(fimage));


% --- Executes on button press in lpf5.
function lpf5_Callback(hObject, eventdata, handles)
% hObject    handle to lpf5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lpf5
global noise;

f = ones(5,5)/25;
disp(f)
fimage = conv2(noise,f);
axes(handles.axes5);
imshow(uint8(fimage));


% --- Executes on button press in lpf7.
function lpf7_Callback(hObject, eventdata, handles)
% hObject    handle to lpf7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lpf7
global noise;

f = ones(7,7)/49;
disp(f)
fimage = conv2(noise,f);
axes(handles.axes5);
imshow(uint8(fimage));


% --- Executes on button press in lpf9.
function lpf9_Callback(hObject, eventdata, handles)
% hObject    handle to lpf9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lpf9
global noise;

f = ones(9,9)/81;
disp(f)
fimage = filter2(f,noise,'same');
axes(handles.axes5);
imshow(fimage/255);


% --- Executes on button press in hpf3.
function hpf3_Callback(hObject, eventdata, handles)
% hObject    handle to hpf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hpf3
global noise;

f = -1 * ones(3,3);
f(2,2) = 8;
disp(f)
fimage = conv2(noise, f);
axes(handles.axes5);
imshow(uint8(fimage));


% --- Executes on button press in hpf5.
function hpf5_Callback(hObject, eventdata, handles)
% hObject    handle to hpf5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hpf5
global noise;

f = -1 * ones(5,5);
f(3,3) = 8;
disp(f)
fimage = conv2(noise, f);
axes(handles.axes5);
imshow(uint8(fimage));


% --- Executes on button press in hpf7.
function hpf7_Callback(hObject, eventdata, handles)
% hObject    handle to hpf7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hpf7
global noise;

f = -1 * ones(7,7);
f(4,4) = 8;
disp(f)
fimage = conv2(noise, f);
axes(handles.axes5);
imshow(uint8(fimage));


% --- Executes on button press in hpf9.
function hpf9_Callback(hObject, eventdata, handles)
% hObject    handle to hpf9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hpf9
global noise;

f = -1 * ones(9,9);
f(5,5) = 8;
disp(f)
fimage = conv2(noise, f);
axes(handles.axes5);
imshow(uint8(fimage));