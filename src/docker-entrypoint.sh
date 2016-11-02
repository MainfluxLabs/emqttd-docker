#!/bin/bash

set -e

EMQTTD_DIR=/opt/emqttd

_copy_config() {
    CONFIG_VOLUME=/etc/emqttd/config

    if [ "$(ls -A $CONFIG_VOLUME)" ]; then
        cp -ur $CONFIG_VOLUME/* $EMQTTD_DIR/etc
    fi
}

_configure_plugins() {
    # copy autoload list if provided
    PLUGINS_LIST=$EMQTTD_DIR/etc/plugins.load
    if [ -f $PLUGINS_LIST ]; then
        cp $PLUGINS_LIST $EMQTTD_DIR/data/loaded_plugins
    fi

    # copy custom plugin configuration if provided
    PLUGINS_VOLUME=/etc/emqttd/plugins
    if [ "$(ls -A $PLUGINS_VOLUME)" ]; then
        cp -ur $PLUGINS_VOLUME/* $EMQTTD_DIR/etc/plugins
    fi
}

if [ "$1" = 'emqttd' -a "$(id -u)" = '0' ]; then
    _copy_config
    _configure_plugins

    chown -R emqttd:emqttd .
    exec gosu emqttd "$0" "$@"
fi

exec "$@"
