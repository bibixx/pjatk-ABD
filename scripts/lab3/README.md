# ABD Lab 3
## Zadanie 1
Za pomocą `pgbench` wykonaj test wydajności serwera. Na początku wykonać test stanowiący nasz „baseline”. Następnie zmodyfikuj plik postgresql.conf i zmieniając wartość „shared buffers” na 256MB. Zrestartuj serwera i ponownie wykonaj test. Screeny z obu testów wstaw jako rozwiązanie. Jaką różnicę dostrzegłeś?\
Uwaga: podczas modyfikacji postgresql.conf zrób na wszelki wypadek jego kopię.

**Before**
```
» pgbench -c 10 -j 2 -t 10000 benchmark
pgbench (14.2 (Debian 14.2-1.pgdg110+1))
starting vacuum...end.
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 10
query mode: simple
number of clients: 10
number of threads: 2
number of transactions per client: 10000
number of transactions actually processed: 100000/100000
latency average = 7.919 ms
initial connection time = 49.961 ms
tps = 1262.841296 (without initial connection time)
```

**After**
```
» pgbench -c 10 -j 2 -t 10000 benchmark
pgbench (14.2 (Debian 14.2-1.pgdg110+1))
starting vacuum...end.
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 10
query mode: simple
number of clients: 10
number of threads: 2
number of transactions per client: 10000
number of transactions actually processed: 100000/100000
latency average = 5.877 ms
initial connection time = 69.970 ms
tps = 1701.452610 (without initial connection time)
```

> Mniejsze `latency` i większe `tps` (lepiej), natomiast wyższy `initial connection time` (gorzej)

## Zadanie 2
W tym zadaniu uruchomimy zbieranie logów w bazie danych poprzez modyfikacje postgresql.conf. Zmodyfikuj sekcję w nim tak, aby była zgodna z poniższym screenem. Pamiętaj o zrestartowaniu serwera po zmianie.

## Zadanie 3
Uruchom zbieranie informacji o wolnych zapytaniach, która trwają powyżej 1000 sekundy. Zmodyfikuj następującą linijkę w pliku postgresql.conf
```
log_min_duration_statement = 1000
```
Po modyfikacji wystarczy przeładować konfigurację serwera z pomocą komendy:
```sql
SELECT pg_reload_conf();
```

Następnie stwórz nową bazę danych i wykonaj poniższe komendy.

```sql
create table t_demo as select * from generate_series(1, 10000000) as id;
select id%2 from t_demo group by id%2;
```

Następnie sprawdź co znajduje się w logach. Dodaj screen rezultatu.

<details>
  <summary>
    <strong>
      Logi
    </strong>
  </summary>
  <pre>
2022-05-22 09:58:43.048 UTC,,,1,,628a0953.1,1,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"ending log output to stderr",,"Future log output will go to log destination ""csvlog"".",,,,,,,"","postmaster",,0
2022-05-22 09:58:43.048 UTC,,,1,,628a0953.1,2,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"starting PostgreSQL 14.2 (Debian 14.2-1.pgdg110+1) on aarch64-unknown-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit",,,,,,,,,"","postmaster",,0
2022-05-22 09:58:43.048 UTC,,,1,,628a0953.1,3,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"listening on IPv4 address ""0.0.0.0"", port 5432",,,,,,,,,"","postmaster",,0
2022-05-22 09:58:43.048 UTC,,,1,,628a0953.1,4,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"listening on IPv6 address ""::"", port 5432",,,,,,,,,"","postmaster",,0
2022-05-22 09:58:43.056 UTC,,,1,,628a0953.1,5,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"listening on Unix socket ""/var/run/postgresql/.s.PGSQL.5432""",,,,,,,,,"","postmaster",,0
2022-05-22 09:58:43.080 UTC,,,29,,628a0953.1d,1,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"database system shutdown was interrupted; last known up at 2022-05-22 09:58:31 UTC",,,,,,,,,"","startup",,0
2022-05-22 09:58:45.317 UTC,,,29,,628a0953.1d,2,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"database system was not properly shut down; automatic recovery in progress",,,,,,,,,"","startup",,0
2022-05-22 09:58:45.331 UTC,,,29,,628a0953.1d,3,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"redo starts at 0/39A75530",,,,,,,,,"","startup",,0
2022-05-22 09:58:50.451 UTC,,,29,,628a0953.1d,4,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"invalid record length at 0/444771D8: wanted 24, got 0",,,,,,,,,"","startup",,0
2022-05-22 09:58:50.451 UTC,,,29,,628a0953.1d,5,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"redo done at 0/444771A0 system usage: CPU: user: 0.52 s, system: 0.34 s, elapsed: 5.11 s",,,,,,,,,"","startup",,0
2022-05-22 09:59:06.002 UTC,,,1,,628a0953.1,6,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"database system is ready to accept connections",,,,,,,,,"","postmaster",,0
2022-05-22 10:00:25.730 UTC,"postgres","postgres",50,"[local]",628a09b8.32,1,"SELECT",2022-05-22 10:00:24 UTC,3/2,0,ERROR,42883,"function pg_reload_cong() does not exist",,"No function matches the given name and argument types. You might need to add explicit type casts.",,,,"SELECT pg_reload_cong();",8,,"psql","client backend",,0
2022-05-22 10:00:34.485 UTC,,,1,,628a0953.1,7,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"received SIGHUP, reloading configuration files",,,,,,,,,"","postmaster",,0
2022-05-22 10:00:34.494 UTC,,,1,,628a0953.1,8,,2022-05-22 09:58:43 UTC,,0,LOG,00000,"parameter ""log_min_duration_statement"" changed to ""1000""",,,,,,,,,"","postmaster",,0
2022-05-22 10:01:00.495 UTC,"postgres","postgres",52,"172.22.0.1:56626",628a09d9.34,1,"CREATE DATABASE",2022-05-22 10:00:57 UTC,3/11,302081,LOG,00000,"duration: 2884.663 ms  execute <unnamed>: create database benchmark2",,,,,,,,,"DataGrip 2021.3.4","client backend",,0
2022-05-22 10:04:01.783 UTC,"postgres","benchmark2",55,"172.22.0.1:56632",628a09e9.37,1,"CREATE TABLE AS",2022-05-22 10:01:13 UTC,4/66,302085,LOG,00000,"duration: 168150.581 ms  execute <unnamed>: create table t_demo as select * from generate_series(1, 10000000) as id",,,,,,,,,"DataGrip 2021.3.4","client backend",,0
2022-05-22 10:09:27.205 UTC,"postgres","benchmark2",55,"172.22.0.1:56632",628a09e9.37,2,"SELECT",2022-05-22 10:01:13 UTC,4/75,0,LOG,00000,"duration: 294044.832 ms  execute <unnamed>: select id%2 from t_demo group by id%2",,,,,,,,,"DataGrip 2021.3.4","client backend",,0
  </pre>
