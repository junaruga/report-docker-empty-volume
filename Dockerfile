ARG IMAGE
FROM ${IMAGE}

WORKDIR /build
COPY . .
RUN ls tests/foo.txt
RUN ls bar.txt
CMD ["bash"]
