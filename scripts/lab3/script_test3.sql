CREATE TABLE test3 (id serial NOT NULL, name character varying(255));
INSERT INTO Test3 (id, name) SELECT random() * 1000 + 1, random_string(10) FROM generate_series(1,3000000) i;
INSERT INTO test (id, name)
SELECT random() * 1000 + 1, null FROM generate_series(1,2000000) i;
