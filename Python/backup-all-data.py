#!/usr/bin/env python3

import argparse, logging, os, pathlib
from datetime import datetime

__version__ = '0.0.1'

def main():
    

    # parse all incoming arguments
    parser = argparse.ArgumentParser(description='Program to manage, rotate, and upload data to a remote')
    parser.add_argument('--version',
                        action='version',
                        version='%(prog)s {version}'.format(version=__version__))

    # parser.add_argument('integers', metavar='N', type=int, nargs='+',
    #                     help='an integer for the accumulator')
    # parser.add_argument('--sum', dest='accumulate', action='store_const',
    #                     const=sum, default=max,
    #                     help='sum the integers (default: find the max)')

    args = parser.parse_args()

    # check to make sure correct dependencies are installed
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


if __name__ == '__main__':
    main()

