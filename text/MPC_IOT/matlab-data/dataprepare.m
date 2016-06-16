% timeo/i, valo/i mame z excelu
outputdata=fillval(timeo,valo);
inputdata=fillval(timei,vali);
% chceme len kazdu 4 vzorku (perioda vzorkovania) je kazde 4 minuty -
% senzor dat
inputdata=inputdata(1:4:length(inputdata));
outputdata=outputdata(1:4:length(outputdata));

ss2tf(n4s6.a,n4s6.b,n4s6.c,n4s6.d)

tf(num,den)

% vysledok transfer function - pridat *(znamienko krat) a dat do regulatora