#!/bin/sh

#
# Take ownership of files and directories under /config.
#

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

take-ownership /u01/oracle/user_projects

# vim:ft=sh:ts=4:sw=4:et:sts=4
