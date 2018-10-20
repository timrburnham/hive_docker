# hive_docker
This is the Hortonworks HDP 2.6.5 Release of Hive 1.2.1 in a Docker container.

To Build
```sh
$ docker build -t hdp_hive:1.2.1 .
$ docker run -d -p 10000:10000 -v /e/:/user/hive/data hdp_hive:1.2.1
```

To Connect
```
jdbc:hive2://localhost:10000/default
```