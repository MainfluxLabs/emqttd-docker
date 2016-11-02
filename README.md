# EMQTTD Docker
This repository contains the EMQTTD [Dockerfile](src/Dockerfile), used by [Mainflux IoT
platform][mainflux].

## What is EMQTTD?
EMQTTD is a massively scalable and clusterable MQTT V3.1/V3.1.1 broker written in Erlang/OTP. For
more information about the product, please check the [official website][emqttd-official].

## How to use this image
To start up the container with the default configuration, execute the following commands inside the
command line:

```bash
docker run --name emqttd mainflux/emqttd-docker
```

The image exposes several ports: 1883 (MQTT), 8883 (MQTT over SSL), 8083 (Websocket/HTTP) and 18083
(browser-based dashboard). Standard container linking will make each of them available to the linked
containers. Alternatively, the ports can be mapped to the host machine during container startup.

#### Customizing broker behavior
Custom configuration can be provided through the `config` volume in the following manner:

```bash
docker run --name emqttd -v [host config directory]:/etc/emqttd/config mainflux/emqttd-docker
```

To learn more about the broker's configuration options, please check out its [official
website][emqttd-config].

#### Loading plugins
EMQTTD uses plugins to extend its default behavior. However, the plugins must be loaded using the
`emqttd_ctl` before they can be used. To load plugins into the container, the following steps must
be completed:

- Make sure to place the plugin configuration into the `plugins` volume. Please consult the
  [official website][emqttd-config] about the list of supported plugins.
- Provide the `plugins.load` file through the `config` volume. This file should contain list of all
  plugins to be loaded, with each plugin name given in separate line.

For example, to load `emq_auth_http` and `emq_auth_mysql` plugins, the `plugins.load` file
would have the following contents:

```
emq_auth_http.
emq_auth_mysql.
```

Once the setup is completed, execute the following command:

```bash
docker run --name emqttd -v [host config directory]:/etc/emqttd/config -v [host plugins directory]:/etc/emqttd/plugins mainflux/emqttd-docker
```

## Community
#### Mailing list
[mainflux][mainflux-google] Google group

#### IRC
[Mainflux Gitter][mainflux-gitter]

#### Twitter
[@mainflux][mainflux-twitter]

## License
[Apache License, version 2.0](LICENSE)

[emqttd-official]: http://emqtt.io
[emqttd-config]: http://emqtt.io/docs/v2/config.html
[mainflux]: https://github.com/Mainflux/mainflux
[mainflux-google]: https://groups.google.com/forum/#!forum/mainflux
[mainflux-gitter]: https://gitter.im/Mainflux/mainflux?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
[mainflux-twitter]: https://twitter.com/mainflux
