java.jsvc:
  pkg.installed:
    - sources:
      - jakarta-commons-daemon-jsvc: {{ salt['pillar.get']('java:jsvc:rpm') }}
