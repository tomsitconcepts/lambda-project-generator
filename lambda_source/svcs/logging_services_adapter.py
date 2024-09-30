"""Adapter for 3rd party logging service"""

import logging
import sys

class ILoggingServiceAdapter():
    """interface for type-safety"""

    # pylint: disable=invalid-name
    def setLevel(self, level):
        """pass"""

    def debug(self, msg, *args, **kwargs):
        """pass"""

    def info(self, msg, *args, **kwargs):
        """pass"""

    def warning(self, msg, *args, **kwargs):
        """pass"""

    def error(self, msg, *args, **kwargs):
        """pass"""

# we prefer to wrap 3rd party things/services in adapters
# and inject them at composition time
# so they can be mocked for unit testing of our app
class LoggingServiceAdapter(ILoggingServiceAdapter):
    """Loose-coupling FTW"""

    def __init__(self) -> None:
        self._logger = logging.Logger('LAMBDA')
        self.setLevel(logging.INFO)

        handler = logging.StreamHandler(sys.stdout)
        handler.setLevel(logging.INFO)
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)
        self._logger.addHandler(handler)

    def setLevel(self, level):
        """delegate"""
        self._logger.setLevel(level)

    def debug(self, msg, *args, **kwargs):
        """delegate"""
        self._logger.debug(msg, args)

    def info(self, msg, *args, **kwargs):
        """delegate"""
        self._logger.info(msg, args)

    def warning(self, msg, *args, **kwargs):
        """delegate"""
        self._logger.warning(msg, args)

    def error(self, msg, *args, **kwargs):
        """delegate"""
        self._logger.error(msg, args)
