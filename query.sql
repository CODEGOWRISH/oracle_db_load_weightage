
-- desc test.dbuserstathist
--  Name                                      Null?    Type
--  ----------------------------------------- -------- ----------------------------
--  DBNAME                                             VARCHAR2(10)
--  TIME_STAMP                                         VARCHAR2(20)
--  USER_NAME                                          VARCHAR2(20)
--  STATSTIC_NAME                                      VARCHAR2(100)
--  STATSTIC_VALUE                                     NUMBER(20)

set lines 120
set pages 1000

column dbname format a10
column time_stamp format a20
column user_name format a20
column statistic_name format a30
column pct_weight_at_cluster format 990

spool query1.lst

prompt
prompt Percent Weight Ordered by Timestamp, DB, User
prompt

select a.time_stamp, a.dbname, a.user_name, a.statistic_name, round(100*a.statistic_value/b.statistic_sum, 0) pct_weight_at_cluster
from test.dbuserstathist a,
(select time_stamp, statistic_name, sum(statistic_value) statistic_sum
 from test.dbuserstathist
 group by  time_stamp, statistic_name) b
where a.time_stamp=b.time_stamp and a.statistic_name=b.statistic_name
order by 1,2,3,4;

spool off

spool query2.lst

prompt
prompt Percent Weight Ordered by DB, User, Timestamp
prompt

select a.time_stamp, a.dbname, a.user_name, a.statistic_name, round(100*a.statistic_value/b.statistic_sum, 0) pct_weight_at_cluster
from test.dbuserstathist a,
(select time_stamp, statistic_name, sum(statistic_value) statistic_sum
 from test.dbuserstathist
 group by  time_stamp, statistic_name) b
where a.time_stamp=b.time_stamp and a.statistic_name=b.statistic_name
order by 2,3,1,4;

spool off
