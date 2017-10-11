FROM ubuntu:16.04


RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y build-essential cmake git pkg-config libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libgtk2.0-dev libatlas-base-dev gfortran python3 python3-pip python3-dev

RUN pip3 install numpy

RUN git clone https://github.com/Itseez/opencv.git && cd opencv && git checkout 3.3.0
RUN git clone https://github.com/Itseez/opencv_contrib.git && cd opencv_contrib && git checkout 3.3.0

RUN cd opencv && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
    -D BUILD_EXAMPLES=OFF .. && \
    make -j4 && \
    make install && \
    ldconfig

WORKDIR /tmp/

ENTRYPOINT ["python3", "deep_learning_with_opencv.py", "--image", "images/jumping_cat.jpg", "--prototxt", "bvlc_googlenet.prototxt", "--model", "bvlc_googlenet.caffemodel", "--labels", "synset_words.txt"]
