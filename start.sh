#!/bin/sh

echo "$S3_ACCESS_KEY:$S3_SECRET_KEY" > /etc/passwd-s3fs
chmod 600 /etc/passwd-s3fs

OPTS=""

if test ! -z "$S3_BASEURL"; then
  echo "Setting use_path_request_style because S3_BASEURL not empty"
  OPTS="$OPTS -o url=$S3_BASEURL -o use_path_request_style"
fi

if test ! -z "$DEBUG"; then
  echo "Enabling s3cmd debug output because DEBUG not empty"
  OPTS="$OPTS -d -d -f -o f2 -o curldbg"
  echo "Opts: $OPTS"
fi

echo 0.0.0.0:80 > Caddyfile
echo root /mnt >> Caddyfile
echo browse    >> Caddyfile
echo gzip      >> Caddyfile
echo startup "s3fs $S3_BUCKET /mnt $OPTS &" >> Caddyfile

echo --------- CADDYFILE ---------
cat Caddyfile
echo --------- CADDYFILE ---------

exec caddy
