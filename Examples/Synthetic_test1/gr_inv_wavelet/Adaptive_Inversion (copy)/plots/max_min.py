import numpy as np
import matplotlib.pyplot as plt
import string
D=np.loadtxt('residual_gmt_format')
print("max=%f, min=%f"%(np.max(D[:,2]),np.min(D[:,2])))
#print("0.02*max=%f"%(0.02*np.max(D[:,2])))
