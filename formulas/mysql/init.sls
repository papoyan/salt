#TODO: replace this with https://github.com/saltstack-formulas/mysql-formula and fix HACK in collator_mysql and profile_sync_mysql
{% from "mysql/map.jinja" import mysql with context %}
{%- set version = salt['pillar.get']('mysql:version', '') %}
{% set root_pass = salt['pillar.get']('salt:minion:mysql.pass', '') %}

mysql:
  pkg.installed:
    - name: {{ mysql.package }}
    {%- if version %}
    - version: {{ version }}
    {%- endif %}
  file.managed:
    - name: {{ mysql.config }}
    - template: jinja
    - source: salt://mysql/templates/my.cnf.jinja
    - user: root
    - group: root
    - mode: '0644'
  service.running:
    - name: {{ mysql.service }}
    - enable: True
    - watch:
       - file: {{ mysql.config }}
       - pkg: {{ mysql.package }}

{%- for database in salt['pillar.get']('mysql:databases', []) %}
mysql.database.{{ database.name }}:
 mysql_database.present:
   - onlyif:
     - test -f /etc/salt/minion.d/mysql.conf
   - name: {{ database.name }}
{%- endfor %}

{%- for user in salt['pillar.get']('mysql:users', []) %}
mysql.user.{{ user.name }}:
 mysql_user.present:
   - onlyif:
     - test -f /etc/salt/minion.d/mysql.conf
   - name: {{ user.name }}
   {%- if 'password_hash' in user %}
   - password_hash: '{{ user.password_hash }}'
   {% endif %}
   {%- if 'password' in user %}
   - password: '{{ user.password }}'
   {% endif %}
   - host: '{{ user.host }}'
{%- endfor %}

{%- for grant in salt['pillar.get']('mysql:grants', []) %}
mysql.grants.{{ grant.user }}:
 mysql_grants.present:
   - onlyif:
     - test -f /etc/salt/minion.d/mysql.conf
   - user: {{ grant.user }}
   - database: '{{ grant.database }}'
   - grant: {{ grant.grant }}
   - host: '{{ grant.host }}'
{%- endfor %}

mysql.python:
  pkg.installed:
    - name: {{ mysql.python }}

mysql.root_user:
  cmd.run:
    - name: salt-call mysql.user_chpass 'root' 'localhost' '{{ root_pass }}'
    - unless: "[ salt-call mysql.user_exists 'root' 'localhost' '{{ root_pass }}' ]"

mysql.salt_minion:
  file.managed:
    - user: root
    - group: root
    - mode: 640
    - name: /etc/salt/minion.d/mysql.conf
    - template: jinja
    - require:
      - cmd: mysql.root_user
    - source: salt://mysql/templates/minion.jinja
