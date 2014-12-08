### Geos Woes

While using a PostgreSQL DB with PostGIS support I ran into problems with a DB column type 'geometry'.
There was an ActiveRecord validation on the column to ensure it wasn't nil, which a large portion of my specs started throwing.

Digging deeper we found that the postgres adapter `activerecord-postgis-adapter-0.6.5/lib/active_record/connection_adapters/postgis_adapter/rails3/spatial_column.rb:179` attempts to parse the geometry string before persisting it to the database, if there's an error it rescues it and returns nil. Not the most helpful result.

Looking at why the parsing exploaded we found that in `ffi-geos-0.5.0/lib/ffi-geos.rb:983` we call `geos_library_path` which returns nil so the returned factory can't use the geo library to parse the string.

Thankfully ffi-geos checks for `GEOS_LIBRARY_PATH` if the geos library is not in the expected place.
To get it working I set `GEOS_LIBRARY_PATH=/opt/boxen/homebrew/Cellar/geos/3.4.2/lib/` not sure where the actualy fix should live.
