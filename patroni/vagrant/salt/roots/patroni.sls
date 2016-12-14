patroni_repo:
  cmd.run:
    - name: "git clone https://github.com/zalando/patroni"

# {% import_yaml "/srv/salt/files/patroni/postgres0.yml" as postgresql %}
# {% do postgresql.update({'foo': 'bar'}) %}
# {% do postgresql.update({'etcd': { 'host': 'ddddd', 'new': 'newval' }}) %}

# etcd:
#   pkg.installed:
#     - name: etcd


    # - require:
      # - pkg: etcd

# write_node_config:
#   file.managed:
#     - name: "/srv/salt/files/patroni/transformed0.yml"
#     - contents: "{{ postgresql | yaml(False) }}"
#     # - contents: {{ postgresql | yaml(False) }}

# modify_node_config:
#   yaml_config.enforce_custom_thing:
#     - name: somename
#     - foo: Foo
#     - bar: Bar


# postgres_user_home_dir_exists:
#   file.directory:
#     - name: /home/postgres    
#     - user: postgres

# postgres_user_bash_profile_exists:
#   file.managed:
#     - name: /home/postgres/.bash_profile
#     - user: postgres
#     - makedirs: True
#     - replace: False
#     #- require:
#      # - file: postgres_user_home_dir_exists

# postgres_path:
#   file.append:
#     - name: /home/postgres/.bash_profile
#     - text: "export PATH=$PATH:/usr/lib/postgresql/9.6/bin"
#     - require:
#       - file: postgres_user_bash_profile_exists


# Toto asi neni nutne: export PATH=$PATH:/usr/lib/postgresql/9.6/bin
# Misto toho nastavime bin_dir v postgres$i.yml, viz. nize:
# modify postgres$i.yml:
  # postgresql/data_dir: /var/lib/postgresql/9.6/node$i
  # postgresql/bin_dir: /usr/lib/postgresql/9.6/bin
# run (as 'postgres')
# ./patroni.py postgres0.yml
# ./patroni.py postgres1.yml
# psql -h localhost -p 5432
# psql -h localhost -p 5433
# apt-get install haproxy
# haproxy -f haproxy.cfg
# psql -h localhost -p 5000
# su postgres -c "/usr/lib/postgresql/9.6/bin/pg_ctl -D /var/lib/postgresql/9.6/node0 stop -m fast"
# 