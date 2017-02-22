{% from "apache/map.jinja" import mod_jk with context %}

mod_jk:
  pkg.installed:
    - sources:
      - mod_jk: {{ mod_jk.source }} 
