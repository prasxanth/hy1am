# We use an `__init__.py` instead of `__init__.hy` so that importing
# from Python works even if `hy` hasn't been imported yet.

__version__ = '0.1'

import hy
hy.macros.require('hy1am.hy__init__',
   # The Python equivalent of `(require hyrule.hy-init *)`
   None, assignments = 'ALL', prefix = '')
from hy1am.hy__init__ import *