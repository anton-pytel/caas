function output=fillval(inputtime,inputvalue)
output = zeros(1,floor(inputtime(length(inputtime))));
for j=1:floor(inputtime(1))
    output(j)=inputvalue(1);
end

for i=2:length(inputtime)
    for j=floor(inputtime(i-1)):floor(inputtime(i))
        output(j)=inputvalue(i-1);
    end
end