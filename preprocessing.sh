mkdir -p scratch
cp preprocessing/* scratch
cd scratch
mkdir -p input output input/osm input/ms split
cp ../data/osm/*.zip input/osm
find ../data/ms -name '*geojson' -exec cp '{}' input/ms \;
cp ../data/lpr_000a21a_e/* split
