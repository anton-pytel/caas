import time
import sys
import matlab.engine
import os
eng = matlab.engine.start_matlab()
import StringIO
out = StringIO.StringIO()
err = StringIO.StringIO()
res = eng.mpcJavaInterface(sys.argv[1], sys.argv[2])
print(res)
eng.quit()

