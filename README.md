#loki-docker-logging-driver-i386

EXPERIMENTAL!

Build plugin to use Loki as logging driver for docker.
Build upon dockerfile, configs and scripts from https://github.com/grafana/loki

Follow these steps to (re)build and (re)install the plugin.

```bash
PROJECTDIR=$HOME/loki-docker-logging-driver
cd ${PROJECTDIR}
docker plugin rm -f logging-loki
rm -dr ./rootfs
mkdir rootfs
docker build -t loki-logging-plugin .
docker create --name rootfsctr loki-logging-plugin
docker export rootfsctr | tar -x -C ./rootfs
docker rm -vf rootfsctr
docker plugin create logging-loki .
docker plugin enable logging-loki
```

You can add pipeline yaml files after exporting the rootfs and before creating the docker plugin to the rootfs directory.
pipeline-example.yaml is included in /etc/loki/


## License
This code is distributed under GPL v3.0 License:
https://github.com/urfin78/loki-docker-i386/blob/master/LICENSE
The grafana/loki code is distributed under Apache 2.0 License:
https://github.com/grafana/loki/blob/master/LICENSE
