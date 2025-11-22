FROM alpine:latest
RUN echo "CI/CD Pipeline is working successfully!" > /message.txt
CMD ["cat", "/message.txt"]
