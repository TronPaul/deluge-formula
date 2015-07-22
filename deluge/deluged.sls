include:
  - deluge
  - deluge-console

/etc/init.d/deluged:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://deluge/deluged.init.d

/etc/default/deluged:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://deluge/deluge-all.default

/var/log/deluge:
  file.directory:
    - user: deluge
    - group: deluge
    - mode: 755
    - require:
      - user: deluge

deluged:
  pkg.installed:
    - require:
      - pkgrepo: deluge-ppa
  service.running:
    - enable: True
    - require:
      - file: /var/log/deluge
      - file: /etc/init.d/deluged
      - file: /etc/default/deluged
