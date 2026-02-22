#!/bin/bash

if mise --version &> /dev/null
then
  mise install
else
  echo "mise is not installed. skip mise install."
fi
