cd preprocessing
# Create required directories
mkdir -p input output input/osm input/ms split
# Note: copying these files creates a very large requirement for space
# It is done to be careful, but might not be required with some refactoring
# Copy the downloaded input data
cp ../data/osm/*.zip input/osm
find ../data/ms -name '*geojson' -exec cp '{}' input/ms \;
# Copy the downloaded provincial boundaries
cp ../data/lpr_000a21a_e/* split
