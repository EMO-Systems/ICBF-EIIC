# Census Subdivisions
CENSUS_GEO=../data/lcsd000b21a_e/lcsd000b21a_e.shp
# Census Dissemination Areas
CENSUS_GEO=../data/lda_000b21a_e/lda_000b21a_e.shp
mkdir -p merge/output
rm -f merge/output/*

FULLNAMES='Alberta BritishColumbia Manitoba NewBrunswick NewfoundlandandLabrador NovaScotia NorthwestTerritories Nunavut Ontario PrinceEdwardIsland Quebec Saskatchewan YukonTerritory'
FULLNAMES=($FULLNAMES)
ABBREVIATIONS='ab bc mb nb nl ns nw nu on pe qc sk yt'
ABBREVIATIONS=($ABBREVIATIONS)

for i in $(seq ${#FULLNAMES[@]});
do
    ABRV=${ABBREVIATIONS[$i - 1]}
    FULL=${FULLNAMES[$i - 1]}
    FULLLC=$(echo "${FULL}" | tr '[:upper:]' '[:lower:]')
    ODB=../data/odb/${ABRV}/ODB_${FULL}/odb_${FULLLC}.shp 
    OSM=../data/osm/${ABRV}/gis_osm_buildings_a_free_1.shp 
    MS=../data/ms/${ABRV}/${FULL}.geojson 
    echo "Processing ${FULL} data ..."
    if [[ -e $ODB ]]; then
        Python Merge.py ${ABRV} $ODB $OSM $MS $CENSUS_GEO
    else
        Python Merge.py ${ABRV} $OSM $MS $CENSUS_GEO
    fi
    zip -ro merge/${ABRV}_odb_osm_ms.zip merge/output
    rm -f merge/output/*
done
