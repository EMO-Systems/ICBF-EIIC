all: preprocessing.log
preprocessing.log: preprocessing.sh
	bash $< >$@
