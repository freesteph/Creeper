## Process this file with automake to produce Makefile.in
## Created by Anjuta

SUBDIRS = src 

creeperdocdir = ${prefix}/doc/creeper
creeperdoc_DATA = \
	README \
	COPYING \
	AUTHORS \
	NEWS


EXTRA_DIST = $(creeperdoc_DATA)


# Remove doc directory on uninstall
uninstall-local:
	-rm -r $(creeperdocdir)
