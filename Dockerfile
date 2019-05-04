ARG IMAGE
FROM ${IMAGE}

WORKDIR /build
RUN mkdir tests
COPY tests tests
RUN ls tests/foo.txt
CMD ["bash"]
