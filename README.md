This is the Hortonworks HDP 2.6.5 Release of Hive 1.2.1 in a Docker container. No security is enabled and external data can be accessed via mounts.

To Build
```sh
$ docker build -t hdp_hive:1.2.1 .
$ docker run -d --rm -p 10000:10000 -v /e/:/user/hive/data hdp_hive:1.2.1
```

To Connect
```
jdbc:hive2://localhost:10000/default
```

Some Commands
```sql
-- Will show any directories you mounted
dfs -ls /user/hive/data
-- Demo
-- Step 1 - Create Table
create table test(id int, c1 string, c2 string) stored as orc;
-- Step 2 - Populate With 100,000 Records
insert overwrite table test
select y.pos + 1, x.*
	from (select 'Hello' c1, 'World' c2) x	
	lateral view posexplode(split(space(999999),' ')) y;
-- Step 3 - Some Test Queries
select * from test limit 10;	
select count(*) from test;
select min(id) min_id, max(id) max_id from test;
```