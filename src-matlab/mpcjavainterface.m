function res=mpcJavaInterface(mpcid)
disp(strcat('Processing controller id: ', mpcid));
%mpcCtrl = getController(mpcid);
setController(mpcid,'state','computing');
clear mpcCtrl;
res='done';

