{% from "docker/map.jinja" import docker with context %}

docker:
  pkg.installed:
    - name: {{ docker.server }}
  service.running:
    - name: {{ docker.service }}
    - enable: True
