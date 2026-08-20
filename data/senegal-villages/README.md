# Senegal Villages — toponymic dataset and study

11,789 populated places in Senegal, tagged for what their **names** encode:
naming language, religious elements, ethnic labels, founder surnames and
ecological terms.

**Study:** https://claude.ai/code/artifact/0ec3e658-6334-4b3c-bfee-8637e641fe57

## Files

| file | what it is |
|---|---|
| `senegal_villages_enriched.csv` | the dataset, flat. Start here. |
| `senegal_villages.geojson` | same, as points, for QGIS / mapping |
| `villages.sqlite` | working database, all derived columns |
| `findings.json` | computed results behind the six findings |
| `study.html` | the published study page (self-contained) |
| `analyze.py` | the lexicon + all finding computations |
| `assign_admin.py` | point-in-polygon region/department assignment |
| `build_study_data.py` | assembles the study page's data bundle |
| `sen_adm1/2.geojson` | geoBoundaries region and department polygons |
| `geonames_raw/SN.txt` | untouched GeoNames source |

## Columns

`region` / `department` are assigned by **point-in-polygon against
geoBoundaries**, not taken from GeoNames — that raised department coverage
from 18% to 99.6%.

`settlement_morpheme` / `naming_language` — the settlement word in the name
(Keur → Wolof, Saré → Pulaar, -kounda → Mandinka…). Spelling variants are
collapsed before matching.

`religious_element`, `ethnonym`, `patronym`, `eco_term` — other recognised
name elements. Blank means unrecognised, never guessed.

## Reproducing

```
python3 assign_admin.py      # region/department by geometry
python3 analyze.py           # lexicon tagging + findings.json
python3 build_study_data.py  # bundle for the study page
```

## Findings

1. **64 localities exist in two or more ethnic versions**, median 1.55 km apart.
2. `Keur` (Wolof) and `Saré` (Pulaar) mean the same thing, centroids ~180 km apart.
3. **Pulaar uses five different settlement words**, each holding its own territory.
4. Sufi-named villages: **15.0% within 25 km of Touba**, ~5% by 75 km out.
5. 67 numbered village splits, median 1.73 km — nearly identical spacing to (1).
6. 618 villages named for their founding family, across 60+ surnames.

## Limits

Not cross-checked against Senegal's ANSD census — the most valuable next step.
Linguistic glosses are hand-built and carry confidence levels; several are
medium or low. **A pattern in names is a hypothesis about history, not proof
of it.** Corrections to the lexicon in `analyze.py` are the most useful
contribution anyone can make.

## Licence

Village data © GeoNames contributors, **ODbL**. Boundaries from geoBoundaries
(gbOpen), **CC BY 4.0**. Derived columns released under the same terms.
