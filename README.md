Downloads curator as package data. The wheel file is a bit beefy, but curator can now be used as such:

```python
import curatorbin

curatorbin.run_curator(first_curator_arg, second_curator_arg)

```

## Building the package:

First, make sure that the most current version of curator is in the appropriate dir:

```
curatorbin 
	macos/curator
	ubuntu1604/curator
	windows-64/curator.exe
```

Make sure the hash of the curator bin matches the hash in the `__init__.py` file.

To build for pip upload:

```
➜  piphack-curator git:(main) ✗ pip3 install -q build
➜  piphack-curator git:(main) ✗ python3 -m build
➜  piphack-curator git:(main) ✗ python3 -m twine upload --repository testpypi dist/*

```
See the following link for [credentials](https://packaging.python.org/tutorials/packaging-projects/).

Then, install with `pip3 install -vvv -i https://test.pypi.org/simple/ piphack-curator==0.7` and test before uploading to pip.

You may wish to clean up old builds with `rm -rf piphack_curator.egg-info dist build`
