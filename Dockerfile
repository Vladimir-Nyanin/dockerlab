FROM alpine:latest
RUN echo "CI/CD Pipeline is working!" > /message.txt
CMD ["cat", "/message.txt"]
