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
