function res=mpcJavaInterface(mpcid,funcType)
disp(strcat('Processing controller id: ', mpcid,'_',funcType));
config=load('config.mat');
filename=strcat(config.filebase,mpcid);
if funcType == '0'
    filename1=filename;
else
    filename1=strcat(filename,'_',funcType);
end
json=loadjson(filename);
json.state='computing';
json=mpc_main(json,funcType);
savejson('',json,filename1);
res='done';

