FROM arm64v8/postgres:17

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y locales-all

RUN localedef -i pl_PL -c -f UTF-8 -A /usr/share/locale/locale.alias pl_PL.UTF-8

ENV LANG pl_PL.UTF-8
ENV LC_ALL pl_PL.UTF-8

# Kopiowanie plików językowych do odpowiedniego katalogu PostgreSQL
# na podstawie https://github.com/dominem/postgresql_fts_polish_dict
# pliki w projekcie skonwertowane są już do UTF-8
# Katalog współdzielony PostgreSQL może się różnić w zależności od wersji i dystrybucji.
# Najczęściej jest to /usr/share/postgresql/<version>/tsearch_data/
# Dla '17' wersji, jest to /usr/share/postgresql/17/tsearch_data/
COPY polish.affix /usr/share/postgresql/17/tsearch_data/
COPY polish.dict /usr/share/postgresql/17/tsearch_data/
COPY polish.stop /usr/share/postgresql/17/tsearch_data/

# Skrypt SQL do konfiguracji FTS, zostanie wykonany po uruchomieniu kontenera
COPY init.sql /docker-entrypoint-initdb.d/