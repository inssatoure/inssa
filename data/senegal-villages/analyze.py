"""
Toponymic analysis of Senegal's village names.

Reads villages.sqlite, normalises spelling variants, tags each name against
a glossed morpheme lexicon, and computes the study findings into
findings.json.

Every gloss carries a confidence level. Low-confidence glosses are reported
as such and must not be presented as established fact.
"""
import sqlite3, json, re, math, collections, unicodedata

DB = "villages.sqlite"

# ---------------------------------------------------------------- normalise

def strip_accents(s):
    return "".join(ch for ch in unicodedata.normalize("NFD", s)
                   if unicodedata.category(ch) != "Mn")

def norm(s):
    """Accent-free lowercase, for variant matching only. Display uses raw."""
    return strip_accents(s).lower().strip()

def tokens(name):
    return [t for t in re.split(r"[\s\-']+", name) if t]

# ---------------------------------------------------------------- lexicon
# conf: high = confident gloss; med = probable; low = tentative, flagged in UI

# Settlement-type morphemes. These are the isogloss backbone: several are
# near-synonyms ("home/village of") in different languages, so their
# geography separates languages rather than meanings.
SETTLEMENT = {
    "keur":     dict(lang="Wolof",    gloss='"house / home of" + founder name', conf="high",  pos="initial",
                     variants=["keur", "kher"]),
    "sare":     dict(lang="Pulaar",   gloss='"homestead / compound of"',        conf="high",  pos="initial",
                     variants=["sare", "sarre"]),
    "sinthiou": dict(lang="Pulaar",   gloss='"new settlement"',                 conf="high",  pos="initial",
                     variants=["sinthiou", "sintiou", "sinntiou", "santiou",
                               "santhiou", "sintian", "sinthian", "sintiane"]),
    "ouro":     dict(lang="Pulaar",   gloss='"village" (wuro)',                 conf="high",  pos="initial",
                     variants=["ouro", "wuro", "oure"]),
    "gourel":   dict(lang="Pulaar",   gloss='"hamlet / small settlement"',      conf="high",  pos="initial",
                     variants=["gourel", "gorel"]),
    "kounda":   dict(lang="Mandinka", gloss='"home of" (-kunda suffix)',        conf="high",  pos="final",
                     variants=["kounda", "kunda"]),
    "belel":    dict(lang="Pulaar",   gloss="pastoral settlement / clearing",   conf="med",   pos="initial",
                     variants=["belel", "bellel"]),
    "loumbel":  dict(lang="Pulaar",   gloss="hamlet / locality",                conf="med",   pos="initial",
                     variants=["loumbel", "loumbi"]),
    "medina":   dict(lang="Arabic>Wolof", gloss='"town" (madina)',              conf="high",  pos="initial",
                     variants=["medina", "madina", "medine"]),
}

# Sufi / Islamic toponyms. Mouride and Tijani settlement leaves a heavy mark.
RELIGIOUS = {
    "darou":   dict(gloss='Arabic dar "abode of" — strongly Mouride', conf="high",
                    variants=["darou", "daroul", "darou salam", "dar"]),
    "touba":   dict(gloss='Arabic tuba "blessedness" — Mouride holy-city naming', conf="high",
                    variants=["touba"]),
    "madina":  dict(gloss="Medina — the Prophet's city", conf="high",
                    variants=["madina", "medina", "medine"]),
    "taiba":   dict(gloss='Arabic tayyiba "the good" — epithet of Medina', conf="high",
                    variants=["taiba", "tayba"]),
    "missira": dict(gloss="mosque settlement (masjid / Misra)", conf="med",
                    variants=["missira", "missirah", "misira"]),
    "maka":    dict(gloss="Mecca", conf="high", variants=["maka", "makka", "mecca"]),
    "serigne": dict(gloss="Wolof title for a marabout / religious leader", conf="high",
                    variants=["serigne", "serign"]),
    "cheikh":  dict(gloss="Arabic shaykh — religious leader", conf="high",
                    variants=["cheikh", "cheik", "chekh"]),
    "nguabou": dict(gloss="uncertain", conf="low", variants=[]),
}

