# Golden-Cheetah in docker

Remember to allow x11 connection from any host `xhost +`
h

```bash
docker run --rm -it \
-e DISPLAY:$DISPLAY \
-v $HOME/.goldencheetah/:/.goldencheetah/ \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--entrypoint bash storage.zetxx.eu:5000/gc:latest
```