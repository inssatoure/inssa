# Mission: Senegal Villages Atlas

Goal: build an open dataset + visualization of every village in Senegal
(name, coords, admin hierarchy, linguistic/name-pattern tagging), as a
public-interest resource (heritage, linguistics, planning). Not started
building yet — plan only, agreed with user (diguifils@gmail.com).

## Status
- Phase: 0 (not started)
- No code written yet in this repo for this mission.

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
  back to this file instead).
- Next concrete action: run Overpass query for Senegal villages, load
  into `data/senegal-villages/villages.sqlite`, report row count.
