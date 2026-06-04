# Docker Local m2

If you are a developer and you have made changes to your local .m2 folder and
you are not satisfied with just testing your service natively then this is the
dockerfile for you.

By running the script called `build-local-m2` you can build the `java-base`
image using your own `.m2` folder in your home directory. You can then build
the docker image for java service and it will automatically use the local m2
docker image as a base.
