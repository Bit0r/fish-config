import site
import sysconfig

from rich import traceback

lib_path = [sysconfig.get_path("stdlib"),
            site.getusersitepackages()] + site.getsitepackages()
traceback.install(show_locals=True, suppress=lib_path)
