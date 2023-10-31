rm -r minified_building_footprints
mkdir minified_building_footprints

unzip ../merge/merge/mb_odb_osm_ms.zip -d .
prefix=odb_osm_ms_merged_building_footprints_MB
python reduce_coordinate_precision.py merge/output/${prefix}.geojson 7
python remove_fields_from_geojson.py ${prefix}_reduce_coord_precision.geojson "Longitude,Latitude,Build_ID,Shape_Leng,Shape_Area"
python remove_duplicate_geometries.py ${prefix}_reduce_coord_precision_removed_fields.geojson

mv unique_${prefix}_reduce_coord_precision_removed_fields.geojson ./minified_building_footprints/MB.geojson
rm ${prefix}_reduce_coord_precision_removed_fields.geojson
rm ${prefix}_reduce_coord_precision.geojson
rm -rf merge/output

unzip ../merge/merge/sk_odb_osm_ms.zip -d .
prefix=odb_osm_ms_merged_building_footprints_SK
python reduce_coordinate_precision.py merge/output/${prefix}.geojson 7
python remove_fields_from_geojson.py ${prefix}_reduce_coord_precision.geojson "Longitude,Latitude,Build_ID,Shape_Leng,Shape_Area"
python remove_duplicate_geometries.py ${prefix}_reduce_coord_precision_removed_fields.geojson

mv unique_${prefix}_reduce_coord_precision_removed_fields.geojson ./minified_building_footprints/SK.geojson
rm ${prefix}_reduce_coord_precision_removed_fields.geojson
rm ${prefix}_reduce_coord_precision.geojson
rm -rf merge/output