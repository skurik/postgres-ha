# See e.g. https://github.com/saltstack/salt/blob/develop/salt/modules/postgres.py

from __future__ import absolute_import
import datetime
import logging
import os

def __virtual__():
    return True

def load_yaml(path):
	return False