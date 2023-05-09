# Golden-Cheetah in docker

```bash
docker run --rm -it \
-e DISPLAY:${DISPLAY} \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--entrypoint bash storage.zetxx.eu:5000/gc:latest
```