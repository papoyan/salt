{% set default_package = 'java-1.7.0-openjdk' %}

java:
  pkg.installed:
    - name: {{ salt['pillar.get']('java:openjdk:package', default_package) }}
