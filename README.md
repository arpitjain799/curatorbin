Downloads curator as package data. The wheel file is a bit beefy, but curator can now be used as such:

```python
#!/usr/bin/env python3

import os
import curatorbin
import subprocess
import importlib.resources

subprocess.check_call(['ls'])

path = curatorbin.__path__[0]

curator = os.path.join(path,"macos","curator")

print(curator)
```
