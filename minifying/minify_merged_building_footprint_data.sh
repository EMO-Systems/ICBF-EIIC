rm -r minified_building_footprints
mkdir minified_building_footprints

ABBREVIATIONS='AB BC MB NB NL NS NW NU ON PE QC SK YT'
ABBREVIATIONS=($ABBREVIATIONS)
DECIMALS=6
FIELDS_TO_DROP="Longitude,Latitude,Build_ID,Shape_Leng,Shape_Area"

for i in $(seq ${#ABBREVIATIONS[@]});
do
    ABRV=${ABBREVIATIONS[$i - 1]}
    ABRVLC=$(echo "${ABRV}" | tr '[:upper:]' '[:lower:]')
    # Get a copy of the merged data from where it was put automatically
    unzip ../merge/merge/${ABRVLC}_odb_osm_ms.zip -d .
    PREFIX=odb_osm_ms_merged_building_footprints_${ABRV}
    python reduce_coordinate_precision.py merge/output/${PREFIX}.geojson $DECIMALS
    python remove_fields_from_geojson.py ${PREFIX}_reduce_coord_precision.geojson $FIELDS_TO_DROP
    python remove_duplicate_geometries.py ${PREFIX}_reduce_coord_precision_removed_fields.geojson
    mv unique_${PREFIX}_reduce_coord_precision_removed_fields.geojson ./minified_building_footprints/${ABRV}.geojson
    # Clean up intermediate files
    rm ${PREFIX}_reduce_coord_precision_removed_fields.geojson
    rm ${PREFIX}_reduce_coord_precision.geojson
    rm -rf merge/output
done

exit $?