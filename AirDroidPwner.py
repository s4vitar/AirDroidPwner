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
SHODAN_API_KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
api = shodan.Shodan(SHODAN_API_KEY)

def handler(signum, frame):

        print '\nExiting...\n'
        os.system('setterm -cursor on')
        sys.exit(0)

def checkurl(ips_array):

        available_urls = []

        for hosts in ips_array:

                url = "http://" + hosts + ":8888/"

		try:
                        url_check_status = requests.get(url, verify=False, timeout=3)

                        if url_check_status.status_code == 200:
                                available_urls.append(url)
                except:
                        pass

        return available_urls

def get_IPS(ips_array):

        try:
        	results = api.search('Airdroid')
        except shodan.APIError, error:
        	print 'Error: {0}'.format(error)

        ips = []

        for result in results['matches']:
        	ips.append("{0}".format(result['ip_str']))

        for ip in ips:
                ips_array.append(ip)

def format_available_urls(available_urls):
        for host in available_urls:
                print "URL Disponible: " + host + '\n'

if __name__ == '__main__':

	signal.signal(signal.SIGINT, handler)
        os.system('setterm -cursor off')

	available_urls = []

        print "\n[*] Obteniendo listado de IPs...\n"

	# Recopilamos todas las IPs listadas desde Shodan para Airdroid
        ips_array = []
        get_IPS(ips_array)

        print "[*] Número total de IPs obtenidas:", len(ips_array)
        time.sleep(2)

        print "\n[*] Comprobando la disponibilidad web... [Este proceso puede tardar un poco, relájate y toma un café mientras :P]\n"
        time.sleep(2)

        available_urls = checkurl(ips_array)

        print "\n[*] Listando direcciones IP con el servicio AirDroid corriendo...\n"
        time.sleep(2)

        format_available_urls(available_urls)

        os.system('setterm -cursor on')
