#!/usr/bin/env /usr/bin/python3

import os
import re
#import click
import sys
#import logbook


def run():
    """ locate failed tests, extract corresponding level lines then generate a new level_crystal with all those failed
        level_crystal is under param batch, default ./
        example: cd <your batch> 
                 ./crystallize_level.py
    """
    for f in os.listdir("."):
        if f.endswith(".tar"): 
            cmd = "mkdir " + os.path.splitext(f)[0] + ";tar -C " + os.path.splitext(f)[0] + " -xvf " + f
            print(cmd, "=>", os.path.splitext(f)[0])
            os.system(cmd)


if __name__ == '__main__':
    run()

