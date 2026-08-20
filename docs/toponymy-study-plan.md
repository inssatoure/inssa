# Study plan: what Senegal's village names encode

A research plan, not a visualization plan. The dashboard is the delivery
vehicle; the findings are the product.

Status: PLAN. Approved scope pending. Recon done 2026-08-20 — the three
core hypotheses below were tested against the real corpus and hold.

## Why this is a study and not a map

11,789 toponyms are a **frozen historical record**. A village name
records the language, lineage, religion and ecology present *at the
moment of founding* — not today. So the toponymic map and the modern
map disagree, and every disagreement is a historical event: a
migration, a conversion, a language shift, a vanished forest.

Nobody has run the full Senegalese toponymic corpus through this lens
computationally. Individual phenomena below are known qualitatively to
geographers (Pélissier on Serer settlement, Copans on the Mouride
pioneer front). **What is new here is national-scale quantification
from the complete name corpus** — and, in at least two cases, a
pattern I can find no prior description of at all.

## Recon results — hypotheses already confirmed

### FINDING 1 — Ethnic twin villages (strongest, most novel)
63 name-stems carry two or more different ethnonym suffixes
(Peul / Sérèr / Wolof / Toucouleur / Bambara / Socé...).
**79 such pairs. Median separation: 1.7 km. 76 of 79 are under 5 km.**

    Khaye Sérèr      <-> Khaye Ouolof        0.33 km
    Ndiafat Wolof    <-> Ndiafat Sérèr       0.43 km
    Ndoukhoura Peul  <-> Ndoukhoura Wolof    0.51 km
    Malikounda Sérèr <-> Malikounda Wolof    0.89 km

Some are **triplets**: Dougoul and Gowane each exist as Peul + Sérèr +
Wolof. This is parallel ethnic co-settlement written into the map —
two or three communities sharing one locality and one name,
distinguishing themselves only by ethnicity. It is the visible
opposite of segregation. I can find no quantification of this anywhere.

### FINDING 2 — A clean toponymic language frontier
Settlement-morphemes all meaning roughly "home/village of", by
centroid:

| morpheme | language | n | centroid | heartland |
|---|---|---|---|---|
| Keur | Wolof | 1037 | 14.48N -16.18 | Kaolack, Thiès, Fatick |
| Saré | Pulaar | 421 | 13.15N -14.59 | Kolda, Sédhiou |
| -Kounda | Mandinka | 118 | 13.09N -14.88 | Sédhiou, Kolda |
| Sinthiou | Pulaar | 201 | 14.08N -14.14 | Tambacounda |
| Ouro | Pulaar | 44 | 14.88N -13.85 | Tambacounda, Matam |
| Gourel | Pulaar | 41 | 14.63N -13.00 | Tambacounda, Matam |

Keur and Saré centroids sit **~180 km apart**. There is a real
frontier, and it is mappable to the village.

### FINDING 3 — Pulaar splits itself in two (the surprise)
Pulaar speakers do **not** use one settlement morpheme. **Saré**
dominates the south (Kolda/Sédhiou — the Fuladu). **Ouro** and
**Gourel** dominate the northeast (Tambacounda/Matam — Fouta Toro /
Ferlo). Same language, different word, ~200 km of separation between
centroids, near-zero overlap.

That is two distinct Fulani settlement histories preserved in
vocabulary. It matches what historians say about Fouta Toro vs Fuladu
being separate populations — but as far as I can tell it has never
been demonstrated *from toponyms*.

## Research questions to pursue

Ranked by (novelty x feasibility). Q1-Q3 are confirmed viable above.

**Q1. Where exactly is the ethnic co-settlement belt?**
Map all 79 twin pairs. Expect concentration in the Sine-Saloum
(Serer/Wolof contact) and along the Ferlo edge (Peul/Wolof). Test
whether Peul twins sit systematically at a different distance /
ecological zone than Serer twins — pastoral vs agricultural
co-residence would have different spatial signatures.

**Q2. Draw the toponymic isoglosses.**
Per-morpheme kernel density, then the boundary line where Keur
probability crosses Saré probability. Compare against the modern
ethnolinguistic map. **Every mismatch is a historical language shift**
— places that were Pulaar-founded and are now Wolof-speaking, or vice
versa. That comparison is the real payload.

**Q3. Quantify the Mouride pioneer front.**
Darou (215) centroid is Diourbel — Touba's own region. Touba-named
villages (86) centre on Kaffrine. Measure the density gradient of
Sufi toponyms (Darou / Touba / Madina / Taïba / Missira / Maka, ~550
villages) as a function of distance from Touba, and against the
peanut-basin agricultural frontier. Known qualitatively; never
measured at corpus scale.

**Q4. Toponyms as a paleo-ecological record.** (highest risk, highest
reward)
Many names embed tree and water terms — Gouye (baobab), Dakhar
(tamarind), Kad (Acacia albida), Vendou/Wendou (Pulaar: pond), Soump,
Ndimb, Rao. Build a species/hydronym lexicon, map those villages, then
overlay **current** land cover. Villages named "baobab" now sitting in
sahelian scrub are a record of vegetation that no longer exists.
Toponymy as a desertification proxy. If it works it is publishable in
its own right; if the land-cover data is unreachable it degrades
gracefully to a hypothesis map.

**Q5. Settlement fission.**
"Un" (66) and "Deux" (71) as final elements — Keur X Un / Keur X Deux.
Daughter-village splitting, probably colonial-administrative. Measure
separation distances; compare against the ethnic-twin distances from
Q1. Two different mechanisms producing adjacent same-stem villages.

