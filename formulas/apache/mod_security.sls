{% from "apache/map.jinja" import mod_security with context %}
include:
  - apache

apache.mod_security:
  pkg.installed:
# mod_security packages are only available in yum for 64 bit.
{% if grains['osarch'] == 'x86_64' %}
    - name: mod_security
    - watch_in:
      - module: apache-restart
{% else %}
    - sources:
      - mod_security: {{ mod_security.get('source') }}
{% endif %}
