deluge-ppa:
  pkgrepo.managed:
    - humanname: Deluge PPA
    {% if grains['os_family'] == 'Debian' %}
    - name: deb http://ppa.launchpad.net/deluge-team/ppa/ubuntu trusty main
    - file: /etc/apt/sources.list.d/deluge.list
    - keyid: 249AD24C
    - keyserver: keyserver.ubuntu.com
    {% endif %}

deluge:
  user.present:
    - home: /var/lib/deluge
    - system: True
