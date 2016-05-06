#!/bin/bash

echo "Europe/Dublin" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
