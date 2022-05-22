CREATE TABLE test
(
 id serial NOT NULL,
 name character varying(255),
 name2 character varying(255),
 num integer,
 created_at timestamp without time zone,
 updated_at timestamp without time zone
);

CREATE TABLE test2
(
 id serial NOT NULL,
 name character varying(255),
 name2 character varying(255)
);

create or replace function random_string(length integer) returns text as
$$
declare
 chars text[] :=
'{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,
c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
 result text := '';
 i integer := 0;
begin
 if length < 0 then
 raise exception 'Given length cannot be less than 0';
 end if;
 for i in 1..length loop
 result := result || chars[1+random()*(array_length(chars, 1)-1)];
 end loop;
 return result;
end;
$$ language plpgsql;



INSERT INTO
 test (name, name2, num, created_at, updated_at)
SELECT
 random_string(10), random_string(20), random() * 1000 + 1, now(), now()
FROM
 generate_series(1,2000000) i;
 
 
INSERT INTO
 test2 (name, name2)
SELECT
 random_string(10), random_string(20)
FROM
 generate_series(1,2000000) i;