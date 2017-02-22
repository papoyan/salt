include:
  - apache

apache.mod_ssl:
  pkg.installed:
    - name: mod_ssl
    - watch_in:
      - module: apache-restart