**Q6. Lineage geography.**
Final-position patronymics (Ndiaye 87, Fal 68, Diop 59, Mbaye 46,
Guèye 34, Gaye 29, Touré 22, Kane 19...). Map each clan's toponymic
footprint. Serer clans (Faye, Diouf, Sène, Ndour) vs Wolof (Ndiaye,
Diop, Fall) vs Pulaar (Ba, Diallo, Sow) vs Mandinka (Cissé, Touré).
Directly useful to diaspora heritage research — "where does my name
come from" answered from the map.

## Data still needed

1. **Senegal admin boundaries (GeoJSON)** — geoBoundaries / HDX /
   Natural Earth. Fixes the 82% missing-department gap by
   point-in-polygon, and gives real borders to draw instead of a bare
   scatter. **Test reachability first** — most hosts are blocked in
   this sandbox; GeoNames and nominatim worked, Overpass did not.
2. **A morpheme lexicon with glosses** — Wolof / Pulaar / Serer /
   Mandinka / Jola settlement terms, tree species, water terms. Build
   from the corpus frequency list, gloss each entry, and **mark
   confidence per gloss**. This is the study's weakest link and must
   be labelled as such, not smoothed over.
3. **Land cover / vegetation raster** (Q4 only) — optional, degrade
   gracefully if unreachable.

## Deliverables

1. **Senegal-only interactive map.** Drop the world globe — it was the
   wrong frame. Real Senegal boundaries, region borders, pan/zoom,
   click-for-details, layer toggles per finding.
2. **Morpheme network graph** — the Obsidian-style view the user
   asked for. Nodes = name elements, edges = co-occurrence within a
   name, colour = inferred language, size = frequency. This exposes
   the *combinatorial grammar* of Senegalese place-naming: which
   elements combine with which, and which never do.
3. **The findings write-up** — each question above with its map, its
   numbers, and its honest confidence level.
4. **Clean open dataset** (CSV + GeoJSON, ODbL-attributed) with every
   derived column: morpheme, language, ethnonym, patronymic, religious
   class, twin-pair id.

## Honest limitations — to state on the page, not bury

- Language attribution is inferred from name shape, not from speakers.
  A "Keur" village is Wolof-*named*; that is not the same as
  Wolof-*speaking*, and the gap between those two is precisely what
  makes Q2 interesting — but it must never be presented as identity.
- GeoNames is not the Senegalese state. Coverage is uneven, spellings
  are inconsistent (Sintiou / Sinntiou / Sintiân / Santiou are almost
  certainly one morpheme), and ANSD cross-validation is still pending.
- Spelling variance will under-count morphemes. Needs a normalisation
  pass before any count is quoted as final.
- Correlation is not history. Every claim about migration or language
  shift is a *hypothesis generated by* the toponymic pattern, and
  should be handed to historians and linguists to confirm — not
  asserted.

## Build order once approved

1. Normalise spelling variants; build + gloss the morpheme lexicon.
2. Acquire boundaries; fix departments by point-in-polygon.
3. Compute Q1, Q2, Q3, Q5, Q6 (Q4 last — depends on external raster).
4. Rebuild the map as Senegal-only with per-finding layers.
5. Build the morpheme network graph.
6. Write the findings page; publish dataset + study together.

---

# BUILT — 2026-08-20

All six findings computed and published. Study:
https://claude.ai/code/artifact/0ec3e658-6334-4b3c-bfee-8637e641fe57
(Original village dashboard, still live:
https://claude.ai/code/artifact/1be529d5-e457-4fda-b9f3-ab61532cf369)

See `data/senegal-villages/README.md` for the file map and how to rerun.

## Results as built
- F1 ethnic twins: **64 groups, 7 triplets, median 1.55 km**, 45 under 2 km.
- F2 frontier: Keur (Wolof, 1037) vs Saré (Pulaar, 422), centroids ~180 km apart.
- F3 Pulaar splits **five ways**: Saré (south) / Sinthiou / Ouro / Gourel
  (east) / Loumbel + Belel (north Ferlo). Stronger than the 3-way split
  predicted in the plan.
- F4 Sufi gradient from Touba: **15.0% → 8.7% → 5.8% → 5.2%** over the first
  100 km. Clean monotonic decay in the core; noisy past ~150 km.
- F5 fission: 67 numbered splits, median **1.73 km** — nearly identical to F1's
  1.55 km despite an unrelated mechanism. Worth writing up on its own.
- F6 lineages: 618 villages, 60+ surnames with centroids and heartlands.
- Ecology probe: only 126 villages tagged. Published as hypothesis only —
  needs a land-cover raster to test, which was unreachable.

## Environment notes for the next agent
- **Overpass/OSM: still unreachable.** Don't retry.
- **GitHub raw is proxy-blocked**, but git-LFS files fetch fine from
  `media.githubusercontent.com/media/<owner>/<repo>/<sha>/<path>` — that is
  how the geoBoundaries polygons were obtained. jsDelivr returns the LFS
  pointer, not the content.
- **www.ansd.sn needs `curl -k`** (their cert doesn't chain). Their CSV export
  endpoint still times out unfiltered; try per-region query params.
- Playwright: use `executablePath:'/opt/pw-browsers/chromium-1194/chrome-linux/chrome'`.
  Google Fonts fails to load in the sandbox browser — harmless, works published.

## Highest-value next steps
1. **ANSD cross-validation** — still the single biggest credibility gap.
2. **Lexicon review by actual speakers.** ~29% of names carry a recognised
   element; the rest are unclassified. Every gloss is the author's own.
   Expanding and correcting `SETTLEMENT`/`ECOLOGY`/`PATRONYMS` in analyze.py
   is the highest-leverage work left.
3. **F5 vs F1 spacing** — why do two unrelated mechanisms produce the same
   ~1.6 km village spacing? That looks like a real question worth a paper.
4. Land-cover raster for the ecology thread.
