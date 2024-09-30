"""Module for the AWS lambda entry point."""

from compose import compose

# Hint: less code here, means fewer deployment-only issues
# pylint: disable=unused-argument
def handler(event, context):
    """Module for the AWS lambda entry point."""
    app = compose()
    return app.process(event)
