hack to implement a pip hook to curator install. This is a bad idea, to quote [this stack overflow answer](https://stackoverflow.com/questions/30687375/custom-code-on-pip-uninstall):

> As others stated: this is strongly discouraged for security reasons and even if you find a way to do it now, is likely to break in the near feature.
>
> The same applies to setup install commands, not only uninstall ones. So, please don't go this route.
>
> Python packaging (including pip) is going towards being totally de[c]larative without running any code from the managed packages.

