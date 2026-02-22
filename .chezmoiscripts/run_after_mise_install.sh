#!/bin/bash

echo "mise install if mise is installed..."

if mise --version &> /dev/null
then
  mise install
else
  echo "mise is not installed. skip mise install."
fi
