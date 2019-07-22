import os
import pandas as pd
import numpy as np

df = pd.DataFrame(data=np.eye(4), columns=["col1", "col2", "col3", "col4"])

print(df)

ENVIRONMENT = os.environ["ENVIRONMENT"]

print("Python script running in {env}.".format(env=ENVIRONMENT))
