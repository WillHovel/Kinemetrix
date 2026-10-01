function build_exe()
% BUILD_EXE  Compile the Kinemetrix GUI into a standalone Windows .exe.
%
%   Prerequisite: the "MATLAB Compiler" product must be installed and
%   licensed (check with `which mcc` — it must return a path, not empty).
%   The app itself uses only base MATLAB, so no other toolbox is needed
%   to compile.
%
%   Usage:      >> build_exe
%   Output:     exe_out/Kinemetrix.exe   (standalone, no MATLAB needed on
%               the target machine once the MATLAB Runtime is installed)
%
%   All helper .m files (transform_fish, compute_kinematics, the loaders,
%   etc.) are pulled in automatically by mcc's dependency analysis; no
%   -a flag is needed for them. The .exe runs the same GUI entry point,
%   FishKinematicsApp(), with the same Browse-for-CSV workflow.

    root = fileparts(mfilename('fullpath'));

    if isempty(which('mcc'))
        error(['MATLAB Compiler (mcc) is not installed or not licensed.\n' ...
               'Install "MATLAB Compiler" from the Add-On Explorer (Home tab -> ' ...
               'Add-Ons -> Get Add-Ons -> search "MATLAB Compiler"), then re-run build_exe.']);
    end

    outdir = fullfile(root, 'exe_out');
    if ~exist(outdir, 'dir'), mkdir(outdir); end

    mcc('-m', 'FishKinematicsApp.m', ...
        '-o', 'Kinemetrix', ...
        '-d', outdir);

    fprintf('\nBuilt: %s\n', fullfile(outdir, 'Kinemetrix.exe'));
    fprintf(['To run on a machine WITHOUT MATLAB: install the MATLAB Runtime ' ...
             '(same release, R2025b) once,\n  or use MATLAB Compiler''s package ' ...
             'tool to build a self-extracting installer that bundles the Runtime.\n']);
end
