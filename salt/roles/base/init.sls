base-pkgs:
  pkg.installed:
    - names:
      - vim-enhanced
      - telnet
      - postfix
      - mlocate
      - wget

/etc/motd:
  file.managed:
    - source: salt://roles/base/motd
