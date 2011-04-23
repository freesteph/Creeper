## Process this file with automake to produce Makefile.in

## Created by Anjuta


uidir = $(datadir)/creeper/ui
ui_DATA = main.ui


AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(prefix)/$(DATADIRNAME)/locale"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(datadir)"\" \
	-DWNCK_I_KNOW_THIS_IS_UNSTABLE \
	$(CREEPER_CFLAGS)

AM_CFLAGS =\
	 -Wall\
	 -g

VALAFLAGS =  \
	--pkg gtk+-3.0 \
	--pkg libwnck-3.0 \
	--pkg gee-1.0 \
	--vapidir . \
	--pkg config

bin_PROGRAMS = creeper

creeper_SOURCES = \
	creeper-main.vala \
	creeper-activity.vala \
	creeper-activity-tree.vala \
	creeper-utils.vala

creeper_LDFLAGS = \
	-Wl,--export-dynamic

creeper_LDADD = $(CREEPER_LIBS)


EXTRA_DIST = $(ui_DATA)

# Remove ui directory on uninstall
uninstall-local:
	-rm -r $(uidir)
	-rm -r $(datadir)/creeper
