# Golden-Cheetah in docker

Remember to allow x11 connection from any host `xhost +`
h
`/home/zetxx/` put your user home here, if your user is named "green" so your
path should looks like `/home/green/`

```bash
docker run --rm -it \
-e DISPLAY:${DISPLAY} \
-v /home/zetxx/.goldencheetah/:/.goldencheetah/ \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--entrypoint bash storage.zetxx.eu:5000/gc:latest
```