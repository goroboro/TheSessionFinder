#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from tempfile import mkstemp
from subprocess import call
import pyotherside

def get_data(tune,key,type,abc,id):
    #first check if we already created the svg for this file
    svgpath='/tmp/'+str(id)+'001.svg'
    if not os.path.isfile(svgpath):
        #format the tune data into something that we can store temporarily as an abc file
        abctext="X:1\nT:{title}\nR:{type}\nK:{key}\n{abc}".format(title=tune,type=type,key=key,abc=abc)
        #create a tempfile for this and write to the file
        tmpfd,tmppath=mkstemp()
        fd=open(tmpfd,'w')
        fd.write(abctext)
        fd.close()
        #now convert that file into an svg using abcm2ps and store it in a temporary location
        call(['abcm2ps','-g','-l',tmppath,'-O','/tmp/'+str(id)])
        # would be good to change this to a cache path inside the user dir
        # finally remove the original temp abc file
        os.remove(tmppath)
    #now return the svgpath to our qml page
    return svgpath


