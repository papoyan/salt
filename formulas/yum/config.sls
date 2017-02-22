yum.config:
  file.managed:
    - name: /etc/yum.conf
    - source: salt://yum/templates/yum.conf.jinja
    - template: jinja
    - mode: 644
    - user: root
    - group: root
