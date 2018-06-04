FROM ubuntu:16.04
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential libcurl3-dev libopencv-dev libopencv-core-dev python-pip software-properties-common \
 && add-apt-repository ppa:maarten-fonville/protobuf \
 && apt-get update \
 && apt-get install -y protobuf-compiler libprotobuf-dev \
 && rm -rf /var/lib/apt/lists/*

RUN pip install setuptools \
 && pip install pillow

WORKDIR /workspace
COPY . .
RUN make -f Makefile.clients all pip \
 && pip install --no-cache-dir --upgrade build/dist/dist/inference_server-1.0.0-cp27-cp27mu-linux_x86_64.whl

