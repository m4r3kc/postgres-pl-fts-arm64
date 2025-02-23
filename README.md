# postgresql-pl-fts-arm64

## Użyte zasoby / Used Resources

---

**PL:**

Ten projekt korzysta ze słownika języka polskiego pochodzącego z [SJP.pl](https://sjp.pl).

Słownik jest dostępny na licencji GPL 2, LGPL 2.1, MPL 1.1, CC BY 4.0, Apache 2.0 i został użyty w tym projekcie do przygotowania obrazu dockerowego ze wsparciem FTS PL.

---

**EN:**

This project utilizes a Polish language dictionary originating from [SJP.pl](https://sjp.pl).

The dictionary is available under the following licenses: GPL 2, LGPL 2.1, MPL 1.1, CC BY 4.0, Apache 2.0 and has been used in this project to prepare a Docker image with FTS PL support.

---

**Obraz Dockerowy PostgreSQL dla architektury ARM z dodanym polskim językiem FTS**
Budowanie: docker build -t postgres-pl-fts-arm64 .

Uruchamianie: docker run -d -p 5432:5432 postgres-pl-fts-arm64
