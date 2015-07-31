include:
  - deluge
  - deluge.deluge-console

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
    - source: salt://deluge/deluge.default

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

{% set config_dir = salt['pillar.get']('deluge:config_dir') %}
{% set config = salt['pillar.get']('deluge:config', {}) %}

{% for key, value in config.items() %}
{{key}}:
  deluge.config_value:
    - value: {{value}}
    - config_dir: {{config_dir}}
{% endfor %}
