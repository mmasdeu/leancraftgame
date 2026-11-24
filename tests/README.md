# Browser integration test

`browser_topology.py` serves the local game, drives headless Chromium, and submits every
`variants/T<n>/correct.lean` answer through the browser editor. It asserts each level reaches
“Level cleared”, checks the T1→T2 Next button and T15 completion, and fails on JavaScript page
errors.

Prerequisites (project-home installation):

```bash
python3 -m pip install --user playwright
python3 -m playwright install chromium
```

Run with the pinned toolchain available:

```bash
PATH="$HOME/.elan/bin:$PATH" python3 tests/browser_topology.py
```

This tests the local backend and the real UI. The separate hosted backend uses the public Lean
Playground WebSocket; its test on this branch was blocked by a 403 handshake response, so no
successful hosted execution is claimed.

## Narrative regression

`check_narrative.py` verifies every original lesson's new act, objective and bridge.
`browser_narrative.py` displays all 75 levels in actual play order, checks their act text,
submits solutions for L1, L23, L39 and T15, and verifies that T15 advances to the L58 coda:

```bash
python3 tests/check_narrative.py
PATH="$HOME/.elan/bin:$PATH" python3 tests/browser_narrative.py
```
