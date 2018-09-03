#!/usr/bin/env bash

mvn clean package -Pprod -Dmaven.test.skip=true -Dproject.build.directory=/data