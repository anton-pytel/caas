ctrl = loadjson('data.json');
c= ctrl.CtlSys.Ss.SysC.Val;
for i=1:length(ctrl.CtlStep)
    ref(i) = ctrl.CtlStep{i}.RefSig{1}{1}.YRef;
    outY(i) = ctrl.CtlStep{i}.CtrlStateLast.Y0.Val;
end
t=1:length(ctrl.CtlStep);
ref1 =ref(25:31);
t1 = 1: length(ref1);
out1 = outY(25:31);
plot(t1,out1);
hold on
plot(t1,ref1);
legend('Vystup','Referencna hodnota');
ylabel('Lux')
xlabel('Krok')