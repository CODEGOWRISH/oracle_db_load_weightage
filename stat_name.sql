select name from v$statname where name like '%cpu%' or name like '%mem%' order by 1;
