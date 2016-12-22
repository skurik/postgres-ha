{% import 'options.sls' as opts %}

etcd:
  pkg.installed:
    - name: etcd

patroni_repo:
  cmd.run:
    - name: "git clone https://github.com/zalando/patroni"
    - require:
      - pkg: etcd

modify_node_config:
  yaml_config.set_value:
    - name: "/srv/salt/files/patroni/postgres0.yml"
    - key: "postgresql/bin_dir"    
    - value: "{{ opts.pg_bin_dir }}"