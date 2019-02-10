#!/usr/bin/python
#coding: utf-8

# Autor: Marcelo Vázquez (aka s4vitar)

import webbrowser, signal, os, time

def handler(signum, frame):

        print '\nSaliendo...\n'
        os.system('setterm -cursor on')
        sys.exit(0)

if __name__ == '__main__':
	signal.signal(signal.SIGINT, handler)
	os.system('setterm -cursor off')

	print "\n[*] Comprobando si el fichero 'ips' existe...\n"
	time.sleep(2)

	file_existence = os.path.isfile('ips')

	if file_existence == True:

		urls = []

		with open('ips') as url:
			urls = url.read().splitlines()

		for domain in urls:
			webbrowser.open(domain)

		os.system('setterm -cursor on')
	else:
		print "[*] No se ha detectado ningún fichero 'ips'"
		time.sleep(1)
		print "\n[*] Por favor, corre primero el script 'AirDroidPwner.py'"
		time.sleep(1)

