CREATE USER test IDENTIFIED BY test
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

GRANT CONNECT, RESOURCE, CREATE VIEW TO test;
