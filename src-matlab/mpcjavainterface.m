function res=mpcJavaInterface(mpcid)
disp(strcat('Processing controller id: ', mpcid));
loadjson(strcat('../data-matlab/',mpcid))
res='done';

