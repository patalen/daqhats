#!/bin/bash

if [ "$(id -u)" == "0" ]; then
   echo "This script must NOT be run as root. It's for uninstalling from a Python virtualenv." 1>&2
   exit 1
fi

# Remove the C library and headers
echo "Removing shared library"
echo
make -C lib uninstall
echo

# Removed compiled examples
echo "Removing compiled examples"
echo
make -C examples/c clean
echo

# Remove tools
echo "Removing tools"
echo
make -C tools uninstall
echo

# Remove the Python packages

num=$(pip2 show daqhats | wc -l)
if [ "$num" -ne 0 ]; then
    echo "Removing Python 2 package"
    pip2 uninstall daqhats -y
    echo
fi

num=$(pip3 show daqhats | wc -l)
if [ "$num" -ne 0 ]; then
    echo "Removing Python 3 package"
    pip3 uninstall daqhats -y
    echo
fi

echo "Uninstall complete. Remove this folder to completely remove daqhats."
