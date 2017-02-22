{% from "apache/map.jinja" import apache with context %}

apache:
  pkg.installed:
    - name: {{ apache.package }}
  file.managed:
    - name: {{ apache.config_dir }}/_placeholder.conf
    - contents: "#placeholder config managed by Salt. Do not use."
    - user: root
    - group: root
    - mode: '0644'
  service.running:
    - name: {{ apache.service }}
    - enable: True
    - watch:
       - file: {{ apache.config_dir }}/*
       - pkg: {{ apache.package }}

apache-restart:
  module.wait:
    - name: service.restart
    - m_name: {{ apache.service }}
