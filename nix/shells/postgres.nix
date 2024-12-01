# devshells/shells/postgres.nix
{ pkgs, lib }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    postgresql_15
    pgcli
    psqlodbc
  ];

  shellHook = ''
    export PGDATA="$PWD/postgres_data"
    export PGHOST="$PWD/postgres"
    export PGPORT=5432
    export PGDATABASE="postgres"
    
    function init_postgresql {
      if [ ! -d "$PGDATA" ]; then
        echo "Initializing PostgreSQL database..."
        initdb "$PGDATA" --encoding=UTF8 --no-locale --no-instructions
        echo "listen_addresses = '*'" >> "$PGDATA/postgresql.conf"
        echo "unix_socket_directories = '$PGHOST'" >> "$PGDATA/postgresql.conf"
      fi
    }

    function start_postgresql {
      if [ ! -d "$PGHOST" ]; then
        mkdir -p "$PGHOST"
      fi
      
      if ! pg_ctl status > /dev/null; then
        pg_ctl -D "$PGDATA" -l "$PGDATA/postgresql.log" -o "-k $PGHOST" start
      fi
    }

    function stop_postgresql {
      pg_ctl -D "$PGDATA" stop
    }

    alias pg_start="start_postgresql"
    alias pg_stop="stop_postgresql"
    alias pg_init="init_postgresql"

    echo "PostgreSQL Development Shell"
    echo "Commands: pg_init, pg_start, pg_stop"
  '';
}
