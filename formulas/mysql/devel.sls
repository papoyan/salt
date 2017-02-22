{% from "mysql/map.jinja" import mysql with context %}
{%- set version = salt['pillar.get']('mysql:version', '') %}

mysql.devel:
  pkg.installed:
    - name: {{ mysql.package_devel }}
    {%- if version %}
    - version: {{ version }}
    {%- endif %}
