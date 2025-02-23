FROM arm64v8/postgres:17

# Ustawienie zmiennych środowiskowych dla języka polskiego
ENV LANG pl_PL.UTF-8
ENV LC_ALL pl_PL.UTF-8

# Instalacja pakietów locales (jeśli nie są domyślnie zainstalowane w obrazie postgres)
RUN apt-get update && apt-get install -y locales

# Generowanie locale pl_PL.UTF-8
RUN locale-gen pl_PL.UTF-8

# Kopiowanie plików językowych do odpowiedniego katalogu PostgreSQL
# na podstawie https://github.com/dominem/postgresql_fts_polish_dict
# pliki w projekcie skonwertowane są już do UTF-8
# Katalog współdzielony PostgreSQL może się różnić w zależności od wersji i dystrybucji.
# Najczęściej jest to /usr/share/postgresql/<version>/tsearch_data/
# Dla '17' wersji, jest to /usr/share/postgresql/17/tsearch_data/
COPY polish.affix /usr/share/postgresql/17/tsearch_data/
COPY polish.dict /usr/share/postgresql/17/tsearch_data/
COPY polish.stop /usr/share/postgresql/17/tsearch_data/

# Inicjalizacja bazy danych z locale pl_PL.UTF-8
# To można osiągnąć poprzez ustawienie zmiennych środowiskowych, ale dla pewności można dodać skrypt inicjalizujący
RUN echo "initdb -D /var/lib/postgresql/data --encoding=UTF-8 --locale=pl_PL.UTF-8" > /docker-entrypoint-initdb.d/locale.sh
RUN chmod +x /docker-entrypoint-initdb.d/locale.sh

# Skrypt SQL do konfiguracji FTS, zostanie wykonany po uruchomieniu kontenera
COPY init.sql /docker-entrypoint-initdb.d/