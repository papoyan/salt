{% from "python/map.jinja" import python3 with context %}

python3:
  pkgrepo.managed:
    - humanname: Python  package repository
    - baseurl:  {{ python3.baseurl  }}
    - gpgkey: {{ python3.gpgkey }}

  pkg.installed:
    - name: {{ python3.pkg }}

python3.pip:
  pkg.installed:
    - name: {{ python3.pip_pkg }}
    - require:
      - pkg: python3

python3.dev:
  pkg.installed:
    - name: {{ python3.dev_pkg }}
    - require:
      - pkg: python3
