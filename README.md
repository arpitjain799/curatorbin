Downloads curator as package data. The wheel file is a bit beefy, but curator can now be used as such:


```python
import curatorbin

curatorbin.run_curator()

```

If that fails, you can always try:

```python
#!/usr/bin/env python3

import os
import curatorbin
import subprocess

path = curatorbin.__path__[0]

curator = os.path.join(path,"macos","curator")

subprocess.check_call([curator] + sys.argv)

```
