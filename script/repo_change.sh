#!/bin/bash

#Задаем правильный URL для репозитория.
REPO_PATH="mirrorlist=https://repo.opensciencegrid.org/mirror/osg/3.4/el6/release/$basearch"

sed -i "s/^mirrorlist.*/${REPO_PATH}/" /etc/yum.repos.d/osg-el6.repo