# Ethnonyms used as a village-name qualifier ("Ngane Wolof" vs "Ngane Sérèr").
ETHNONYMS = {
    "peul":       "Peul (Fulani)",
    "peulh":      "Peul (Fulani)",
    "serer":      "Sérèr",
    "serere":     "Sérèr",
    "ouolof":     "Wolof",
    "wolof":      "Wolof",
    "bambara":    "Bambara",
    "diola":      "Diola (Jola)",
    "maure":      "Maure",
    "soce":       "Socé (Mandinka)",
    "sarakole":   "Sarakolé (Soninke)",
    "toucouleur": "Toucouleur (Haalpulaar)",
    "laobe":      "Laobé",
    "bassari":    "Bassari",
    "malinke":    "Malinké",
    "mandingue":  "Mandingue",
    "diakhanke":  "Diakhanké",
}

# Settlement fission markers (daughter villages, mostly colonial-administrative)
ORDINALS = {
    "un": "1", "deux": "2", "trois": "3", "quatre": "4",
    "i": "1", "ii": "2", "iii": "3",
    "bis": "bis", "nouveau": "new", "nouvelle": "new",
    "ancien": "old", "ancienne": "old",
}

# Patronymics in final position -> lineage geography.
# NOTE: many surnames are shared across ethnic groups. `group` is the most
# common association, NOT an identity claim. Ambiguous ones marked amb=True.
PATRONYMS = {
    # Wolof
    "ndiaye": ("Wolof", False), "diop": ("Wolof", False), "fall": ("Wolof", False),
    "fal": ("Wolof", False), "mbaye": ("Wolof", False), "gueye": ("Wolof", False),
    "gaye": ("Wolof", False), "seck": ("Wolof", False), "diagne": ("Wolof", False),
    "samb": ("Wolof", False), "dieng": ("Wolof", False), "ndoye": ("Wolof", False),
    "lo": ("Wolof", False), "wade": ("Wolof", False), "niang": ("Wolof", True),
    "sarr": ("Wolof", True), "sar": ("Wolof", True), "thiam": ("Wolof", True),
    # Sérèr
    "faye": ("Sérèr", False), "diouf": ("Sérèr", False), "sene": ("Sérèr", False),
    "ndour": ("Sérèr", False), "tine": ("Sérèr", False), "ngom": ("Sérèr", True),
    "diome": ("Sérèr", False), "sarre": ("Sérèr", True),
    # Pulaar / Haalpulaar
    "ba": ("Pulaar", False), "diallo": ("Pulaar", False), "sow": ("Pulaar", False),
    "barry": ("Pulaar", False), "ka": ("Pulaar", False), "kane": ("Pulaar", False),
    "dia": ("Pulaar", False), "sall": ("Pulaar", True), "wone": ("Pulaar", False),
    "deh": ("Pulaar", False), "sy": ("Pulaar", True), "bocoum": ("Pulaar", False),
    # Mandinka / Soninke
    "toure": ("Mandinka", False), "cisse": ("Mandinka", True), "drame": ("Mandinka", False),
    "sylla": ("Mandinka", True), "traore": ("Mandinka", False), "camara": ("Mandinka", False),
    "sakho": ("Soninke", False), "konate": ("Mandinka", False), "keita": ("Mandinka", False),
    "diaby": ("Soninke", False), "gassama": ("Mandinka", False),
    # Diola (Jola)
    "diatta": ("Diola", False), "sagna": ("Diola", False), "badji": ("Diola", False),
    "coly": ("Diola", False), "sane": ("Diola", False), "diedhiou": ("Diola", False),
    "manga": ("Diola", False), "bodian": ("Diola", False), "tendeng": ("Diola", False),
    "goudiaby": ("Diola", False),
}

