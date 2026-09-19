#!/bin/zsh

. $DOTFILES_HOME/bin/_env.zsh

logging_info "Bundle $DOTFILES_HOME/modules/docker-compose/Brewfile"
brew bundle --file="$DOTFILES_HOME/modules/docker-compose/Brewfile"

mkdir -p ~/.docker

export DOCKER_COMPOSE_PLUGIN_DIR="$(brew --prefix)/lib/docker/cli-plugins"
export DOCKER_CONFIG_FILE=~/.docker/config.json

python3 <<'PY'
import json
import os
from pathlib import Path

config_path = Path(os.path.expanduser(os.environ["DOCKER_CONFIG_FILE"]))
plugin_dir = os.environ["DOCKER_COMPOSE_PLUGIN_DIR"]

if config_path.exists():
    try:
        with config_path.open() as f:
            data = json.load(f)
    except json.JSONDecodeError as ex:
        raise SystemExit(f"Unable to parse {config_path}: {ex}")
else:
    data = {}

plugin_dirs = data.get("cliPluginsExtraDirs")
if isinstance(plugin_dirs, list):
    updated_plugin_dirs = plugin_dirs
elif plugin_dirs is None:
    updated_plugin_dirs = []
else:
    updated_plugin_dirs = [plugin_dirs]

if plugin_dir not in updated_plugin_dirs:
    updated_plugin_dirs.append(plugin_dir)

data["cliPluginsExtraDirs"] = updated_plugin_dirs

with config_path.open("w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
PY

logging_info "Configured Docker CLI plugin directory in $DOCKER_CONFIG_FILE"
