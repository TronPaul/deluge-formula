try:
    import simplejson as json
except ImportError:
    import json

__virtualname__ = 'deluge'


def __virtual__():
    if 'deluge.get_config_value' in __salt__:
        return __virtualname__
    else:
        return False


def config_value(name, value, config_path):
    ret = {'name': name,
           'changes': {},
           'result': True,
           'comment': ''}
    # Deluge works with json values
    json_value = json.dumps(value)
    cv = __salt__['deluge.get_config_value'](name, config_path)
    if cv != json_value:
        __salt__['deluge.set_config_value'](name, json_value, config_path)
        ret['changes'][name] = {'old': cv, 'new': json_value}
        ret['comment'] = '{} changed from {} to {}'.format(name, cv, json_value)
        ret['result'] = True
    else:
        ret['comment'] = '{} was already set to {}'.format(name, json_value)
        ret['result'] = True
    return ret
