## Docker container for Volt

Create a Dockerfile in your Volt app with the following

```
FROM otzy007/voltframework

RUN apt-get update
RUN apt-get install --yes nodejs
```

Then you can build the Docker image:

```
docker build -t my-volt-app .
```

And run it:

```
docker run --name my-volt-app -p 3000:3000 -d my-volt-app
```

You can then go to http://localhost:3000 in your browser
