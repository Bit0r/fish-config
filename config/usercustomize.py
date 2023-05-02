import site
import sysconfig

from rich.traceback import install

lib_path = [sysconfig.get_path("stdlib"),
            site.getusersitepackages()] + site.getsitepackages()
install(show_locals=True, suppress=lib_path)
