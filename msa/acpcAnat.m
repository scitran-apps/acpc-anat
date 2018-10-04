function [] = acpcAnat(anatomical, ...
                             userProvidedAcpc, ...
                             AC, PC, MS)

%{
clear all; close all;
anatomical = '/data/localhome/glerma/TESTDATA/acpcAnat/input/anatomical/18991230_000000ACCDTI070912s002a1001.nii.gz';
AC = '128, 140, 50'; % Z low for testing
PC = "128, 140, 70"; % Z high for testing
MS = "128, 135, 85"; 

% acpcAnat(anatomical, 'false', [],[],[])    
% acpcAnat(anatomical, 'true', [],[],[])  
acpcAnat(anatomical, 'true', AC, PC, MS)       
%}                       
 
                             
anatomical   = char(anatomical);
outPathParts = strsplit(anatomical, filesep);
outPath      = strjoin([outPathParts(1:(length(outPathParts)-3)), 'output'], filesep);

% Default is that it will use MNI                         
if ~exist(userProvidedAcpc)  | strcmp(userProvidedAcpc, 'false')
    userProvidedAcpc = false;
else
    userProvidedAcpc = true;
end

% Give some default values
% AC
if ~exist('AC')  | isempty(AC)
    AC = [128, 140, 60];
end
if isstring(AC) | ischar(AC)
    AC = str2double(strsplit(AC, ','));
    fprintf('\nThis is AC converted from a string (class: %s)\n', class(AC))
    AC
end

% PC
if ~exist('PC')  | isempty(PC)
    PC = [128, 110, 60];
end
if isstring(PC)| ischar(PC)
    PC = str2double(strsplit(PC, ','));
    fprintf('\nThis is PC converted from a string (class: %s)\n', class(PC))
    PC
end

% MS
if ~exist('MS')  | isempty(MS)
    MS = [128, 135, 85];
end
if isstring(MS)| ischar(MS)
    MS = str2double(strsplit(MS, ','));
    fprintf('\nThis is MS converted from a string (class: %s)\n', class(MS))
    MS
end

alignLandmarks = [AC; PC; MS];
fprintf('\nThese are the align landmarksMS (class: %s)\n\n', class(alignLandmarks))
alignLandmarks




fprintf('The input file is: %s ...\n', anatomical)

if ~userProvidedAcpc
    % Name for the aligned image
    anatomical_aligned = fullfile(outPath, 't1_std_autoMNI.nii.gz');
    fprintf('... it will be converted to %s.\n\n', anatomical_aligned)

    % Auto ACPC alignment, from tal coordinates of MNI T1
    % Read the file
    ni = readFileNifti(anatomical);
    ni = niftiApplyCannonicalXform(ni);
    % Read the template
    template =  fullfile(mrDiffusionDir, 'templates', 'MNI_T1.nii.gz');
    % Norm it
    sn = mrAnatComputeSpmSpatialNorm(ni.data, ni.qto_xyz, template);
    % Obtain coordinates
    c = mrAnatGetImageCoordsFromSn(sn, tal2mni([0,0,0; 0,-16,0; 0,-8,40])', true)';
    fprintf('\nThis automatically obtained acpc values will be used (of class %s)\n', class(c))
    c
    mrAnatAverageAcpcNifti(ni, anatomical_aligned, c, [], [], [], false);
else
    % Name for the aligned image
    anatomical_aligned = fullfile(outPath, 't1_std_acpcCoords.nii.gz');
    fprintf('... it will be converted to %s.\n\n', anatomical_aligned)
    
    % Read the file
    ni = readFileNifti(anatomical);
    ni = niftiApplyCannonicalXform(ni);
    % Create the coordinates, they need to follow this format
    % c = [ acX, acY, acZ; pcX, pcY, pcZ; midSagX, midSagY, midSagZ ]
    c =  alignLandmarks;
    fprintf('\nThis provided acpc values will be used (of class %s):\n', class(c))
    c
    
    mrAnatAverageAcpcNifti(ni, anatomical_aligned, c, [], [], [], false);
end
end