</details>

## Zadanie 4
Uruchom moduł `auto_explain` za pomocą poniższych komend:
```sql
LOAD ‘auto_explain’;
SET auto_explain.log_analyze TO on;
SET auto_explain.log_min_duration TO 500;
```

Jaki powinien być efekt działania komendy? Ponownie wykonaj zapytanie:
```sql
select id%2 from t_demo group by id%2;
```

Następnie sprawdź co zawierają logi. W wyniku umieść screen z rezultatem.

> Rezultat: Jeśli Query wykonuje się ponad 500ms → Wyślij plan do logów
<details>
  <summary><strong>Logi (tylko nowe wiersze)</strong></summary>
  <pre>
2022-05-22 10:14:01.404 UTC,"postgres","benchmark2",55,"172.22.0.1:56632",628a09e9.37,3,"SELECT",2022-05-22 10:01:13 UTC,4/105,0,LOG,00000,"duration: 9926.074 ms  execute <unnamed>: select id%2 from t_demo group by id%2",,,,,,,,,"DataGrip 2021.3.4","client backend",,0
2022-05-22 10:14:01.404 UTC,"postgres","benchmark2",55,"172.22.0.1:56632",628a09e9.37,4,"SELECT",2022-05-22 10:01:13 UTC,4/105,0,LOG,00000,"duration: 9926.065 ms  plan:
Query Text: select id%2 from t_demo group by id%2
HashAggregate  (cost=1219245.30..1500494.65 rows=9999977 width=4) (actual time=9926.033..9926.057 rows=2 loops=1)
  Group Key: (id % 2)
  Planned Partitions: 128  Batches: 1  Memory Usage: 793kB
  ->  Seq Scan on t_demo  (cost=0.00..169247.71 rows=9999977 width=4) (actual time=60.940..8737.691 rows=10000000 loops=1)
JIT:
  Functions: 7
  Options: Inlining true, Optimization true, Expressions true, Deforming true
  Timing: Generation 0.368 ms, Inlining 36.074 ms, Optimization 14.943 ms, Emission 8.117 ms, Total 59.502 ms",,,,,,,,,"DataGrip 2021.3.4","client backend",,0
  </pre>
</details>

## Zadanie 4
Sprawdź czas działania poniższego zapytania. Następnie zamień * na konkretną listę kolumn. Poćwicz z różnymi listami kolumn. Sprawdź jak ilość pobieranych danych wpływa na czas wykonania zapytania.
Czy potrafisz wskazać ewentualne negatywne aspekty wykorzystania „*”?
```sql
select * from test limit 40000;
```

| **Query**                      | **Time** |
|--------------------------------|----------|
| *                              | 106 ms   |
| name                           | 111 ms   |
| all columns                    | 116 ms   |

> 1. Większe zużycie pamięci
> 2. Jeśli mamy założony indeks na konkretną kolumnę/kolumny i potrzebujemy tylko tych kolumn to użycie `*` uniemożliwia nam wykonania Index-Only Scanu

## Zadanie 5
Zoptymalizuj poniższe zapytanie:
```sql
select * from test where name='{par1}';
```

| **Action**                     | **Time** |
|--------------------------------|----------|
| No action                      | 1308 ms  |
| Created index on name          | 6 ms     |

