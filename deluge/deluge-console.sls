include:
  - deluge

deluge-console:
  pkg:
    - installed
    - require:
      - pkgrepo: deluge-ppa
    - reload_modules: true
