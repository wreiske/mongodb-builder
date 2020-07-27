# MongoDB Builder for Meteor Mongo using GitHub Actions

This Docker image builds MongoDB for Linux from source without OpenSSL and cURL, similar to the generic Linux packages that are [not provided anymore since MongoDB 4.2](https://www.mongodb.com/blog/post/a-proposal-to-endoflife-our-generic-linux-tar-packages).

## Updating Mongo

Edit the `MONGODB_VERSION` variable in run-builder.sh and tag a new release. The build will trigger automatically on new releases and upload the final .tgz.
