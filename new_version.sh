#!/bin/bash

set -e
set -x

if [ $# -eq 0 ]
then
  echo 'not enough arguments'
  exit 1
fi

RELEASE="$1"
BASEDIR="$(readlink -f "$(dirname "$0")")"
PROJECT="muflone-rendered"
DESTLINK="${BASEDIR}/data/muflone.com"

# Download new release archive
curl -L "https://github.com/muflone/${PROJECT}/archive/${RELEASE}.tar.gz" \
     -o "${BASEDIR}/${RELEASE}.tar.gz"
tar xzf "${BASEDIR}/${RELEASE}.tar.gz" -C "${BASEDIR}/data"
rm "${BASEDIR}/${RELEASE}.tar.gz"

#docker stop nginx
if [ -h "${DESTLINK}" ]
then
  rm "${DESTLINK}"
fi
ln -s "${PROJECT}-${RELEASE}" "${DESTLINK}"
chown -R 101:101 "${BASEDIR}/data/${PROJECT}-${RELEASE}"
#docker start nginx
