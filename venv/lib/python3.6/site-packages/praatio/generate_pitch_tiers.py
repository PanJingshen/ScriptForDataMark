'''
Created on Dec 12, 2016

Generates a 3 by 3 matrix of resynthesized audio files according to
three different parameters--pitch height, peak location, and 
plateau size.

See below for parameters to configure the script behavior.

To run, include this script in the folder containing wav files and their
associated pitch files (the pitch files should be stylized with 5 points
(utterance start, focus start, focus peak, focus end, utterance end).
Launch this in python or python IDLE and it should create a subfolder
called 'resynthesized_wavs'.

REQUIREMENTS:
python 2.x/3.x
praatio - https://github.com/timmahrt/praatIO

@author: Tim Mahrt
'''

import os
from os.path import join

import dataio
import praat_scripts
from utilities import utils

########
# Script parameters
########

# Raise or lower peak by given amount (in Hz)
heightIncrList = [-80, -40, 0, 40, 80]

# Shift focus contour left or right (in seconds)
shiftIncrList = [-0.08, -0.04, 0, 0.04, 0.08]

# Stretch peak into a plateau of the given duration (in seconds)
plateauIncrList = [-0.08, -0.04, 0, 0.04, 0.08]

praatEXE = r"C:\Praat.exe"

minPitch = 75
maxPitch = 350

rootFolder = r"C:\Users\Tim\Desktop\blahblah"

########
# You don't need to change anything past this point
########


def toStr(inputNum):
    if inputNum < 0:
        retStr = '%02d' % inputNum
    else:
        retStr = '+%02d' % inputNum
    
    return retStr


def createdResynthesizedWavs(inputWavFN, inputPitchFN):
    
    inputPath, fn = os.path.split(inputPitchFN)
    outputPath = join(inputPath, "resynthesized_wavs")
    utils.makeDir(outputPath)

    # Get stylized pitch contour
    pitchTier = dataio.open2DPointObject(inputPitchFN)
    pointList = pitchTier.pointList
    
    # It should only have 5 points in it
    print len(pointList)
    assert(len(pointList) == 5)

    return
    
    outputFN = join(outputPath,
                    os.path.splitext(fn)[0] + "_s%s_h%s_p%s")
    
    for heightAmount in heightIncrList:
        for shiftAmount in shiftIncrList:
            for plateauAmount in plateauIncrList:
                
                # Get labeled points
                utteranceStart = pointList[0]
                leftEdge = pointList[1]
                peak = pointList[2]
                rightEdge = pointList[3]
                utteranceEnd = pointList[4]
                
                # MANIPULATION 1: Adjust peak height
                peak = [peak[0], peak[1] + heightAmount]
                
                # Create focused contour
                subPointList = [leftEdge, peak, rightEdge]
                
                # MANIPULATION 2: Add a plateau
                if plateauAmount != 0:
                    plateauPoint = [peak[0] + plateauAmount,
                                    peak[1]]
                    if plateauAmount < 0:
                        insertI = 1  # Plateau comes before peak
                    else:
                        insertI = 2  # Plateau comes after peak
                    subPointList.insert(insertI, plateauPoint)
                
                # MANIPULATION 3: Shift contour
                subPointList = [(time + shiftAmount, pitch)
                                for time, pitch in subPointList]
                
                # Reconstruct 5-point pitch value list and output point object
                outputPointList = ([utteranceStart, ] + subPointList +
                                   [utteranceEnd, ])
                
                pointObj = dataio.PointObject2D(outputPointList,
                                                pitchTier.objectClass,
                                                pitchTier.minTime,
                                                pitchTier.maxTime)
                
                outputName = outputFN % (toStr(shiftAmount * 1000),
                                         toStr(heightAmount),
                                         toStr(plateauAmount * 1000))
                pitchOutputFN = outputName + ".PitchTier"
                
                pointObj.save(pitchOutputFN)
                
                # Resynthesize the wav file
                wavOutputFN = outputName + ".wav"
                praat_scripts.resynthesizePitch(praatEXE, inputWavFN,
                                                pitchOutputFN, wavOutputFN,
                                                minPitch, maxPitch)


def run(rootFolder):
    
    if rootFolder == '.':
        rootFolder = os.getcwd()
    fnList = os.listdir(rootFolder)
    for fn in fnList:
        name, ext = os.path.splitext(fn)
        
        if ext != ".PitchTier":
            continue
        
        if name + ".wav" not in fnList:
            print("No corresponding wav file for '%s'" % fn)
            continue
        
        wavFN = join(rootFolder, name + ".wav")
        pitchFN = join(rootFolder, name + ".PitchTier")
        
        createdResynthesizedWavs(wavFN, pitchFN)


if __name__ == "__main__":

    run(rootFolder)
