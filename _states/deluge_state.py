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
    value = _deluge_value(value)
    cv = __salt__['deluge.get_config_value'](name, config_path)
    if cv != value:
        __salt__['deluge.set_config_value'](name, value, config_path)
        ret['changes'][name] = {'old': cv, 'new': value}
        ret['comment'] = '{} changed from {} to {}'.format(name, cv, value)
        ret['result'] = True
    else:
        ret['comment'] = '{} was already set to {}'.format(name, value)
        ret['result'] = True
    return ret

def _deluge_value(value):
    '''
    Munge values into the format deluge uses
    '''
    if isinstance(value, bool):
        return str(value).lower()
    else:
        return value
