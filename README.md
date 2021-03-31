Downloads [curator](https://github.com/mongodb/curator) as package data. 

The wheel file is a bit beefy, but curator can now be used as such:

```python
import curatorbin

curatorbin.run_curator(first_curator_arg, second_curator_arg)

```
Alternatively, you can get the path with `get_curator_path`.

## Building the package:

Make sure you edit the hash in `testdir/test_basic.py` and the version in the `setup.py`.

Run the following:
```
cd curatorbin
./unpackBins.sh <your hash>
```
You can then use the `publish-to-testpypi` evergreen task for publishing once you commit.

