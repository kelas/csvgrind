kpc=https://kparc.io

taxi:
	./taxi.sh
	q taxi.q

taq:
	./taq.sh
	q taq.q

get:
	curl $(kpc)/csvgrind/taq.csv.gz > csv/taq.csv.gz
	curl $(kpc)/csvgrind/taxi.csv.gz > csv/taxi.csv.gz

unz:
	gunzip -k csv/*.gz

#:~
