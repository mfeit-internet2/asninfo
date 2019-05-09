#
# Makefile for ASN Info
#

default: build


#
# RIR Data
#

RIRDATA=rirdata
rir/rirdata:
	make -C rir

$(RIRDATA): rir/rirdata
	ln -s $< .
TO_CLEAN += rirdata


#
# Maxmind Data
#

MAXMINDDATA=maxminddata
maxmind/maxminddata:
	make -C maxmind

$(MAXMINDDATA): maxmind/maxminddata
	ln -s $< .
TO_CLEAN += maxminddata


#
# Merged file and database
#

# The join will pull in rows from both files even if there isn't a
# match on one side or the other.  The awk corrects rows that haven't
# joined properly.

MERGED=merged
$(MERGED): $(RIRDATA) $(MAXMINDDATA)
	./build-merged $(RIRDATA) $(MAXMINDDATA) > $@
TO_CLEAN += $(MERGED)


DATABASE=asninfo.db
$(DATABASE): $(MERGED) database.sql
	rm -f $@
	sed -e 's|__FILE__|$(MERGED)|g' database.sql \
	| sqlite3 $@
TO_CLEAN += $(DATABASE)


build: $(DATABASE)


clean distclean:
	make -C rir $@
	make -C maxmind $@
	rm -rf $(TO_CLEAN) *~

update: distclean build
