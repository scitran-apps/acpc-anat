function [] = acpcAnat(anatomical, ...
                             userProvidedAcpc, ...
                             AC, PC, MS, ...
                             outputPath)

%{
anatomical = '/data/localhome/glerma/TESTDATA/mrtrix3preproc/input/ANAT/18991230_000000ACCDTI070912s002a1001.nii.gz';
acpcAnat(anatomical, 'false', '','','','')    
acpcAnat(anatomical, 'true', '','','','')  

AC = [128, 140, 50]; % Z low for testing
PC = [128, 140, 70]; % Z low for testing
MS = [128, 135, 85]; 
acpcAnat(anatomical, 'true', AC, PC, MS, '')                            
%}                       
                         
% Default is that it will use MNI                         
if ~exist(userProvidedAcpc)  | strcmp(userProvidedAcpc, 'false')
    userProvidedAcpc = false;
else
    userProvidedAcpc = true;
end

% Give some default values
if ~exist('AC')  | isempty(AC)
    AC = [128, 140, 60];
end
if ~exist('PC')  | isempty(PC)
    PC = [128, 110, 60];
end
if ~exist('MS')  | isempty(MS)
    MS = [128, 135, 85];
end

if ~exist(outputPath)  | strcmp(outputPath, '')
    outputPath = fileparts(anatomical);
end



% Name for the aligned image
anatomical_aligned = fullfile(outputPath, 't1_std_acpc.nii.gz');

% Auto ACPC alignment, from tal coordinates of MNI T1
ni = readFileNifti(anatomical);
ni = niftiApplyCannonicalXform(ni);
template =  fullfile(mrDiffusionDir, 'templates', 'MNI_T1.nii.gz');
if ~userProvidedAcpc
    sn = mrAnatComputeSpmSpatialNorm(ni.data, ni.qto_xyz, template);
    c = mrAnatGetImageCoordsFromSn(sn, tal2mni([0,0,0; 0,-16,0; 0,-8,40])', true)';
    mrAnatAverageAcpcNifti(ni, anatomical_aligned, c, [], [], [], false);
else
    % c = [ acX, acY, acZ; pcX, pcY, pcZ; midSagX, midSagY, midSagZ ]
    c =  [AC; PC; MS];
    mrAnatAverageAcpcNifti(ni, anatomical_aligned, c, [], [], [], false);
end
end
