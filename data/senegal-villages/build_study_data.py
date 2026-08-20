"""Assemble the single JSON bundle the study page renders from.

Keeps it small: coordinates rounded, boundaries Douglas-Peucker simplified,
only the fields the page actually draws.
"""
import json, sqlite3, math

# ------------------------------------------------- boundary simplification

def perp_dist(p, a, b):
    (x, y), (x1, y1), (x2, y2) = p, a, b
    dx, dy = x2 - x1, y2 - y1
    if dx == 0 and dy == 0:
        return math.hypot(x - x1, y - y1)
    t = max(0, min(1, ((x - x1)*dx + (y - y1)*dy) / (dx*dx + dy*dy)))
    return math.hypot(x - (x1 + t*dx), y - (y1 + t*dy))

def rdp(pts, eps):
    if len(pts) < 3:
        return pts
    dmax, idx = 0, 0
    for i in range(1, len(pts) - 1):
        d = perp_dist(pts[i], pts[0], pts[-1])
        if d > dmax:
            dmax, idx = d, i
    if dmax > eps:
        return rdp(pts[:idx+1], eps)[:-1] + rdp(pts[idx:], eps)
    return [pts[0], pts[-1]]

def simplify_geojson(path, eps, min_ring=8):
    d = json.load(open(path, encoding="utf-8"))
    out = []
    for f in d["features"]:
        g = f["geometry"]
        polys = [g["coordinates"]] if g["type"] == "Polygon" else g["coordinates"]
        rings = []
        for poly in polys:
            ext = [(round(c[0], 4), round(c[1], 4)) for c in poly[0]]
            s = rdp(ext, eps)
            if len(s) >= min_ring:
                rings.append([[round(x, 4), round(y, 4)] for x, y in s])
        if rings:
            out.append(dict(name=f["properties"].get("shapeName"), rings=rings))
    return out

adm1 = simplify_geojson("sen_adm1.geojson", eps=0.012)
adm2 = simplify_geojson("sen_adm2.geojson", eps=0.008)
print("adm1 rings:", sum(len(r["rings"]) for r in adm1),
      "coords:", sum(len(x) for r in adm1 for x in r["rings"]))
print("adm2 rings:", sum(len(r["rings"]) for r in adm2),
      "coords:", sum(len(x) for r in adm2 for x in r["rings"]))

# ------------------------------------------------- villages

conn = sqlite3.connect("villages.sqlite")
rows = conn.execute("""
    SELECT name, lat, lon, region_geo, department_geo, population,
           settlement, settlement_lang, religious, ethnonym, ordinal,
           patronym, patronym_group, eco, eco_kind, name_dupe_count
    FROM villages ORDER BY name
""").fetchall()

# compact village record; nulls become 0/"" to keep JSON small
V = [[r[0], round(r[1], 4), round(r[2], 4), r[3] or "", r[4] or "",
      r[5] or 0, r[6] or "", r[7] or "", r[8] or "", r[9] or "",
      r[10] or "", r[11] or "", r[12] or "", r[13] or "", r[14] or "",
      r[15] or 1] for r in rows]
VFIELDS = ["name", "lat", "lon", "region", "dept", "pop", "settlement",
           "settlement_lang", "religious", "ethnonym", "ordinal",
           "patronym", "patronym_group", "eco", "eco_kind", "dupes"]

F = json.load(open("findings.json", encoding="utf-8"))

# drop the bulky per-morpheme point lists — the page can filter V itself
for k in F.get("morphemes", {}):
    F["morphemes"][k].pop("points", None)
F.get("religious", {}).pop("points", None)
F.get("ecology", {}).pop("points", None)

bundle = dict(
    adm1=adm1, adm2=adm2,
    vfields=VFIELDS, villages=V,
    findings=F,
)
with open("study_data.json", "w", encoding="utf-8") as f:
    json.dump(bundle, f, ensure_ascii=False, separators=(",", ":"))

import os
print("villages:", len(V))
print("study_data.json KB:", round(os.path.getsize("study_data.json")/1024, 1))
conn.close()
