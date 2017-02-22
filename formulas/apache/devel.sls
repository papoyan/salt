{% from "apache/map.jinja" import apache with context %}
include:
  - apache

apache.devel:
  pkg.installed:
    - name: {{ apache.package_devel }}