# Ecological terms — trees and water. This is the paleo-ecology probe.
# Confidence matters most here; a wrong tree gloss invents a forest.
ECOLOGY = {
    "gouye":   dict(kind="tree",  gloss="baobab (Adansonia digitata), Wolof", conf="high",
                    variants=["gouye", "guy", "gui"]),
    "dakhar":  dict(kind="tree",  gloss="tamarind (Tamarindus indica), Wolof", conf="high",
                    variants=["dakhar", "dahar"]),
    "kad":     dict(kind="tree",  gloss="Faidherbia albida (kad), Wolof", conf="med",
                    variants=["kad", "cadd", "kadd"]),
    "soump":   dict(kind="tree",  gloss="Balanites aegyptiaca, Wolof", conf="med",
                    variants=["soump", "sump"]),
    "ndimb":   dict(kind="tree",  gloss="Cordyla pinnata, Wolof", conf="med",
                    variants=["ndimb", "dimb"]),
    "bantan":  dict(kind="tree",  gloss="silk-cotton / bantaba tree, Mandinka", conf="med",
                    variants=["bantan", "bantang", "bantanto"]),
    "wendou":  dict(kind="water", gloss='"pond / water point", Pulaar', conf="high",
                    variants=["wendou", "vendou", "wendu", "vendu"]),
    "bountou": dict(kind="water", gloss='"mouth / opening", Wolof', conf="med",
                    variants=["bountou", "buntu"]),
    "khoure":  dict(kind="water", gloss="watercourse (tentative)", conf="low",
                    variants=["khoure", "koure"]),
    "tann":    dict(kind="land",  gloss="salt flat / tanne, Wolof", conf="med",
                    variants=["tanne", "tann"]),
}

# ---------------------------------------------------------------- helpers

def build_variant_index(lex):
    """map normalised variant -> canonical key"""
    idx = {}
    for key, meta in lex.items():
        for v in meta.get("variants", []) or [key]:
            idx[norm(v)] = key
        idx.setdefault(norm(key), key)
    return idx

SET_IDX = build_variant_index(SETTLEMENT)
REL_IDX = build_variant_index(RELIGIOUS)
ECO_IDX = build_variant_index(ECOLOGY)

def haversine(a1, o1, a2, o2):
    R = 6371.0
    p1, p2 = math.radians(a1), math.radians(a2)
    dp = p2 - p1
    dl = math.radians(o2 - o1)
    x = math.sin(dp/2)**2 + math.cos(p1)*math.cos(p2)*math.sin(dl/2)**2
    return 2 * R * math.asin(math.sqrt(x))

def centroid(pts):
    return (sum(p[0] for p in pts)/len(pts), sum(p[1] for p in pts)/len(pts))

# ---------------------------------------------------------------- tag

def tag(name):
    """Return the derived attributes of one toponym."""
    tk = tokens(name)
    if not tk:
        return {}
    ntk = [norm(t) for t in tk]
    out = {}

    # settlement morpheme: check initial-position then final-position
    for key, meta in SETTLEMENT.items():
        hit = False
        if meta["pos"] == "initial" and SET_IDX.get(ntk[0]) == key:
            hit = True
        elif meta["pos"] == "final":
            # -kounda is a bound suffix: matches as its own token or glued on
            if SET_IDX.get(ntk[-1]) == key or any(ntk[-1].endswith(v) for v in meta["variants"]):
                hit = True
        if hit:
            out["settlement"] = key
            out["settlement_lang"] = meta["lang"]
            out["settlement_conf"] = meta["conf"]
            break

    # religious marker anywhere in the name
    for t in ntk:
        k = REL_IDX.get(t)
        if k:
            out["religious"] = k
            break

    # ethnonym qualifier, final position
    if ntk[-1] in ETHNONYMS:
        out["ethnonym"] = ETHNONYMS[ntk[-1]]
        out["stem"] = " ".join(tk[:-1])

    # fission ordinal, final position
    if ntk[-1] in ORDINALS:
        out["ordinal"] = ORDINALS[ntk[-1]]
        out["fission_stem"] = " ".join(tk[:-1])

    # patronymic, final position (skip if final token was an ethnonym/ordinal)
    if "ethnonym" not in out and "ordinal" not in out and ntk[-1] in PATRONYMS:
        grp, amb = PATRONYMS[ntk[-1]]
        out["patronym"] = tk[-1]
        out["patronym_group"] = grp
        out["patronym_ambiguous"] = amb

    # ecological term anywhere
    for t in ntk:
        k = ECO_IDX.get(t)
        if k:
            out["eco"] = k
            out["eco_kind"] = ECOLOGY[k]["kind"]
            out["eco_conf"] = ECOLOGY[k]["conf"]
            break

    return out

