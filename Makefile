all: minifying.log
download.log: data/download_open_building_footprints.sh
	cd $(<D) && bash $(<F) >../$@
preprocessing.log: preprocessing.sh download.log
	./$< >$@
preprocessing/preprocessed_ms.zip:\
	preprocessing/merge_and_split.py\
	preprocessing.log
	cd $(<D) && python merge_and_split.py input/ms split/lpr_000a21a_e.shp PRUID
	cd $(<D) && zip preprocessed_ms.zip output/*.geojson
	cd $(<D) && rm output/*.geojson
preprocessing/preprocessed_osm.zip:\
	preprocessing/merge_and_split.py\
	preprocessing.log
	python extract-shapefiles.py
	cd $(<D) && python merge_and_split.py input/osm split/lpr_000a21a_e.shp PRUID
	cd $(<D) && zip preprocessed_osm.zip output/*.geojson
	cd $(<D) && rm output/*.geojson
merge.log: merge/odb_osm_ms_building_footprint_merge.sh\
	merge/Merge.py\
	preprocessing/preprocessed_osm.zip\
	preprocessing/preprocessed_ms.zip
	cd $(<D) && bash $(<F) >../$@
minifying.log: minifying/minify_merged_building_footprint_data.sh\
	merge.log\
	$(addprefix minifying/, remove_duplicate_geometries.py\
	reduce_coordinate_precision.py remove_fields_from_geojson.py)
	cd $(<D) && bash $(<F) >../$@
# TODO: add MBTile step
# TODO: don't depend on placeholder logfiles
clean:
	-rm merge.log
	-rm -rf merge/merge
	-rm minifying.log
	-rm -rf minifying/merge
	-rm -rf minifying/minified_building_footprints
	-rm preprocessing.log
	-rm -rf preprocessing/input
	-rm -rf preprocessing/output
	-rm -rf preprocessing/split
	-rm preprocessing/preprocessed_ms.zip
	-rm preprocessing/preprocessed_osm.zip
dataclean: clean
	-rm download.log
	-rm -rf data/lcsd000b21a_e
	-rm -rf data/lda_000b21a_e
	-rm -rf data/lpr_000a21a_e
	-rm -rf data/ms
	-rm -rf data/odb
	-rm -rf data/osm
	-rm -rf data/correspondance
