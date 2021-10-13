Downloads [curator](https://github.com/mongodb/curator) as package data. 

## Usage

The wheel file is a bit beefy, but curator can now be used as such:

```python
import curatorbin

curatorbin.run_curator(first_curator_arg, second_curator_arg)

```
Alternatively, you can get the path with `get_curator_path`.

## Building the package:

You can use `updateFromCurator.sh <major|minor|patch>` for this.
For example, `updateFromCurator.sh minor` will update the minor version, which would turn `1.2.3` to `1.3.0` in setup.py.
It also replaces with the latest curator hash the hash in `testdir/test_basic.py`, `curatorbin/__init__.py` and `evergreen.yml`. 

Also, increment the version in the `setup.py` and `evergreen.yml` files. 

Then, run a mainline or patch build and make sure to use the `publish-to-testpypi` evergreen task.
This will only finish successfully once.
Subsequent runs will fail unless you also increment the version.

The `placeholder.txt` files do not need to be updated, as the `get-bins` function in the evergreen yaml will get the bins automatically.
However, these are required to make sure that the necessary directories are in git, which helps with distribution.