# ---------------------------------------------------------------- main

def main():
    conn = sqlite3.connect(DB)
    c = conn.cursor()
    for col in ("settlement", "settlement_lang", "religious", "ethnonym",
                "stem", "ordinal", "patronym", "patronym_group", "eco", "eco_kind"):
        try:
            c.execute(f"ALTER TABLE villages ADD COLUMN {col} TEXT")
        except sqlite3.OperationalError:
            pass

    rows = c.execute(
        "SELECT geonameid,name,lat,lon,region_geo,department_geo FROM villages"
    ).fetchall()

    tagged = []
    updates = []
    for gid, name, lat, lon, reg, dep in rows:
        t = tag(name)
        tagged.append((gid, name, lat, lon, reg, dep, t))
        updates.append((t.get("settlement"), t.get("settlement_lang"), t.get("religious"),
                        t.get("ethnonym"), t.get("stem"), t.get("ordinal"),
                        t.get("patronym"), t.get("patronym_group"),
                        t.get("eco"), t.get("eco_kind"), gid))
    c.executemany("""UPDATE villages SET settlement=?, settlement_lang=?, religious=?,
                     ethnonym=?, stem=?, ordinal=?, patronym=?, patronym_group=?,
                     eco=?, eco_kind=? WHERE geonameid=?""", updates)
    conn.commit()

    F = {}
    n = len(rows)
    F["total"] = n

    # ---- FINDING 1: ethnic twin villages
    stems = collections.defaultdict(list)
    for gid, name, lat, lon, reg, dep, t in tagged:
        if "ethnonym" in t and t.get("stem"):
            stems[norm(t["stem"])].append(
                dict(name=name, lat=lat, lon=lon, region=reg, dept=dep, eth=t["ethnonym"]))
    twins = []
    for stem, members in stems.items():
        eths = {m["eth"] for m in members}
        if len(eths) < 2:
            continue
        pairs = []
        for i in range(len(members)):
            for j in range(i+1, len(members)):
                a, b = members[i], members[j]
                if a["eth"] == b["eth"]:
                    continue
                pairs.append(round(haversine(a["lat"], a["lon"], b["lat"], b["lon"]), 3))
        twins.append(dict(stem=stem, members=members,
                          ethnonyms=sorted(eths), n=len(members),
                          min_km=min(pairs) if pairs else None))
    twins.sort(key=lambda x: (x["min_km"] is None, x["min_km"]))
    all_d = sorted(t["min_km"] for t in twins if t["min_km"] is not None)
    F["twins"] = dict(
        groups=twins,
        n_groups=len(twins),
        n_triplets=sum(1 for t in twins if len(t["ethnonyms"]) >= 3),
        median_km=round(all_d[len(all_d)//2], 2) if all_d else None,
        under_2km=sum(1 for d in all_d if d < 2),
        under_5km=sum(1 for d in all_d if d < 5),
    )

    # ---- FINDING 2/3: settlement morphemes + isoglosses
    morph = {}
    for key, meta in SETTLEMENT.items():
        pts = [(lat, lon, name, reg, dep) for gid, name, lat, lon, reg, dep, t in tagged
               if t.get("settlement") == key]
        if not pts:
            continue
        cy, cx = centroid([(p[0], p[1]) for p in pts])
        regs = collections.Counter(p[3] for p in pts if p[3])
        morph[key] = dict(
            lang=meta["lang"], gloss=meta["gloss"], conf=meta["conf"], pos=meta["pos"],
            n=len(pts), centroid=[round(cy, 4), round(cx, 4)],
            top_regions=regs.most_common(4),
            points=[[p[2], round(p[0], 4), round(p[1], 4), p[3], p[4]] for p in pts],
        )
    F["morphemes"] = morph

    # language-level dominance grid (the isogloss surface)
    CELL = 0.25
    grid = collections.defaultdict(collections.Counter)
    for gid, name, lat, lon, reg, dep, t in tagged:
        lg = t.get("settlement_lang")
        if not lg:
            continue
        grid[(round(lat/CELL)*CELL, round(lon/CELL)*CELL)][lg] += 1
    F["isogloss_grid"] = [
        dict(lat=k[0], lon=k[1], lang=v.most_common(1)[0][0],
             n=sum(v.values()), share=round(v.most_common(1)[0][1]/sum(v.values()), 3))
        for k, v in grid.items() if sum(v.values()) >= 2
    ]
    F["isogloss_cell_deg"] = CELL

    # ---- FINDING 4: Sufi toponym diffusion from Touba
    touba = c.execute(
        "SELECT lat,lon FROM villages WHERE name='Touba' ORDER BY population DESC LIMIT 1"
    ).fetchone()
    TOUBA = (touba[0], touba[1]) if touba else (14.8667, -15.8833)
    rel_pts = []
    for gid, name, lat, lon, reg, dep, t in tagged:
        if "religious" in t:
            rel_pts.append([name, round(lat, 4), round(lon, 4), t["religious"], reg, dep,
                            round(haversine(lat, lon, TOUBA[0], TOUBA[1]), 1)])
    rings = collections.Counter()
    for p in rel_pts:
        rings[int(p[6] // 25) * 25] += 1
    # baseline: all villages, same rings, to get a *rate* not a raw count
    base = collections.Counter()
    for gid, name, lat, lon, reg, dep, t in tagged:
        base[int(haversine(lat, lon, TOUBA[0], TOUBA[1]) // 25) * 25] += 1
    F["religious"] = dict(
        touba=[round(TOUBA[0], 4), round(TOUBA[1], 4)],
        n=len(rel_pts), points=rel_pts,
        by_type=collections.Counter(p[3] for p in rel_pts).most_common(),
        gradient=[dict(km=k, n=rings.get(k, 0), total=base[k],
                       rate=round(100*rings.get(k, 0)/base[k], 2) if base[k] else 0)
                  for k in sorted(base)],
        glosses={k: dict(gloss=v["gloss"], conf=v["conf"]) for k, v in RELIGIOUS.items()},
    )

    # ---- FINDING 5: settlement fission
    fis = collections.defaultdict(list)
    for gid, name, lat, lon, reg, dep, t in tagged:
        if t.get("ordinal") and t.get("fission_stem"):
            fis[norm(t["fission_stem"])].append(
                dict(name=name, lat=lat, lon=lon, ord=t["ordinal"], region=reg, dept=dep))
    fpairs = []
    for stem, members in fis.items():
        if len(members) < 2:
            continue
        ds = []
        for i in range(len(members)):
            for j in range(i+1, len(members)):
                ds.append(haversine(members[i]["lat"], members[i]["lon"],
                                    members[j]["lat"], members[j]["lon"]))
        fpairs.append(dict(stem=stem, members=members, min_km=round(min(ds), 3)))
    fpairs.sort(key=lambda x: x["min_km"])
    fd = sorted(p["min_km"] for p in fpairs)
    F["fission"] = dict(groups=fpairs, n=len(fpairs),
                        median_km=round(fd[len(fd)//2], 2) if fd else None,
                        n_marked=sum(1 for *_, t in tagged if t.get("ordinal")))

    # ---- FINDING 6: lineage geography
    pat = collections.defaultdict(list)
    for gid, name, lat, lon, reg, dep, t in tagged:
        if t.get("patronym"):
            pat[t["patronym"]].append((lat, lon, reg, t["patronym_group"], t.get("patronym_ambiguous")))
    plist = []
    for surname, pts in pat.items():
        if len(pts) < 3:
            continue
        cy, cx = centroid([(p[0], p[1]) for p in pts])
        regs = collections.Counter(p[2] for p in pts if p[2])
        plist.append(dict(surname=surname, n=len(pts), group=pts[0][3],
                          ambiguous=bool(pts[0][4]),
                          centroid=[round(cy, 4), round(cx, 4)],
                          top_regions=regs.most_common(3)))
    plist.sort(key=lambda x: -x["n"])
    F["patronyms"] = plist

    # ---- ecology probe
    eco_pts = [[name, round(lat, 4), round(lon, 4), t["eco"], t["eco_kind"], reg, dep]
               for gid, name, lat, lon, reg, dep, t in tagged if t.get("eco")]
    F["ecology"] = dict(
        n=len(eco_pts), points=eco_pts,
        by_term=collections.Counter(p[3] for p in eco_pts).most_common(),
        glosses={k: dict(gloss=v["gloss"], conf=v["conf"], kind=v["kind"])
                 for k, v in ECOLOGY.items()},
    )

    # ---- morpheme co-occurrence network
    tok_freq = collections.Counter()
    for gid, name, *_ in tagged:
        for t in tokens(name):
            tok_freq[norm(t)] += 1
    MIN = 3
    keep = {t for t, cnt in tok_freq.items() if cnt >= MIN and len(t) > 1}
    edges = collections.Counter()
    for gid, name, *_ in tagged:
        tk = [norm(t) for t in tokens(name)]
        tk = [t for t in tk if t in keep]
        for i in range(len(tk)):
            for j in range(i+1, len(tk)):
                edges[tuple(sorted((tk[i], tk[j])))] += 1
    display = {}
    for gid, name, *_ in tagged:
        for t in tokens(name):
            display.setdefault(norm(t), t)

    def classify(t):
        if t in SET_IDX:  return SETTLEMENT[SET_IDX[t]]["lang"]
        if t in REL_IDX:  return "Religious"
        if t in ETHNONYMS: return "Ethnonym"
        if t in PATRONYMS: return PATRONYMS[t][0]
        if t in ECO_IDX:  return "Ecological"
        return "Unclassified"

    nodes = [dict(id=t, label=display.get(t, t), n=tok_freq[t], cls=classify(t))
             for t in keep]
    elist = [dict(s=a, t=b, w=w) for (a, b), w in edges.items() if w >= 2]
    linked = {e["s"] for e in elist} | {e["t"] for e in elist}
    F["network"] = dict(nodes=[nd for nd in nodes if nd["id"] in linked],
                        edges=elist, min_token_freq=MIN, min_edge_weight=2)

    # ---- coverage / honesty stats
    F["coverage"] = dict(
        settlement=sum(1 for *_, t in tagged if t.get("settlement")),
        religious=sum(1 for *_, t in tagged if t.get("religious")),
        ethnonym=sum(1 for *_, t in tagged if t.get("ethnonym")),
        patronym=sum(1 for *_, t in tagged if t.get("patronym")),
        eco=sum(1 for *_, t in tagged if t.get("eco")),
        any=sum(1 for *_, t in tagged if t),
        dept_assigned=sum(1 for _, _, _, _, r, d, _ in tagged if d),
    )
    F["regions"] = collections.Counter(
        r for _, _, _, _, r, d, _ in tagged if r).most_common()

    with open("findings.json", "w", encoding="utf-8") as f:
        json.dump(F, f, ensure_ascii=False, separators=(",", ":"))

    conn.commit()
    conn.close()

    # ---- report
    print(f"total villages        {n}")
    cv = F["coverage"]
    print(f"any tag               {cv['any']} ({100*cv['any']/n:.1f}%)")
    print(f"  settlement morpheme {cv['settlement']}")
    print(f"  religious           {cv['religious']}")
    print(f"  ethnonym            {cv['ethnonym']}")
    print(f"  patronym            {cv['patronym']}")
    print(f"  ecological          {cv['eco']}")
    print(f"\nTWINS  groups={F['twins']['n_groups']} triplets={F['twins']['n_triplets']} "
          f"median={F['twins']['median_km']}km <2km={F['twins']['under_2km']}")
    print(f"FISSION groups={F['fission']['n']} median={F['fission']['median_km']}km "
          f"marked={F['fission']['n_marked']}")
    print(f"RELIGIOUS n={F['religious']['n']} touba={F['religious']['touba']}")
    print(f"ECOLOGY n={F['ecology']['n']} {F['ecology']['by_term'][:6]}")
    print(f"NETWORK nodes={len(F['network']['nodes'])} edges={len(F['network']['edges'])}")
    print("\nmorphemes:")
    for k, v in sorted(morph.items(), key=lambda x: -x[1]["n"]):
        print(f"  {k:10s} {v['lang']:15s} n={v['n']:5d} centroid={v['centroid']}")

if __name__ == "__main__":
    main()
