# See e.g. https://github.com/saltstack/salt/blob/develop/salt/modules/postgres.py

from __future__ import absolute_import
# from yaml import load, dump
import yaml
import datetime
import logging
import os

def __virtual__():
    return True

def load_yaml(path):
	with file(path, 'r') as stream, file(path + '.new', 'w') as out_stream:
		data = yaml.load(stream)
		data['postgresql']['bin_dir'] = '/pgdir'
		# data['scope'] = 'testscope'
		# data['etcd']['host'] = '6.6.6.6'
		# data['mykey'] = {'mv': {'mvv': {'mvvvv': {'dsf': 'sdfsdf'}}}}
		# data['smykeyyyy'] = {'mv': {'mvv': {'mvvvv': {'dsf': 'sdfsdf'}}}}
		yaml.dump(data, out_stream)

	# with file(path + '.new', 'r') as test_stream, file(path + '.ver', 'w') as out_ver_stream:
	# 	data = yaml.load(test_stream)
	# 	yaml.dump(data, out_ver_stream)

	return False

def modify_yaml(yaml, key_path, value):
	