{% from "deluge/map.jinja" import deluge with context %}
include:
  - deluge

/etc/init.d/deluge-web:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://deluge/deluge-web.init.d

/etc/default/deluge-web:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://deluge/deluge.conf.jinja

deluge-web:
  pkg:
    - installed
    - require:
      - pkgrepo: deluge-ppa
  service.running:
    - enable: True
    - require:
      - file: /etc/default/deluge-web
      - file: /etc/init.d/deluge-web
      - file: {{deluge.config_path}}
      - user: {{deluge.user}}
