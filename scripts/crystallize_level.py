#!/usr/bin/env /home/tools/anaconda3/bin/python

import os
import re
import click
import sys
#import logbook


@click.command()
@click.option(
    '-b',
    '--batch',
    default='./',
    help='path to batch for analyzation',
)
def run(batch):
    """ locate failed tests, extract corresponding level lines then generate a new level_crystal with all those failed
        level_crystal is under param batch, default ./
        example: cd <your batch> 
                 ./crystallize_level.py
    """
    levelHunter = LevelHunter(batch)
    levelHunter.m_GetLevel()

class LevelHunter(object):
    def __init__(self, batch):
        print('batch is %s' % batch)
        self.resultFile = None 
        self.resultPath = batch 
        self.resultFileName = batch + "/results.html"
        self.lvlFileName = batch + "/level_crystal"
        self.testMatch = re.compile(r'.*failed.*\/home(.*) \(.*')

    def m_GetLevel(self):
        if self.resultFile is None:
            try:
                self.resultFile = open(self.resultFileName)
                lvlFile = open(self.lvlFileName, "w")
                for line in self.resultFile.readlines():
                    matchObj = re.match(self.testMatch, line)
                    if matchObj is not None:
                        testName = "/home" + matchObj.group(1)
                        print(testName)
                        cwd = os.getcwd()
                        os.chdir(testName)
                        rawInfo =os.popen("/home/edwardc/bin/ti '{raw_info}'")
                        cleanRawInfo = rawInfo.readlines()[0]
                        os.chdir(cwd)

                        #try:
                        #lvlFile = open(self.lvlFileName, "w")
                        print("[tracepath{}]\n[", file=lvlFile)
                        print(cleanRawInfo, file=lvlFile)
                        print("];\n", file = lvlFile)
                        #break
            except IOError as e:
                print("cannot open " , self.resultFileName)
                raise e;
            except:
                print("still wrong")
                raise
            finally:
                self.resultFile.close()
                lvlFile.close()

if __name__ == '__main__':
    run()

