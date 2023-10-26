mkdir -p merge/output
rm -f merge/output/*

# Process Manitoba Data:
echo Processing Manitoba data ...
python Merge.py mb ../data/osm/mb/gis_osm_buildings_a_free_1.shp ../data/ms/mb/Manitoba.geojson ../data/lcsd000b21a_e/lcsd000b21a_e.shp

zip -ro merge/mb_odb_osm_ms.zip merge/output/
rm -f merge/output/*

# Process Saskatchewan Data:
echo Processing Saskatchewan data ...
python Merge.py sk ../data/odb/sk/ODB_Saskatchewan/odb_saskatchewan.shp ../data/osm/sk/gis_osm_buildings_a_free_1.shp ../data/ms/sk/Saskatchewan.geojson ../data/lcsd000b21a_e/lcsd000b21a_e.shp

zip -ro merge/sk_odb_osm_ms.zip merge/output/
rm -f merge/output/*
