FROM python:3.6-slim

ARG WEBHOOK_URL="URL"
ENV WEBHOOK_URL $WEBHOOK_URL
ARG BUCKET_NAME="s3_bucket"
ENV BUCKET_NAME $BUCKET_NAME

ADD script .
RUN pip install -r requirements.txt

RUN chmod +x ./entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
