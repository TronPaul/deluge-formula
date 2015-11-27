{% from "deluge/map.jinja" import deluge with context %}
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
    - template: jinja
    - source: salt://deluge/deluge.conf.jinja

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
      - user: {{deluge.user}}
    - watch:
      - file: {{deluge.config_path}}
      - file: /etc/default/deluged

{% for key, value in deluge.config.items() %}
{{key}}:
  deluge.config_value:
    {% if value is string %}
    - value: "{{value}}"
    {% else %}
    - value: {{value}}
    {% endif %}
    - config_path: {{deluge.config_path}}
    - require:
      - service: deluged
    - watch:
      - file: {{deluge.config_path}}
{% endfor %}
