## build

```
docker build -t test --build-arg WEBHOOK_URL=$WEBHOOK_URL \
                     --build-arg BUCKET_NAME=$BUCKET_NAME .
```

## run

```
docker run -it --rm test
```
