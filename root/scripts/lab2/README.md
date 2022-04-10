1. Stwórz pokazaną bazę danych umieszczając wszystkie tabele w odpowiednich schematach. Możesz posiłkować się skryptem w pliku db.sql. Pamiętaj, że skrypt nie zawiera np. odpowiednich schematów.

```sql
CREATE SCHEMA acc;
CREATE SCHEMA dea;
CREATE SCHEMA tea;

-- A
ALTER TABLE Payment SET SCHEMA acc;
ALTER TABLE Account SET SCHEMA acc;

-- B
ALTER TABLE Person SET SCHEMA dea;
ALTER TABLE Teacher SET SCHEMA dea;
ALTER TABLE Student SET SCHEMA dea;
ALTER TABLE SemesterEntry SET SCHEMA dea;
ALTER TABLE Semester SET SCHEMA dea;
ALTER TABLE Studies SET SCHEMA dea;

-- C
ALTER TABLE Student_Classes SET SCHEMA tea;
ALTER TABLE Classes SET SCHEMA tea;
ALTER TABLE Grade SET SCHEMA tea;
ALTER TABLE Subject SET SCHEMA tea;
```

2. Następnie odbierz wszystkie uprawnienia ze schematu public.
```sql
REVOKE CREATE ON SCHEMA public FROM public;
```

3. W kolejnym kroku dodaj odpowiednie role do bazy danych. Na diagramie widzimy kilka grup różnych użytkowników:
```sql
-- A
CREATE ROLE reports;

GRANT USAGE ON SCHEMA acc TO reports;
GRANT USAGE ON SCHEMA dea TO reports;
GRANT USAGE ON SCHEMA tea TO reports;

GRANT SELECT ON ALL TABLES IN SCHEMA acc TO reports;
GRANT SELECT ON ALL TABLES IN SCHEMA dea TO reports;
GRANT SELECT ON ALL TABLES IN SCHEMA tea TO reports;
ALTER DEFAULT PRIVILEGES IN SCHEMA acc GRANT SELECT ON TABLES TO reports;
ALTER DEFAULT PRIVILEGES IN SCHEMA dea GRANT SELECT ON TABLES TO reports;
ALTER DEFAULT PRIVILEGES IN SCHEMA tea GRANT SELECT ON TABLES TO reports;

-- B
CREATE ROLE admin;

GRANT USAGE ON SCHEMA acc TO admin;
GRANT USAGE ON SCHEMA dea TO admin;
GRANT USAGE ON SCHEMA tea TO admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA acc TO admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA dea TO admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA tea TO admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA acc GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA dea GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA tea GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO admin;

-- C
CREATE ROLE deaneary_write;

GRANT USAGE ON SCHEMA dea TO deaneary_write;

GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA dea TO deaneary_write;

-- D
CREATE ROLE teacher;

GRANT USAGE ON SCHEMA tea TO teacher;

GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA tea TO teacher;
ALTER DEFAULT PRIVILEGES IN SCHEMA tea GRANT INSERT, UPDATE, DELETE ON TABLES TO teacher;

GRANT USAGE ON SCHEMA dea TO teacher;
GRANT SELECT ON TABLE dea.Student TO teacher;

-- E
CREATE ROLE accounting;

GRANT USAGE ON SCHEMA acc TO accounting;

GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA acc TO accounting;
```

4. Stwórz po min. jednym użytkowniku dla każdej roli i sprawdź czy uprawnienia zostały poprawnie skonfigurowane.
```sql
CREATE USER u_reports WITH PASSWORD 'password';
CREATE USER u_admin WITH PASSWORD 'password';
CREATE USER u_deaneary_write WITH PASSWORD 'password';
CREATE USER u_teacher WITH PASSWORD 'password';
CREATE USER u_accounting WITH PASSWORD 'password';

GRANT reports TO u_reports;
GRANT admin TO u_admin;
GRANT deaneary_write TO u_deaneary_write;
GRANT teacher TO u_teacher;
GRANT accounting TO u_accounting;
```

6. W przypadku studenta zawsze chcemy mieć pewność, że numer indeksu będzie mieć format „sxxxx”, gdzie x są cyframi (maksymalnie 5 cyfr). Napisz w jaki sposób można wprowadzić takie ograniczenie w bazie danych – ewentualnie podaj kod instrukcji SQL, który doda takie ograniczenie.
```sql
CREATE DOMAIN pjatk_index AS TEXT CHECK(VALUE ~ '^s\d{1,5}$');
ALTER TABLE dea.student ALTER COLUMN idstudent TYPE pjatk_index USING idstudent::pjatk_index;
```

7. W tabeli Payment przechowujemy informacje o kwocie wpłaconej na konto. Kwota powinna mieć zawsze wartość dodatnią. Napisz w jaki sposób można wprowadzić takie ograniczenie w bazie danych – ewentualnie podaj kod instrukcji SQL, który doda takie ograniczenie.
```sql
CREATE DOMAIN payment_amount AS decimal(8,2) CHECK (VALUE > 0)
ALTER TABLE acc.payment ALTER COLUMN Amount TYPE payment_amount USING idstudent::payment_amount;
```
