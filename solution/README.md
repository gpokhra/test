## CSV Server Part 1 Commands
# Pre-Requisites

1. Run the container image infracloudio/csvserver:latest in background and check if it's running.
```
docker run -it -d infracloudio/csvserver:latest
```
Check if it's running
```
docker ps -a | grep csvserver
278b2e7d5ebe   infracloudio/csvserver:latest   "/csvserver/csvserver"   2 minutes ago   Exited (1) 2 minutes ago  bold_mahavira
```
# The container is Exited

2. If it's failing then try to find the reason
```
docker logs 278b2e7d5ebe
2021/07/06 09:39:32 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory
```
# The container needs an input file to start

3. Write a bash script gencsv.sh to generate a file named inputFile
   File is present under solution directory
   A simple ```sh gencsv.sh``` should create inputFile having 10 entries. For more entries, just pass an interger parameter. Example: ```sh gencsv.sh 100```

4. Run the container again in the background with file generated in (3) available inside the container (remember the reason you found in (2)).
```
docker run -it -d -v ${PWD}/inputFile:/csvserver/inputdata:Z infracloudio/csvserver:latest
```

5. Get shell access to the container and find the port on which the application is listening. Once done, stop / delete the running container.

   Shell Access:
```
docker exec -it 72097a81a2fc bash
[root@6d8f507a97a1 csvserver]#
```
Find application port:
```
netstat -ntlp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver
```
Answer: ```9300```

Stop the container: ```docker stop 72097a81a2fc``` Remove the container: ```docker rm 72097a81a2fc```

6. Same as (4), run the container and make sure the application is accessible on the host at http://localhost:9393 .Set the environment variable CSVSERVER_BORDER to have value Orange
```
docker run -it -d -v ${PWD}/inputFile:/csvserver/inputdata:Z -p 9393:9300/tcp --env CSVSERVER_BORDER=Orange infracloudio/csvserver:latest
```
Application Response
```
curl -I http://localhost:9393
HTTP/1.1 200 OK
Date: Fri, 18 Jun 2021 17:14:12 GMT
Content-Length: 642
Content-Type: text/html; charset=utf-8
```

## CSV Server Part 2 Commands
```
 `docker-compose.yaml` is present in solution directory
  docker-compose -f docker-compose.yaml up -d
```

## CSV Server Part 3 Commands
  ```
  `docker-compose.yaml` is updated with prometheus container
   prometheus config file is also present in solution directory
   ```
