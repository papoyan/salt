# Salt state to download and configure Oracle's version of JDK.
{% from "java/map.jinja" import java with context %}

{% set version_name = java.oraclejdk.version_name %}
{% set source = java.oraclejdk.source %}
{% set prefix = java.oraclejdk.prefix %}
{% set add_to_env = java.oraclejdk.add_to_env %}

{{ prefix }}:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True

java.oraclejdk:
  cmd.run:
    - name: curl -b oraclelicense=accept-securebackup-cookie -L '{{ source }}' | tar xz --no-same-owner
    - cwd: {{ prefix }}
    # If the directory exists, don't re-download the tarball
    - unless: test -d {{ prefix }}/{{ version_name }}
  file.symlink:
    - name: /usr/bin/java
    - target: {{ prefix }}/{{ version_name }}/bin/java
    - user: root
    - group: root
    - require:
      - file: {{ prefix }}

java.remove_openjdk:
  # Ensure OpenJDK is not installed and conflicting
  cmd.run:
    - name: rpm -qa |grep openjdk | xargs rpm -e --nodeps
    - onlyif: rpm -qa | grep openjdk

#Set JAVA_HOME and add it to the PATH
{% if add_to_env %}
java.oraclejdk.env:
  file.managed:
    - name: /etc/profile.d/java.sh
    - user: root
    - group: root
    - mode: '0644'
    - contents: |
        export JAVA_HOME={{ prefix }}/{{ version_name }}
        export PATH=$JAVA_HOME/bin:$PATH
{% endif %}

#Install any extensions needed for the JDK
{% for extension, keys in java.extensions.items() %}
{{ prefix }}/{{ version_name }}/jre/lib/ext/{{ extension }}:
  {% if keys.type is defined and keys.type == 'artifactory' %}
  artifactory.downloaded:
    - artifact:
        artifactory_url: {{ keys['artifactory_url'] }}
        repository: {{ keys['repo'] }}
        artifact_id: {{ keys['artifact'] }}
        group_id: {{ keys['group'] }}
        version: {{ keys['version'] }}
    - target_file: {{ prefix }}/{{ version_name }}/jre/lib/ext/{{ extension }}

  {% else %}
  file.managed:
    - source: {{ keys['source'] }}
    {% if keys['source_hash'] is defined -%}
    - source_hash: {{ keys['source_hash'] }}
    {% endif %}

  {% endif %}
{% endfor %}
