function res=mpcJavaInterface(mpcid)
disp(strcat('Processing controller id: ', mpcid));
filename=strcat('c:\Users\apytel\Documents\study\java\caas\data-matlab\',mpcid);
json=loadjson(filename);
json.state='computing';
res=json;
savejson('',json,filename);
%res='done';