| **Object**                     | **Size**   |
|--------------------------------|------------|
| Table                          | 168992768  |
| Index                          | 63102976   |

## Zadanie 6
Usuń wszystkie indeksy na tabeli „test” i zoptymalizuj poniższe zapytanie.
```sql
select * from test where name='{par1}' OR name2='{par2}';
```

| **Action**                      | **Time** |
|---------------------------------|----------|
| No action                       | 1320 ms  |
| Created index on name           | 64 ms    |
| Created index on name2          | 73 ms    |
| Created index on name and name2 | 8 ms     |

## Zadanie 7
Usuń wszystkie indeksy na tabeli „test” i zoptymalizuj poniższe zapytanie. Spróbuj skorzystać z index only/covering index.
```sql
select id, name, created_at, num from test where name='{par1}' and num=par2;
```

| **Action**                                                                                    | **Time** |
|-----------------------------------------------------------------------------------------------|----------|
| No action                                                                                     | 56 ms    |
| `CREATE INDEX test_id_name_created_at_num_index ON test (name, num) INCLUDE (id, created_at)` | 4 ms     |

**INSERT**
| **Action**  | **Time** |
|-------------|----------|
| No index    | 14438 ms |
| With index  | 4190 ms  |

## Zadanie 8
Usuń wszystkie indeksy z tabeli „test”. Następnie zoptymalizuj poniższe zapytanie:
```sql
select * from test order by created_at desc, name limit 100;
```

| **Action**                                   | **Time** |
|----------------------------------------------|----------|
| No action                                    | 160 ms   |
| Created index on (name, created_at)          | 151 ms   |
| Clustered using (name, created_at) index     | 128 ms   |
| Created index on (created_at DESC, name ASC) | 4 ms     |

## Zadanie 9
Usuń wszystkie indeksy z tabeli „test”. Następnie zoptymalizuj poniższe zapytanie.
```sql
select test.id, test.name, test.name2, created_at from test
inner join test2 on test.id=test2.id
where test2.name='asdasfasdads' or test.created_at>'2001-01-01' order by test.updated_at limit 100;
```

| **Action**                                              | **Time**       |
|---------------------------------------------------------|----------------|
| No action                                               | 22530 ms   |
| Indexes on id on test and test2                         | 20000 ms   |
| Added index on test2.name                               | 20000 ms   |
| Added index on test.updated_at                          | 147 ms     |

## Zadanie 10
Usuń wszystkie indeksy z tabeli „test”. Następnie stwórz własną funkcję, która będzie przyjmować jako parametr pojedynczą liczbę całkowitą i będzie zwracać pojedynczą liczbę jako rezultat. Najlepiej, aby funkcja wykonywała jakąś prostą operację arytmetyczną. Następnie zoptymalizuj poniższe zapytanie:

```sql
select * from test where twoja_funkcja(num)=30;
```

**Funkcja**
```sql
CREATE OR REPLACE FUNCTION twoja_funkcja (input int)
RETURNS integer
as
$$
BEGIN
    return input * 2;
END
$$ language 'plpgsql';
```

| **Action**                          | **Time** |
|-------------------------------------|----------|
| No action                           | 682 ms   |
| Created index on twoja_funkcja(num) | 20 ms    |

## Zadanie 11
Uruchom skrypt `script_test3.sql`

Następnie zoptymalizuj następujące zapytanie:
```sql
Select id, name from test3
where name is not null and id=33423;
```

Porównaj standardowy indeks z indeksem częściowym. Porównaj zarówno ich wydajność jak również rozmiar.

| **Action**                              | **Time** |
|-----------------------------------------|----------|
| No action                               | 75 ms    |
| Index on (id, name)                     | 5 ms     |
| Index on (id) where name not null       | 5 ms     |

| **Index**                | **Size** |
|--------------------------|----------|
| (id, name)               | 90 MB    |
| (id) where name not null | 20 MB    |

## Zadanie 12
Stwórz tabelkę `Student(idStudent, firstName, lastName, indexNumber, email, birthdate)`;
  * Wykorzystaj sekwencję do generowania kluczy id. Stworzona sekwencja powinna generować klucze główne zaczynając od wartości zgodnej z Twoim numerem indeksu
  * Dodaj odpowiednie ograniczenie, które będzie pilnować formatu danych wstawianych do pola indexNumber – format „sxxxx”, gdzie x to cyfra. Liczba cyfr powinna być równa od 1 do 6
  * Dodaj ograniczenie, które sprawdzi czy data urodzenia wstawiana do tabeli jest większe od Twojej daty urodzenia
Zapisz wszystkie zapytania DML, które posłużą do uzyskania rozwiązania.

```sql
CREATE SEQUENCE id_student START 19129;

CREATE TABLE Student(
  idStudent integer NOT NULL DEFAULT nextval('id_student'),
  firstName varchar(255) ,
  lastName varchar(255),
  indexNumber varchar(7) CHECK (indexNumber SIMILAR TO 's[0-9]{1,6}'),
  email varchar(255),
  birthdate date CHECK (birthdate > '1999-01-10')
);
```
