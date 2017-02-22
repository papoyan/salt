{% if salt['grains.get']('os_family') == 'RedHat' %}
{% for repo in salt['pillar.get']('yum:repositories', []) %}
yum.repositories.{{ repo.name }}:
  pkgrepo.managed:
    - name: {{ repo.name }}
    - humanname: {{ repo.humanname }}
    - baseurl: {{ repo.baseurl }}
    - gpgkey: {{ repo.gpgkey }}
{% endfor %}
{% endif %}
