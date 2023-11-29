import os

c = get_config()  # noqa

c.Application.log_level = 'DEBUG'

c.Authenticator.admin_users = {'zw403'}
c.JupyterHub.authenticator_class = 'dummy'
c.DummyAuthenticator.password = 'jupyterhub@403-pass'

c.JupyterHub.spawner_class = 'systemdspawner.SystemdSpawner'
c.SystemdSpawner.default_shell = '/usr/bin/fish'
c.SystemdSpawner.disable_user_sudo = True
# c.SystemdSpawner.dynamic_users = True

c.JupyterHub.cookie_secret_file = '/srv/jupyterhub/jupyterhub_cookie_secret'
c.JupyterHub.db_url = 'mysql+pymysql://<username>:<password>@localhost:3306/<dbname>'
c.ConfigurableHTTPProxy.pid_file = '/var/run/jupyterhub-proxy.pid'
