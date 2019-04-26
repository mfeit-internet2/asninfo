#
# Makefile for Maxmind data directory
#

default: build

CURL=curl -s

ZIP=GeoLite2-ASN-CSV.zip
DIR=$(shell basename -s .zip "$(ZIP)")

$(ZIP):
	$(CURL) https://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN-CSV.zip > $@
TO_DISTCLEAN += $(ZIP)


MAXMINDDATA=maxminddata
$(MAXMINDDATA): $(ZIP)
	unzip $(ZIP)
	find $(DIR)_* -name "*.csv" -print0 \
	| xargs -0 cat \
	| tr -d '|' \
	| sed -e '1d; s/^[^,]*,//g; s/^\([0-9]*\),/\1|/g; s/"//g' \
	| sort -n \
	| uniq \
	| awk '-F|' 'NF == 2 { print }' \
	> $@
TO_CLEAN += $(MAXMINDDATA) $(DIR)_*


build:  $(MAXMINDDATA)


clean:
	rm -rf $(TO_CLEAN) *~

distclean: clean
	rm -rf $(TO_DISTCLEAN)
