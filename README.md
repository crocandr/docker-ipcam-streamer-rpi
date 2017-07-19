# IP Cam RTSP recoder and streamer

## Build

```
docker build -t croc/ipcam-streamer .
``` 

## Usage

You have to createa a streamer.sh script on your docker host. This script contains the full command with vlc or something that makes stream the ipcam's RTPS stream to a simple HTTP stream. You can use http with NAT and motioneye, etc...

`streamer.sh` example on your docker host:
```
# VLC
# with transcode - more cpu usage
#su streamer -c 'screen -d -m vlc -q -R rtsp://192.168.155.102/live0.264 --sout "#transcode{vcodec=mjpg,vb=1200,scale=1.0,fps=5,acodec=none}:standard{access=http{mime=multipart/x-mixed-replace;boundary=7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:5890/videostream.cgi}"'

# Live555 Media
# without transcode - less cpu usage
live555ProxyServer rtsp://192.168.155.102/live0.264
# more than one source:
# live555ProxyServer rtsp://192.168.155.102/live0.264 rtsp://10.88.2.1/tcp/av0_0 
```

  - If you use vlc, your URL is (example) http://< docker host ip >:5890/videostream.cgi, http://172.17.0.11:5890/videostream.cgi
  - If you use live55ProxyServer, your URL is (example) rtsp://< docker host ip >/proxyStream, rtsp://172.17.0.11/proxyStream
    if you add more than one source your proxied urls is: rtsp://172.17.0.11/proxyStream-1 and rtsp://172.17.0.11/proxyStream-2 ... and you can check the source and URL binding with output of `docker logs ipcam-streamer` command. Example:

```
RTSP stream, proxying the stream "rtsp://192.168.155.102/live0.264"
        Play this stream using the URL: rtsp://172.17.0.11/proxyStream-1
RTSP stream, proxying the stream "rtsp://192.168.155.201/tcp/av0_0"
        Play this stream using the URL: rtsp://172.17.0.11/proxyStream-2
```


## Run

```
docker run -tid --name ipcam-streamer --restart always -v /srv/ipcam-streamer:/opt -p 5890:5890 -p 554:554 croc/ipcam-streamer
```
