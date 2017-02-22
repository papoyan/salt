yum.cron.package:
  pkg.installed:
    - name: yum-cron

yum.cron.service:
  service.running:
    - name: yum-cron
    - enable: True

{% if grains['osmajorrelease']|int >= 7 %}
yum-cron.config:
  file.managed:
    - name: /etc/yum/yum-cron.conf
    - source: salt://yum/templates/yum-cron.conf.jinja
    - mode: 644
    - user: root
    - group: root
    - template: jinja
{% endif %}

{% if grains['osmajorrelease']|int <= 6 %}
yum-cron.config:
  file.managed:
    - name: /etc/sysconfig/yum-cron
    - source: salt://yum/templates/yum-cron.jinja
    - mode: 644
    - user: root
    - group: root
    - template: jinja
{% endif %}
