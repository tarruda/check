bin_SCRIPTS = checkmk
TESTS = test/check_checkmk
EXTRA_DIST = test examples doc/checkmk.sgml doc/checkmk.1
CLEANFILES = checkmk-*.tar.gz checkmk-*.tar.bz2 *~ test/*~ test/*/*~
CONFIG_STATUS_DEPENDENCIES = checkmk.in

man_MANS = doc/checkmk.1
if DO_MANS
doc/checkmk.1: doc/checkmk.sgml
	cd doc && $(DOCBOOK2MAN) checkmk.sgml
endif

clean-local:
	rm -rf test.out

dist-hook:
	rm -rf `find $(distdir)/ -name '.svn'`
