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

% Last Modified by GUIDE v2.5 23-Mar-2018 09:40:57

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
bright_status = 0;
set(handles.brightVal, 'String', bright_status);
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
global valid;
[nama_file, nama_path] = uigetfile('*.png;*.jpg;*.bmp;*.gif','Select Image');
if ~isequal (nama_file,0)
    a = imread(fullfile(nama_path,nama_file));
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(a);
    valid = 1;
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
global algray;
global valid;
global img_b;

empty = isempty(get(handles.axes1, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else    
    gray = rgb2gray(a);
    axes(handles.axes2);
    imshow(gray);
end


% --- Executes on button press in bin_btn.
function bin_btn_Callback(hObject, eventdata, handles)
% hObject    handle to bin_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gray
empty = isempty(get(handles.axes2, 'Children'));
if (empty == 1)
    errordlg('Lakukan Proses Grayscale!','Terjadi kesalahan');
else
    bin = imbinarize(img_gray);

    axes(handles.axes3);
    imshow(bin);
end


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


empty = isempty(get(handles.axes2, 'Children'));

if (empty == 1)
    errordlg('Please Grayscale the image first...','Terjadi kesalahan');
else
    noise = imnoise(gray,'salt & pepper');
    axes(handles.axes4);
    imshow(noise);
end



% --- Executes on button press in lpf3.
function lpf3_Callback(hObject, eventdata, handles)
% hObject    handle to lpf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lpf3
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else

    f = ones(3,3)/9;
    disp(f)
    fimage = imfilter(noise, f);
    axes(handles.axes5);
    imshow(uint8(fimage));
end


% --- Executes on button press in lpf5.
function lpf5_Callback(hObject, eventdata, handles)
% hObject    handle to lpf5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lpf5
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    f = ones(5,5)/25;
    disp(f)
    fimage = imfilter(noise, f);
    axes(handles.axes5);
    imshow(uint8(fimage));
end


% --- Executes on button press in lpf7.
function lpf7_Callback(hObject, eventdata, handles)
% hObject    handle to lpf7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lpf7
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    f = ones(7,7)/49;
    disp(f)
    fimage = imfilter(noise, f);
    axes(handles.axes5);
    imshow(uint8(fimage));
end


% --- Executes on button press in lpf9.
function lpf9_Callback(hObject, eventdata, handles)
% hObject    handle to lpf9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lpf9
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    f = ones(9,9)/81;
    disp(f)
    fimage = imfilter(noise, f);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in hpf3.
function hpf3_Callback(hObject, eventdata, handles)
% hObject    handle to hpf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hpf3
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    f = -1 * ones(3,3);
    f(2,2) = 8;
    disp(f)
    fimage = imfilter(noise, f);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in hpf5.
function hpf5_Callback(hObject, eventdata, handles)
% hObject    handle to hpf5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hpf5
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    f = -1 * ones(5,5);
    f(3,3) = 24;
    disp(f)
    fimage = imfilter(noise, f);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in hpf7.
function hpf7_Callback(hObject, eventdata, handles)
% hObject    handle to hpf7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hpf7
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    f = -1 * ones(7,7);
    f(4,4) = 48;
    disp(f)
    fimage = imfilter(noise, f);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in hpf9.
function hpf9_Callback(hObject, eventdata, handles)
% hObject    handle to hpf9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hpf9
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    f = -1 * ones(9,9);
    f(5,5) = 80;
    disp(f)
    fimage = imfilter(noise, f);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in median3.
function median3_Callback(hObject, eventdata, handles)
% hObject    handle to median3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of median3
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    fimage = medfilt2(noise, [3 3]);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in median5.
function median5_Callback(hObject, eventdata, handles)
% hObject    handle to median5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of median5
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    fimage = medfilt2(noise, [5 5]);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in median7.
function median7_Callback(hObject, eventdata, handles)
% hObject    handle to median7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of median7
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    fimage = medfilt2(noise, [7 7]);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in median9.
function median9_Callback(hObject, eventdata, handles)
% hObject    handle to median9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of median9
global noise;

empty = isempty(get(handles.axes4, 'Children'));
if (empty == 1)
    errordlg('Please add noise on grayscaled image first...','Error');
else
    fimage = medfilt2(noise, [9 9]);
    axes(handles.axes5);
    imshow(uint8(fimage));
end

% --- Executes on button press in maxBright.
function maxBright_Callback(hObject, eventdata, handles)
% hObject    handle to maxBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a;
global value;

empty = isempty(get(handles.axes1, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Browse...','Terjadi kesalahan');
else
    brighten = a;
    brighten=brighten+50;
    value = +50;
    if (value >= 250)
        errordlg('Gambar Dah Putih Bro!','Terjadi kesalahan');
    else
        axes(handles.axes1);
        imshow(brighten);

        brighten_val = sprintf('%d', value);
        set(handles.brightVal, 'String', brighten_val);
    end
end

% --- Executes on button press in minBright.
function minBright_Callback(hObject, eventdata, handles)
% hObject    handle to minBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
global value;
empty = isempty(get(handles.axes1, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else
    brighten = a;
    brighten=brighten-50;
    value = value - 50;
    if (value >= -250)
        errordlg('Gambar Dah Selem Bro!','Terjadi kesalahan');
    else
        axes(handles.axes1);
        imshow(brighten);

        brighten_val = sprintf('%d', value);
        set(handles.brightVal, 'String', brighten_val);
    end
end
