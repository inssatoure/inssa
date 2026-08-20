# Mission: Senegal Villages Atlas

Goal: build an open dataset + visualization of every village in Senegal
(name, coords, admin hierarchy, linguistic/name-pattern tagging), as a
public-interest resource (heritage, linguistics, planning). Not started
building yet — plan only, agreed with user (diguifils@gmail.com).

## Status (updated 2026-08-20)
- Phase 0: DONE. Data lives in `data/senegal-villages/`.
  - Source: GeoNames SN dump (download.geonames.org/export/dump/SN.zip) —
    fast/reliable in this sandbox. **OSM Overpass API is NOT reachable**
    from this environment: overpass-api.de gets TLS reset, and every
    public mirror tried (overpass.osm.ch, .fr, .kumi.systems,
    .private.coffee, .monicz.dev) is either regional-only, returns 500,
    or the proxy throttles the POST body to ~1 byte/sec (unusable). Do
    not re-attempt Overpass without checking network policy first — it
    burned real time this session. GeoNames + ANSD are the way forward.
  - `villages.sqlite`: 11,789 populated places (feature_class=P),
    11,568 of them `PPL` (village/settlement). Full SN.txt had 14,523
    rows total (rest are hydro/terrain features, not places).
  - `senegal_villages.csv`: flat export of the same, sorted by name.
  - First-pass `lang_guess`/`name_root` tagging done on ~2,100 names via
    coarse prefix regex (Wolof/Pulaar/Serer/Jola/Mandinka clan- and
    toponym-roots). This is a rough v1, not linguistically rigorous —
    needs review by someone who knows the languages, and coverage is
    only ~18% of rows so far.
- Phase 1 (enrichment): partially started.
  - Language tagging: ~2,100 rows (~18%), coarse regex, needs review.
  - Dedup: added `name_dupe_count` column (count of rows sharing exact
    name nationally). These are legitimate repeats spread across
    regions, not data errors — e.g. "Ndiayène" appears 21x across 7
    regions, "Darou Salam" 19x, "Missira" 17x. 10,182 distinct names
    out of 11,789 rows. Not merged/removed — kept as-is with the count
    so downstream analysis can decide.
  - Name-pattern clustering, "interesting name" flagging: not started.
- Phase 2 (visualization): first version DONE.
  - `data/senegal-villages/dashboard.html` — self-contained dashboard
    (all 11,789 points inlined as JSON, no external fetch): canvas
    scatter map colored by region, language-root bar chart, top-reused
    names table, full searchable table.
  - `dashboard_data.json` — the underlying export used to build it, kept
    for regenerating the dashboard after future data updates (see
    `dashboard.html`'s embedded `<script id="village-data">` — that's
    what actually renders, regenerate it from `dashboard_data.json` by
    re-running the inline-patch step, don't hand-edit the JSON blob
    inside the HTML).
  - Published as Artifact: https://claude.ai/code/artifact/1be529d5-e457-4fda-b9f3-ab61532cf369
    (private, owned by this session's user).
- Phase 3 (validation against ANSD/IGN): not started. ANSD source URL
  not yet found/verified.

## Plan (phases, do in order, each independently shippable)

**Phase 0 — Data acquisition**
1. Pull `place=village|hamlet|isolated_dwelling` for Senegal from OSM
   Overpass API (name, alt names, lat/lon).
2. Merge with GeoNames SN dump (free download, alt spellings).
3. If findable: ANSD (Senegal stats agency) village-level census gazetteer
   for official admin hierarchy + population.
4. Normalize into SQLite: `villages(id, name, alt_names[], lat, lon,
   region, department, arrondissement, commune, source, population)`.

**Phase 1 — Enrichment**
5. Tag probable source language per name (Wolof/Pulaar/Serer/Jola/
   Mandinka/Soninke) via prefix/root heuristics (e.g. "Keur-" = Wolof
   "home of").
6. Cluster by naming pattern (e.g. "Keur X", clan-name prefixes).
7. Dedupe/disambiguate villages sharing names across regions.
8. Flag unusual/interesting names with meanings (the original spark for
   this idea).

**Phase 2 — Visualization/delivery**
9. Interactive map (Leaflet/Mapbox or Artifact).
10. Name-root frequency chart, national + per region.
11. Searchable table w/ meaning lookup.
12. Export clean CSV/GeoJSON (the real reusable deliverable).

**Phase 3 — Validation**
13. Spot-check sample vs ANSD/IGN Sénégal official sources.
14. Document sources, licensing (OSM = ODbL, share-alike + attribution
    required), and known gaps.

## Execution mode
Iterative loop, one phase-step per iteration, sanity-check before next:
1. Overpass pull → check count vs known ~14,000+ villages estimate.
2. GeoNames merge + dedup.
3. Linguistic tagging (sample → refine rules → full set).
4. Visualization artifact.
5. Clean export + short findings writeup.

## Notes for next agent
- This is a side project, unrelated to the Flutter app in this repo
  (lib/, pubspec.yaml etc). Treat as a separate `data/senegal-villages/`
  workspace — don't touch app code.
- User wants token-conscious execution: do one phase per turn, report
  concrete numbers/results, don't re-explain the plan each time (link
  back to this file instead). User said "go in full mode, don't stop to
  ask questions, trust the loop" — proceed autonomously through phases.
- `data/senegal-villages/geonames_raw/` kept (source txt) for
  re-processing; sn_geonames.zip and overpass experiment scratch files
  were deleted after use — don't bother re-fetching overpass.
- Next concrete actions, in order:
  1. Language tagging is at ~32% coverage now (up from 18%) using
     frequency-driven prefix mining (looked at most common untagged
     first-tokens, added regex for the top ~30). Repeat this technique
     again — re-run the "most common untagged first token" query in
     the mission doc's Phase 1 code, it still surfaces more.
  2. Try ANSD (Senegal statistics office) for an official village
     gazetteer/population figures to cross-validate GeoNames. Not yet
     attempted — worth checking if it's a reachable/downloadable URL
     from this sandbox (GeoNames and nominatim.openstreetmap.org were
     fine; many other hosts are throttled/blocked, test before relying
     on it).
  3. Dashboard v1 exists but is unreviewed — population field is 0 for
     most rows (GeoNames doesn't have village-level population for
     Senegal, only bigger towns), so the "Pop." column in the search
     table is mostly empty. Worth deciding whether to hide it or find a
     population source.
  4. Re-publish the Artifact after any data update: edit
     `dashboard_data.json`-generation script in mission doc history (see
     git log for the python heredocs used), regenerate
     `dashboard_data.json`, re-inline into `dashboard.html`, then call
     Artifact publish again with the same file_path — it updates the
     same URL in-session, or pass `url` if starting a new session.
