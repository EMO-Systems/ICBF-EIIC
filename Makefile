all: minifying.log
download.log: data/download_open_building_footprints.sh
	cd $(<D) && ./$(<F) >../$@
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
	cd $(<D) && ./$(<F) >../$@
minifying.log: minifying/minify_merged_building_footprint_data.sh\
	merge.log\
	$(addprefix minifying/, remove_duplicate_geometries.py\
	reduce_coordinate_precision.py remove_fields_from_geojson.py)
	cd $(<D) && ./$(<F) >../$@
# TODO: add MBTile step
# TODO: don't depend on placeholder logfiles
