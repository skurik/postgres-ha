etcd:
  pkg.installed:
    - name: etcd

patroni_repo:
  cmd.run:
    - name: "git clone https://github.com/zalando/patroni"
    - require:
      - pkg: etcd

postgres_user_home_dir_exists:
  file.directory:
    - name: /home/postgres    
    - user: postgres

postgres_user_bash_profile_exists:
  file.managed:
    - name: /home/postgres/.bash_profile
    - user: postgres
    - makedirs: True
    - replace: False
    #- require:
     # - file: postgres_user_home_dir_exists

postgres_path:
  file.append:
    - name: /home/postgres/.bash_profile
    - text: "export PATH=$PATH:/usr/lib/postgresql/9.6/bin"
    - require:
      - file: postgres_user_bash_profile_exists

# export PATH=$PATH:/usr/lib/postgresql/9.6/bin
# modify postgres$i.yml:
  # postgresq/data_dir: /var/lib/postgresql/9.6/node$i
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