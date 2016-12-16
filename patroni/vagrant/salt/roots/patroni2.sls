etcd:
  pkg.installed:
    - name: etcd

patroni_repo:
  cmd.run:
    - name: "git clone https://github.com/zalando/patroni"
    - require:
      - pkg: etcd

modify_node_config:
  yaml_config.enforce_custom_thing:
    - name: "/srv/salt/files/patroni/postgres0.yml"
    - key: Foo
    - value: Bar