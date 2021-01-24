#!/usr/bin/env python3

import argparse
from datetime import datetime


def main():
    
    all_tools_installed = True
    if not is_tool("borg"):
        all_tools_installed = False
        print("borg not installed, please install borg backup")
    if not is_tool("rclone"):
        all_tools_installed = False
        print("rclone not installed, please install rclone")
    if not all_tools_installed:
        exit(1)



def is_tool(name):
    """Check whether `name` is on PATH and marked as executable."""

    # from whichcraft import which
    from shutil import which

    return which(name) is not None


if __name__ == "main":
    main()

