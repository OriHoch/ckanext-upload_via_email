#!/usr/bin/env bash

VERSION_LABEL="${1}"

[ "${VERSION_LABEL}" == "" ] \
    && echo Missing version label \
    && echo current VERSION.txt = $(cat VERSION.txt) \
    && exit 1

! python --version 2>&1 | grep 'Python 2.7' && echo invalid Python version && exit 1
! python -m pip install --upgrade pip==20.1.1 && echo invalid Pip version && exit 1
! python -m pip install --upgrade setuptools==44.0.0 wheel==0.34.2 && echo invalid Setuptools or wheel versions && exit 1

rm -rf ckanext/upload_via_email/pipelines/data

echo "${VERSION_LABEL}" > VERSION.txt &&\
python setup.py sdist &&\
twine upload dist/ckanext-upload_via_email-${VERSION_LABEL}.tar.gz &&\
echo ckanext-upload_via_email-${VERSION_LABEL} &&\
echo Great Success &&\
exit 0

exit 1
