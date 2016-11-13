{% from "deluge/map.jinja" import deluge with context %}
deluge-ppa:
  pkgrepo.managed:
    - humanname: Deluge PPA
    {% if grains['os_family'] == 'Debian' %}
    - name: deb http://ppa.launchpad.net/deluge-team/ppa/ubuntu {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/deluge.list
    - keyid: 249AD24C
    - keyserver: keyserver.ubuntu.com
    {% endif %}

{{deluge.user}}:
  user.present:
    - createhome: False
    - system: True
    - shell: /usr/sbin/nologin

{{deluge.config_path}}:
  file.directory:
    - user: {{deluge.user}}
    - group: {{deluge.user}}
    - mode: 740
    - require:
      - user: {{deluge.user}}
