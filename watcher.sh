while true; do

http_pid=`ps -ef |grep SimpleHTTPServer |grep 80 |awk '{print $2}'`
status=`/bin/systemctl status mysqlrouter.service |grep running`

 if [[ ($status =~ "running") && (! $http_pid) ]]; then
   python -m SimpleHTTPServer 80 &
 elif [[ ($status =~ "inactive") && ($http_pid) ]]; then
   http_pid=`ps -ef |grep SimpleHTTPServer |grep 80 |awk '{print $2}'`
   kill -9 "$http_pid"
   echo "killing pid"
 fi

sleep 5;
done