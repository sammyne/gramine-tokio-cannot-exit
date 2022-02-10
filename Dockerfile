FROM rust:1.57.0-buster AS builder1

WORKDIR /gramine

ADD hello-world .

RUN cargo build --release --all-targets 

WORKDIR /output

RUN cd /gramine/target/release && cp hello-world /output

FROM sammyne/gramine:1.1-ubuntu20.04 AS builder

WORKDIR /root/gramine/Examples/hello-world

ADD gramine .

COPY --from=builder1 /output/hello-world .

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN make SGX=1

WORKDIR /output

RUN cp -r /root/gramine/Examples/hello-world .

FROM sammyne/sgx-dcap:2.14.100.2-dcap1.11.100.2-ubuntu20.04

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update && apt install -y libprotobuf-c-dev

WORKDIR /gramine

COPY --from=builder /usr/local/bin/gramine-sgx /usr/local/bin/gramine-sgx
COPY --from=builder /usr/local/lib/x86_64-linux-gnu /usr/local/lib/x86_64-linux-gnu

COPY --from=builder /output/* ./

CMD gramine-sgx hello-world 
