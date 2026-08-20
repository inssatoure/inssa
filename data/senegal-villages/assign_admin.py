"""Assign every village its real region + department by point-in-polygon
against geoBoundaries ADM1/ADM2 polygons. No shapely in this env, so
ray-casting with a bbox prefilter."""
import json, sqlite3

def rings_of(geom):
    """Yield exterior/interior ring coordinate lists for Polygon/MultiPolygon."""
    t = geom["type"]
    if t == "Polygon":
        yield geom["coordinates"]
    elif t == "MultiPolygon":
        for poly in geom["coordinates"]:
            yield poly

def point_in_ring(x, y, ring):
    inside = False
    n = len(ring)
    j = n - 1
    for i in range(n):
        xi, yi = ring[i][0], ring[i][1]
        xj, yj = ring[j][0], ring[j][1]
        if ((yi > y) != (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi + 1e-18) + xi):
            inside = not inside
        j = i
    return inside

def point_in_poly(x, y, poly):
    """poly = [exterior, hole1, hole2...]"""
    if not point_in_ring(x, y, poly[0]):
        return False
    for hole in poly[1:]:
        if point_in_ring(x, y, hole):
            return False
    return True

def load(path, key="shapeName"):
    d = json.load(open(path, encoding="utf-8"))
    out = []
    for f in d["features"]:
        name = f["properties"].get(key)
        polys = list(rings_of(f["geometry"]))
        # bbox prefilter per feature
        xs = [c[0] for p in polys for r in p for c in r]
        ys = [c[1] for p in polys for r in p for c in r]
        out.append((name, polys, min(xs), min(ys), max(xs), max(ys)))
    return out

def locate(lon, lat, feats):
    for name, polys, x0, y0, x1, y1 in feats:
        if not (x0 <= lon <= x1 and y0 <= lat <= y1):
            continue
        for poly in polys:
            if point_in_poly(lon, lat, poly):
                return name
    return None

adm1 = load("sen_adm1.geojson")
adm2 = load("sen_adm2.geojson")
print(f"loaded {len(adm1)} regions, {len(adm2)} departments")

conn = sqlite3.connect("villages.sqlite")
c = conn.cursor()
for col in ("region_geo", "department_geo"):
    try:
        c.execute(f"ALTER TABLE villages ADD COLUMN {col} TEXT")
    except sqlite3.OperationalError:
        pass

rows = c.execute("SELECT geonameid, lat, lon FROM villages").fetchall()
updates, miss_r, miss_d = [], 0, 0
for gid, lat, lon in rows:
    r = locate(lon, lat, adm1)
    d = locate(lon, lat, adm2)
    if r is None: miss_r += 1
    if d is None: miss_d += 1
    updates.append((r, d, gid))

c.executemany("UPDATE villages SET region_geo=?, department_geo=? WHERE geonameid=?", updates)
conn.commit()
n = len(rows)
print(f"region  assigned: {n-miss_r}/{n} ({100*(n-miss_r)/n:.1f}%)")
print(f"dept    assigned: {n-miss_d}/{n} ({100*(n-miss_d)/n:.1f}%)")
print("\ndepartments by village count:")
for row in c.execute("SELECT department_geo, COUNT(*) FROM villages WHERE department_geo IS NOT NULL GROUP BY 1 ORDER BY 2 DESC LIMIT 12"):
    print(f"  {row[1]:5d}  {row[0]}")
conn.close()
