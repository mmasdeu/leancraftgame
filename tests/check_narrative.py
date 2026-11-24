"""Static regression checks for the Sequences -> Limits -> Topology narrative."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
rows = json.loads((ROOT / "docs/narrative-data.json").read_text())
assert len(rows) == 60

for n, (title, objective, bridge) in enumerate(rows, 1):
    meta = json.loads((ROOT / f"LeanCraftGame/L{n}/level.json").read_text())
    assert meta["title"] == title
    assert meta["learningObjective"] == objective
    assert meta["world"] == ("Sequences" if n <= 33 else "Limits" if n <= 43 else "Topology")
    assert ("Auditing" in meta["chapter"]) == (n >= 58)
    lesson = (ROOT / f"LeanCraftGame/L{n}/Player.lean").read_text()
    assert lesson.startswith(f"/-\n# {title}\n\n**ACT "), n
    assert objective[0].lower() + objective[1:] in lesson, n
    assert bridge in lesson, n
    assert lesson.count("## The road from here") == 1, n

for i in range(1, 16):
    meta = json.loads((ROOT / f"LeanCraftGame/T{i}/level.json").read_text())
    assert meta["world"] == "Topology"
    lesson = (ROOT / f"LeanCraftGame/T{i}/Player.lean").read_text()
    assert "**ACT III — TOPOLOGY**" in lesson
    assert lesson.count("## The road from here") == 1

print("Narrative checks passed for all 60 original lessons and all 15 topology lessons.")
