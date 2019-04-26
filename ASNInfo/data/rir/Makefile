#
# Makefile for data directory
#

default: build

CURL=curl -s

NICS=\
	apnic \
	afrinic \
	arin \
	lacnic \
	ripencc

NICFILES=$(NICS:%=delegated-%-extended-latest)


# Each file has a slightly different path at the NIC, hence the custom
# versions

delegated-apnic-extended-latest:
	$(CURL) https://ftp.apnic.net/stats/apnic/delegated-apnic-extended-latest > $@

delegated-afrinic-extended-latest:
	$(CURL) https://ftp.afrinic.net/pub/stats/afrinic/delegated-afrinic-extended-latest > $@

delegated-arin-extended-latest:
	$(CURL) https://ftp.arin.net/pub/stats/arin/delegated-arin-extended-latest > $@

delegated-lacnic-extended-latest:
	$(CURL) https://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-extended-latest > $@

delegated-ripencc-extended-latest:
	$(CURL) https://ftp.ripe.net/ripe/stats/delegated-ripencc-extended-latest > $@

TO_DISTCLEAN += $(NICFILES)



RIRDATA=rirdata
$(RIRDATA): $(NICFILES)
	sed -e '/^#/d' $(NICFILES) \
	| awk '-F|' '$$3 == "asn" && $$7 ~ "(allocated|assigned)" { printf "%d|%s|%s\n", $$4, $$1, $$2 }' \
	| sort -n \
	| uniq \
	> $@
TO_CLEAN += $(RIRDATA)

build: $(RIRDATA)


### NAME=GeoLite2
### URL_BASE := http://geolite.maxmind.com/download/geoip/database
### 
### DATA_SETS := City Country ASN
### 
### DATA_DIRS := $(DATA_SETS:%=$(NAME)-%)
### 
### TARBALLS:= $(DATA_SETS:%=$(NAME)-%.tar.gz)
### .PRECOUS: $(TARBALLS)
### 
### default: build
### 
### %.tar.gz:
### 	rm -f $@.download
### 	$(CURL) -o $@.download $(URL_BASE)/$@
### 	mv -f $@.download $@
### TO_CLEAN += $(TARBALLS:%=%.download)
### TO_DISTCLEAN += $(TARBALLS)
### 
### $(NAME)-%: $(NAME)-%.tar.gz
### 	mkdir -p $@
### 	tar xzf $<
### 	rm -rf $@
### 	mv $@_* $@
### TO_CLEAN += $(DATA_DIRS) $(DATA_DIRS)_*
### 
### 
### build: $(DATA_DIRS)
### 	for DB in $(DATA_SETS) ; \
### 	do \
### 		rm -f "$${DB}.mmdb" ; \
### 		ln -s "$(NAME)-$${DB}/$(NAME)-$${DB}.mmdb" . ; \
### 	done
### TO_CLEAN += $(DATA_SETS:%=$(NAME)-%.mmdb)
### 
### 

clean:
	rm -rf $(TO_CLEAN) *~

distclean: clean
	rm -rf $(TO_DISTCLEAN)
