# Web server of an S3 bucket

- Uses s3fs and caddy
- Need to set all of:
  - `S3_BUCKET`
  - `S3_ACCESS_KEY`
  - `S3_SECRET_KEY`
- Can set base url with `S3_BASEURL`
- It uses FUSE, so you need `--privileged`

## Example

```
$ docker run --rm -p 8200:80 -e S3... --privileged passcod/s3web
```
