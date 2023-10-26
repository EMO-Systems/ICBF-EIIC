all: minifying.log
download.log: data/download_open_building_footprints.sh
	cd $(<D) && bash $(<F) >../$@
preprocessing.log: preprocessing.sh download.log
	bash $< >$@
preprocessing/preprocessed_osm.zip preprocessing/preprocessed_ms.zip:\
	preprocessing/merge_and_split_preprocessing.sh preprocessing.log\
	preprocessing/merge_and_split.py
	cd $(<D) && bash $(<F)
merge.log: merge/odb_osm_ms_building_footprint_merge.sh\
	merge/Merge.py\
	preprocessing/preprocessed_osm.zip\
	preprocessing/preprocessed_ms.zip
	python extract-shapefiles.py
	cd $(<D) && bash $(<F) >../$@
minifying.log: minifying/minify_merged_building_footprint_data.sh\
	merge.log\
	$(addprefix minifying/, remove_duplicate_geometries.py\
	reduce_coordinate_precision.py remove_fields_from_geojson.py)
	cd $(<D) && bash $(<F) >../$@
# TODO: add MBTile step
# TODO: don't depend on placeholder logfiles
