sudo docker run --rm -v $PWD/data:/tmp -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/root/.Xauthority --net=host wetcat
