{% import 'options.sls' as opts %}
{% set nodeIds = [ '0', '1', '2' ] %}

etcd:
  pkg.installed:
    - name: etcd

haproxy:
  pkg.installed: []

python_etcd:
  cmd.run:
    - name: "pip install python-etcd"

python_consul:
  cmd.run:
    - name: "pip install python-consul"

patroni_repo:
  cmd.run:
    - name: "git clone https://github.com/zalando/patroni"
    - require:
      - pkg: etcd

{% for nodeId in nodeIds %}
modify_node_bin_dir_{{ nodeId }}:
  yaml_config.set_value:
    - name: "/root/patroni/postgres{{ nodeId }}.yml"
    - key: "postgresql/bin_dir"    
    - value: "{{ opts.pg_bin_dir }}"

modify_node_datadir_{{ nodeId }}:
  yaml_config.set_value:
    - name: "/root/patroni/postgres{{ nodeId }}.yml"
    - key: "postgresql/data_dir"    
    - value: "{{ opts.pg_data_dir + '/node' + nodeId }}"

# This does not work as expected. We need to modify the postgres config to log into a file and use the -l parameter to pg_ctl (see http://postgresql.nabble.com/pg-ctl-restart-does-not-terminate-td5932070.html#a5932095)
#
run_node_{{ nodeId }}:
  cmd.run:    
    - name: "su postgres -c './patroni.py postgres{{ nodeId }}.yml'"
    - cwd: "/root/patroni"    
    - require:
      - yaml_config: modify_node_bin_dir_{{ nodeId }}
      - yaml_config: modify_node_datadir_{{ nodeId }}
{% endfor %}

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