FROM continuumio/conda-ci-linux-64-python3.8:latest
USER root
RUN  apt update&&apt upgrade -y &&apt install -y\
    curl\
    cmake\
    pkg-config\
    mesa-utils\
    libglu1-mesa-dev\
    freeglut3-dev\
    mesa-common-dev\
    libglew-dev\
    libglfw3-dev\
    libglm-dev\
    libao-dev\
    libmpg123-dev\
    libxi-dev\
    libxinerama-dev\
    libxcursor-dev\
    libgtk2.0-0\
    libgfortran4
WORKDIR "/tmp/"
RUN git clone https://github.com/glfw/glfw.git
RUN chmod -R a+rwx glfw
WORKDIR "/tmp/glfw"
RUN cmake .&&make&&make install

RUN curl https://subversion.xray.aps.anl.gov/admin_pyGSAS/downloads/gsas2full-Latest-Linux-x86_64.sh > /tmp/gsas2full-Latest-Linux-x86_64.sh
RUN bash /tmp/gsas2full-Latest-Linux-x86_64.sh -b -p /root/g2full
WORKDIR "/tmp/pipinstall"
COPY requirements.lock .
RUN pip install pip -U&&pip install -r requirements.lock
WORKDIR /root/
