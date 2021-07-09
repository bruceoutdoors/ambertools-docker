# AmberTools Docker Image

Docker image for [AmberTools](https://ambermd.org/AmberTools.php), the molecular dynamics simulations suite. With X11 forwarding, `xleap` GUI is supported as well.

**Note**: This is not published. I'm not sure whether I'm legally allowed to publish it, so for now you will need to build the image manually.

## Build

This image is built from source code, so you need to first get `AmberTools21.tar.bz2` from ["Download Amber Page (Option 3)"](https://ambermd.org/GetAmber.php) and place it in this directory.

Then run:

```sh
docker build -t bruceoutdoor/ambertools .
```

## Run

Now go to your MD simulations working directory and run:

```
docker run -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "`pwd`":/md/ \
  --user="$(id --user):$(id --group)" \
  -it --rm bruceoutdoor/ambertools
```
