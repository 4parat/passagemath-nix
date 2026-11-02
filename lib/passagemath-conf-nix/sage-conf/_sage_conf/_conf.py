import importlib
import pkgutil
import _sage_conf


def load_config():
    config = {}

    modules = sorted(
        module.name
        for module in pkgutil.iter_modules(_sage_conf.__path__)
    )

    for name in modules:
        module = importlib.import_module(f"_sage_conf.{name}")

        for key, value in vars(module).items():
            if key.startswith("__") or type(value) != str:
                continue
            if key in config:
                raise ValueError(
                    f"Duplicate Sage configuration variable: {key}"
                )
            config[key] = value

    return config


globals().update(load_config())

