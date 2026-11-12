function h = hashstruct(x)
% hashstruct - MD5 hash of a PulSeg object, used to tie pge2.check results to it.
%
% function h = hashstruct(x)
%
% In MATLAB this is DataHash(x). DataHash relies on Java, which GNU Octave
% does not provide, so in Octave the hash is taken over the text
% serialization of x instead. The two hashes differ, so check and serialize
% a PulSeg object in the same program.
%
% Input
%   x    PulSeg sequence struct (or any struct)
%
% Output
%   h    32-character hexadecimal MD5 hash

if exist('OCTAVE_VERSION', 'builtin')
    f = [tempname() '.txt'];
    save('-text', f, 'x');
    s = fileread(f);
    delete(f);
    s = regexprep(s, '# Created by Octave[^\n]*\n', '');
    h = hash('md5', s);
else
    h = DataHash(x);
end
