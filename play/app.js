"use strict";

/* ------------------------------------------------------------ helpers */

const $ = (id) => document.getElementById(id);
const esc = (s) => s.replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]);

const store = {
  get(key, fallback) {
    try { const v = localStorage.getItem("leancraftgame." + key); return v === null ? fallback : JSON.parse(v); }
    catch { return fallback; }
  },
  set(key, value) {
    try { localStorage.setItem("leancraftgame." + key, JSON.stringify(value)); } catch { /* private mode */ }
  },
};

const REPO = "mmasdeu/leancraftgame";          // where "Report a problem" opens an issue

/* A small Markdown subset for the level text: headings, bullet and numbered lists, quotes,
   fenced code, `code`, **bold**, *italic*. */
function inline(s) {
  return s.split("`").map((part, i) => i % 2
    ? `<code>${esc(part)}</code>`
    : esc(part).replace(/\*\*(.+?)\*\*/g, "<b>$1</b>").replace(/\*(\S.*?)\*/g, "<i>$1</i>")).join("");
}
function markdown(text) {
  const out = [];
  let para = [], list = [], ordered = false, quote = [], code = null;
  const flush = () => {
    if (para.length) out.push(`<p>${inline(para.join(" "))}</p>`);
    if (list.length) {
      const tag = ordered ? "ol" : "ul";
      out.push(`<${tag}>${list.map((l) => `<li>${inline(l)}</li>`).join("")}</${tag}>`);
    }
    if (quote.length) out.push(`<blockquote>${inline(quote.join(" "))}</blockquote>`);
    para = []; list = []; quote = [];
  };
  for (const line of text.split("\n")) {
    let m;
    if (line.startsWith("```")) {
      if (code) { out.push(`<pre class="hl">${highlight(code.join("\n"))}</pre>`); code = null; }
      else { flush(); code = []; }
    } else if (code) code.push(line);
    else if (!line.trim()) flush();
    else if ((m = /^(#{1,3})\s+(.*)/.exec(line))) { flush(); out.push(`<h${m[1].length}>${inline(m[2])}</h${m[1].length}>`); }
    else if ((m = /^(?:([*-])|\d+\.)\s+(.*)/.exec(line))) {
      if (para.length || quote.length || (list.length && ordered !== !m[1])) flush();
      ordered = !m[1];
      list.push(m[2]);
    }
    else if (list.length && /^\s+/.test(line)) list[list.length - 1] += " " + line.trim();
    else if (/^\s{2,}/.test(line)) { if (para.length) flush(); quote.push(line.trim()); }
    else { if (list.length) flush(); para.push(line.trim()); }
  }
  flush();
  return out.join("\n");
}

/* ------------------------------------------------------------ math in test names */

/* Test names quote Lean functions such as `(fun n => n % 2)`. Show them in the usual
   notation, n ↦ n mod 2, typeset by MathJax; until MathJax has loaded (or if it cannot
   load), a plain-text version is shown. */

const BLACKBOARD = { "ℕ": "\\mathbb{N}", "ℤ": "\\mathbb{Z}", "ℚ": "\\mathbb{Q}", "ℝ": "\\mathbb{R}" };

/* A Lean arithmetic expression as { tex, plain }. */
function exprToMath(e) {
  e = e.trim();
  for (let prev = null; prev !== e; ) {              // drop casts and type ascriptions
    prev = e;
    e = e.replace(/\(([^():]+?)\s*:\s*[^():]+\)/g, "($1)").replace(/\((\w+)\)/g, "$1");
  }
  const m = /^if (.+?) then (.+?) else (.+)$/.exec(e);
  if (m) {
    const [c, a, b] = [exprToMath(m[1]), exprToMath(m[2]), exprToMath(m[3])];
    return { tex: `\\begin{cases} ${a.tex} & \\text{if } ${c.tex} \\\\ ${b.tex} & \\text{otherwise} \\end{cases}`,
             plain: `(${a.plain} if ${c.plain}, else ${b.plain})` };
  }
  const product = (s, op) => s.replace(/(\d+) \* (\w)/g, "$1$2").replace(/ \* /g, op);
  let tex = product(e, " \\cdot ").replace(/ % /g, " \\bmod ")
    .replace(/≤/g, "\\le").replace(/≥/g, "\\ge").replace(/≠/g, "\\ne")
    .replace(/[ℕℤℚℝ]/g, (c) => BLACKBOARD[c]);
  const plain = product(e, " · ").replace(/ % /g, " mod ");
  return { tex, plain };
}

/* `fun x => body` (or `fun x : T => body`) as { tex, plain }, or null. */
function funToMath(s) {
  const m = /^fun\s+(\w+|_)\s*(?::[^=]*)?=>\s*([\s\S]+)$/.exec(s.trim());
  if (!m) return null;
  const v = m[1] === "_" ? "n" : m[1], body = exprToMath(m[2]);
  return { tex: `${v} \\mapsto ${body.tex}`, plain: `${v} ↦ ${body.plain}` };
}

const mathCache = {};
function texToHtml(tex, plain) {
  if (!window.MathJax?.tex2chtml) return `<span class="math-plain">${esc(plain)}</span>`;
  if (!(tex in mathCache)) {
    try {
      mathCache[tex] = MathJax.tex2chtml(tex, { display: false }).outerHTML;
      const sheet = MathJax.chtmlStylesheet();
      if (!sheet.isConnected) document.head.appendChild(sheet);
    } catch {
      mathCache[tex] = `<span class="math-plain">${esc(plain)}</span>`;
    }
  }
  return mathCache[tex];
}

/* A test name as HTML, with every `(fun …)` shown as mathematics. */
function nameToHtml(name) {
  let out = "", i = 0;
  while (i < name.length) {
    if (name.startsWith("(fun ", i)) {
      let depth = 0, j = i;
      for (; j < name.length; j++) {
        if (name[j] === "(") depth++;
        else if (name[j] === ")" && --depth === 0) break;
      }
      const f = funToMath(name.slice(i + 1, j));
      if (f && j < name.length) {
        out += texToHtml(`\\left(${f.tex}\\right)`, `(${f.plain})`);
        i = j + 1;
        continue;
      }
    }
    out += esc(name[i++]);
  }
  return out;
}

/* ------------------------------------------------------------ editor */

/* Lean's backslash abbreviations (a subset of the VS Code extension's table). */
const ABBREV = {
  "to": "→", "->": "→", "r": "→", "imp": "→", "l": "←", "<-": "←", "iff": "↔", "<->": "↔", "=>": "⇒",
  "forall": "∀", "all": "∀", "exists": "∃", "ex": "∃", "and": "∧", "or": "∨", "not": "¬", "neg": "¬",
  "ne": "≠", "neq": "≠", "le": "≤", "<=": "≤", "leq": "≤", "ge": "≥", ">=": "≥", "geq": "≥",
  "N": "ℕ", "nat": "ℕ", "Z": "ℤ", "Q": "ℚ", "R": "ℝ", "C": "ℂ",
  "fun": "λ", "lam": "λ", "x": "×", "times": "×", "circ": "∘", "comp": "∘", "o": "∘",
  "in": "∈", "notin": "∉", "sub": "⊆", "subset": "⊂", "cap": "∩", "cup": "∪", "empty": "∅",
  "inv": "⁻¹", "-1": "⁻¹", "<": "⟨", ">": "⟩", ".": "·", "cdot": "·", "|": "∣", "mid": "∣",
  "mapsto": "↦", "|->": "↦", "top": "⊤", "bot": "⊥", "sum": "∑", "prod": "∏", "infty": "∞",
  "a": "α", "alpha": "α", "b": "β", "beta": "β", "g": "γ", "gamma": "γ", "d": "δ", "delta": "δ",
  "e": "ε", "epsilon": "ε", "mu": "μ", "pi": "π", "sigma": "σ", "phi": "φ", "G": "Γ",
  "^2": "²", "^3": "³", "u": "↑",
};
for (let i = 0; i <= 9; i++) ABBREV["_" + i] = "₀₁₂₃₄₅₆₇₈₉"[i];
const NAMES = Object.keys(ABBREV);

const src = $("src"), hl = $("hl"), gutter = $("gutter"), marks = $("marks");
let expanding = false;
let diagnostics = [];

const TOKEN = /(\/-[\s\S]*?(?:-\/|$)|--[^\n]*)|("(?:[^"\\\n]|\\.)*"?)|\b(sorry)\b|\b(def|structure|namespace|end|where|fun|theorem|lemma|abbrev|open|by|if|then|else|let|match|with|instance|class|example|deriving|import|variable|section|noncomputable)\b|\b(Prop|Type|Nat|Int|Bool|Fin|True|False)\b|([∀∃λ→↔∧∨¬≤≥≠⟨⟩×∣∘∈∉⊆∅↑ℕℤℚℝ])|(\b\d+\b)/g;
const CLASSES = [null, "com", "str", "sorry", "kw", "ty", "sym", "num"];

function highlight(text) {
  let html = "", last = 0;
  for (const m of text.matchAll(TOKEN)) {
    html += esc(text.slice(last, m.index));
    const k = m.findIndex((g, i) => i > 0 && g !== undefined);
    html += `<span class="${CLASSES[k]}">${esc(m[0])}</span>`;
    last = m.index + m[0].length;
  }
  return html + esc(text.slice(last)) + "\n";
}

function render() {
  const text = src.value;
  hl.innerHTML = highlight(text);
  const n = text.split("\n").length;
  const sev = {};
  for (const d of diagnostics)
    for (let l = d.line; l <= Math.max(d.line, d.endLine); l++)
      if (sev[l] !== "err") sev[l] = d.severity === "error" ? "err" : "warn";
  gutter.innerHTML = Array.from({ length: n }, (_, i) =>
    sev[i + 1] ? `<span class="${sev[i + 1]}">${i + 1}</span>` : String(i + 1)).join("\n");
  marks.innerHTML = Object.entries(sev).filter(([l]) => l <= n).map(([l, s]) =>
    `<div class="${s}" style="top: calc(var(--pad) + ${l - 1} * var(--lh))"></div>`).join("");
}

/* The textarea is as big as its text, so the editor box scrolls, not the textarea, and the
   browser no longer brings the caret into view by itself. Do it here. */
const measure = document.createElement("canvas").getContext("2d");
function revealCaret() {
  const box = $("editor");
  const before = src.value.slice(0, src.selectionEnd).split("\n");
  const style = getComputedStyle(src);
  measure.font = `${style.fontSize} ${style.fontFamily}`;
  const pad = parseFloat(style.paddingLeft), lh = parseFloat(style.lineHeight);
  const x = pad + measure.measureText(before[before.length - 1]).width + $("gutter").offsetWidth;
  const y = parseFloat(style.paddingTop) + (before.length - 1) * lh;
  const margin = 24;
  if (x > box.scrollLeft + box.clientWidth - margin) box.scrollLeft = x - box.clientWidth + margin;
  else if (x - $("gutter").offsetWidth < box.scrollLeft + margin) box.scrollLeft = Math.max(0, x - $("gutter").offsetWidth - margin);
  const top = box.getBoundingClientRect().top + y, bottom = top + lh;
  if (bottom > innerHeight - 8) scrollBy(0, bottom - innerHeight + 80);
  else if (top < 60) scrollBy(0, top - 80);
}

/* Replace el.value[start, end) with `s`, keeping the browser's undo history when possible. */
function replaceRange(el, start, end, s, caret) {
  expanding = true;
  el.focus();
  el.setSelectionRange(start, end);
  if (!document.execCommand("insertText", false, s)) el.setRangeText(s, start, end, "end");
  expanding = false;
  if (caret !== undefined) el.setSelectionRange(caret, caret);
}

/* The `\name` being typed just before position `pos`, if any. */
function pending(el, pos) {
  const m = /\\([^\s\\]*)$/.exec(el.value.slice(Math.max(0, pos - 12), pos));
  return m ? { start: pos - m[0].length, name: m[1] } : null;
}
function expandAt(el, pos) {
  const p = pending(el, pos);
  if (!p || !ABBREV[p.name]) return false;
  replaceRange(el, p.start, pos, ABBREV[p.name]);
  return true;
}

/* Turn `\name` into symbols while typing in `el`. `onChange` runs after every edit.
   Only a textarea gets Tab-indentation, auto-indent and Ctrl+Enter (`onRun`). */
function attachAbbrev(el, onChange, onRun) {
  const multiline = el.tagName === "TEXTAREA";
  el.addEventListener("input", (e) => {
    if (!expanding && e.inputType === "insertText" && e.data) {
      const pos = el.selectionStart;
      const ch = e.data[e.data.length - 1];
      if (/\s/.test(ch)) {
        const p = pending(el, pos - 1);
        if (p && ABBREV[p.name]) {
          const sym = ABBREV[p.name];
          replaceRange(el, p.start, pos - 1, sym, p.start + sym.length + 1);
        }
      } else {
        const p = pending(el, pos);
        if (p && p.name) {
          const longer = NAMES.some((n) => n !== p.name && n.startsWith(p.name));
          if (ABBREV[p.name] && !longer) replaceRange(el, p.start, pos, ABBREV[p.name]);
          else if (!NAMES.some((n) => n.startsWith(p.name))) {
            const sym = ABBREV[p.name.slice(0, -1)];
            if (sym) replaceRange(el, p.start, pos - 1, sym, p.start + sym.length + 1);
          }
        }
      }
    }
    onChange();
    if (el === src) revealCaret();
  });

  el.addEventListener("keydown", (e) => {
    if (e.key === "Enter" && (e.ctrlKey || e.metaKey) && onRun) {
      e.preventDefault();
      onRun();
    } else if (e.key === "Tab" && !e.shiftKey && !e.ctrlKey && !e.altKey) {
      if (expandAt(el, el.selectionStart)) e.preventDefault();
      else if (multiline) { e.preventDefault(); replaceRange(el, el.selectionStart, el.selectionEnd, "  "); }
    } else if (e.key === "Enter" && !e.shiftKey && !e.altKey) {
      // finish a pending abbreviation; in the editor also keep the current line's indentation
      if (multiline) e.preventDefault();
      const done = expandAt(el, el.selectionStart);
      if (multiline) {
        const pos = el.selectionStart;
        const lineStart = el.value.lastIndexOf("\n", pos - 1) + 1;
        const indent = /^[ \t]*/.exec(el.value.slice(lineStart, pos))[0];
        replaceRange(el, pos, el.selectionEnd, "\n" + indent);
        onChange();
      } else if (done) onChange();
    }
  });
}

attachAbbrev(src, () => {
  diagnostics = [];
  render();
  store.set(`draft.${level.id}`, src.value);
  renderTests();
  updateSummary();
}, () => runTests());

/* Select a (1-based line, 0-based codepoint column) range from a Lean message. */
function jumpTo(d) {
  const lines = src.value.split("\n");
  const offset = (line, col) => {
    let o = 0;
    for (let i = 0; i < Math.min(line - 1, lines.length); i++) o += lines[i].length + 1;
    return o + Array.from(lines[line - 1] || "").slice(0, col).join("").length;
  };
  src.focus();
  src.setSelectionRange(offset(d.line, d.col), offset(d.endLine, d.endCol));
}

/* Saved progress is keyed by level number. Before the folders were renumbered to follow the
   play order, a level's number was its position in an older, scattered numbering: move what
   a returning player saved to the new numbers, once. */
(function migrateLevelNumbers() {
  if (store.get("numbering", 1) >= 2) return;
  const NEW = { 4: 1, 5: 2, 6: 3, 15: 4, 23: 5, 7: 6, 8: 7, 9: 8, 24: 9, 16: 10, 17: 11, 25: 12, 10: 13, 11: 14,
    12: 15, 13: 16, 18: 17, 26: 18, 1: 19, 27: 20, 19: 21, 20: 22, 21: 23, 28: 24, 22: 25, 29: 26, 14: 27, 2: 28, 3: 29 };
  const PER_LEVEL = ["draft", "results", "predict", "revealed", "failedRuns", "hintsOpened", "stars"];
  const moved = {};
  for (const [o, n] of Object.entries(NEW)) for (const what of PER_LEVEL) {
    const v = store.get(`${what}.${o}`, undefined);
    if (v !== undefined) moved[`${what}.${n}`] = v;
  }
  for (const [o] of Object.entries(NEW)) for (const what of PER_LEVEL) {
    try { localStorage.removeItem(`leancraftgame.${what}.${o}`); } catch { /* private mode */ }
  }
  for (const [k, v] of Object.entries(moved)) store.set(k, v);
  store.set("cleared", store.get("cleared", []).map((id) => NEW[id] ?? id));
  const at = store.get("level", "intro");
  if (at !== "intro") store.set("level", NEW[at] ?? at);
  store.set("numbering", 2);
})();

/* ------------------------------------------------------------ levels */

/* Online (a static site, see online/build.py) the levels are files, and the tests run on the
   Lean Playground through live.js; locally they come from, and run on, web/server.py. */
const ONLINE = Boolean(window.LEANCRAFT?.online);
let hosted = null;                     // online: { levels: every level with its tests, prelude }

let levels = [], level = null;

async function loadLevels() {
  if (ONLINE) {
    const [all, prelude] = await Promise.all([fetch("data/levels.json").then((r) => r.json()),
      fetch("data/prelude.lean").then((r) => r.text())]);
    hosted = { levels: all, prelude };
    levels = all.map(({ id, num, world, title, skill }) => ({ id, num, world, title, skill }));
  } else levels = await (await fetch("/api/levels")).json();
  // the Welcome page for a first visit; otherwise where the player was (a link wins)
  const want = new URLSearchParams(location.search).get("level") ?? store.get("level", "intro");
  if (want === "intro") return openIntro();
  const id = Number(want);
  await openLevel(levels.some((l) => l.id === id) ? id : levels[0].id);
}

/* The level menu shows every world, and the levels of the open worlds only. By default that
   is the world of the current level; a click on a world opens or closes it (until the player
   moves to another level). */
let worldToggled = {};                 // world -> true/false, set by clicking on it

function renderTabs() {
  const cleared = store.get("cleared", []);
  const current = level ? level.world : null;
  let html = `<button class="level-tab welcome${level ? "" : " active"}" data-id="intro"
    title="What Lean is, and how this game works"><span class="ttl">Welcome</span></button>`;
  for (const world of [...new Set(levels.map((l) => l.world))]) {
    const inWorld = levels.filter((l) => l.world === world);
    const open = worldToggled[world] ?? world === current;
    const done = inWorld.filter((l) => cleared.includes(l.id)).length;
    html += `<span class="world${open ? " open" : ""}"><button class="world-toggle" data-world="${esc(world)}"
      aria-expanded="${open}" title="${open ? "Hide" : "Show"} the levels of this world"><span class="caret">${open ? "▾" : "▸"}</span>
      ${esc(world)} <span class="count">${done}/${inWorld.length}</span></button>`;
    if (open) for (const l of inWorld)
      html += `<button class="level-tab${level && l.id === level.id ? " active" : ""}" data-id="${l.id}"
        title="Level ${l.num} · ${esc(l.title)} (${esc(l.skill)})"><span class="num">${l.num}</span>
        <span class="ttl">${esc(l.title)}</span>${cleared.includes(l.id) ? doneMark(l.id) : ""}</button>`;
    html += "</span>";
  }
  $("levels").innerHTML = html;
  for (const b of $("levels").querySelectorAll("button")) {
    if (b.dataset.world) b.onclick = () => {
      worldToggled[b.dataset.world] = b.getAttribute("aria-expanded") !== "true";
      renderTabs();
      $("levels").querySelector(`.world-toggle[data-world="${CSS.escape(b.dataset.world)}"]`)?.focus();
    };
    else b.onclick = () => (b.dataset.id === "intro" ? openIntro() : openLevel(Number(b.dataset.id)));
  }
}

/* The Welcome page: the introduction replaces the editor and the report. */
async function openIntro() {
  stopRun();
  const text = ONLINE ? await (await fetch("data/intro.md")).text()
    : (await (await fetch("/api/intro")).json()).markdown;
  level = null;
  store.set("level", "intro");
  history.replaceState(null, "", "?level=intro");
  document.title = "Lean Craft Game · Welcome";
  document.body.classList.add("intro-mode");
  worldToggled = {};
  renderTabs();
  $("intro").innerHTML = markdown(text) + `<p class="start"><button class="primary" id="start">
    Start with level 1: ${esc(levels[0].title)} →</button></p>`;
  $("start").onclick = () => openLevel(levels[0].id);
  window.scrollTo(0, 0);
}

async function openLevel(id) {
  stopRun();
  document.body.classList.remove("intro-mode");
  if (ONLINE) {
    const full = hosted.levels.find((l) => l.id === id);
    level = { ...full, tests: full.tests.map((t, i) => ({ id: i, name: t.name, kind: t.kind })) };
  } else level = await (await fetch(`/api/levels/${id}`)).json();
  store.set("level", id);
  history.replaceState(null, "", `?level=${id}`);
  document.title = `Lean Craft Game · ${level.title}`;
  worldToggled = {};
  renderTabs();
  $("intro").innerHTML = markdown(level.intro);
  src.value = store.get(`draft.${id}`, level.template);
  diagnostics = [];
  render();
  $("diagnostics").innerHTML = "";
  openHints = new Set();
  draftPredictions = {};
  resetReport();
}

$("reset").onclick = () => {
  if (src.value !== level.template && !confirm("Discard your changes and restore the original file?")) return;
  src.value = level.template;
  store.set(`draft.${level.id}`, src.value);
  diagnostics = [];
  render();
  renderTests();
  updateSummary();
};

/* ------------------------------------------------------------ predict first, hidden tests, hints */

/* Three mechanics keep the player thinking about the *meaning* of a definition, instead of
   turning the test list green by trial and error:

   * Predictions (`predict` in level.json): before the first run of a level, the player says
     whether a few statements should be true or false. The answers lock in, and are marked
     right or wrong; those tests then stay visible.
   * Hidden tests: apart from the predicted ones and those listed in `public` (or every test
     with `"public": "all"`), a test is hidden until it fails or comes back ❓, and every
     test is shown once the level is cleared.
   * Gated hints: hints unlock after `hintsAfter` failed runs (default 2), one step at a
     time: each further failed run unlocks the next step of the hint (its `steps`, then the
     `hint` itself). A failed run is one with a ❌ (or ⚠️): a ❓ is not a verdict against the
     player's definition, so it neither counts as a failure nor shows a hint (hints are
     written for a test that failed, and would claim something the referee did not prove).

   Clearing a level earns up to three stars: one for clearing it, one for not opening a hint,
   and one for predicting every statement right (or, in a level without predictions, for
   clearing it without a failed run). The best result is kept. */

const levelKey = (what) => `${what}.${level.id}`;
let draftPredictions = {};             // choices made but not locked in yet
let openHints = new Set();             // tests whose hint is open, kept across re-renders

const probes = () => level.predict || [];
const predictions = () => store.get(levelKey("predict"), null);      // {test: bool} | "skipped" | null
const predictionsPending = () => probes().length > 0 && predictions() === null;
const isModelKind = (kind) => kind === "expect_model" || kind === "expect_not_model";
const expectedTrue = (kind) => kind === "expect_true" || kind === "expect_model";

function isCleared(id) { return store.get("cleared", []).includes(id); }

function revealed() { return new Set(store.get(levelKey("revealed"), [])); }
function reveal(name) {
  const r = revealed();
  if (!r.has(name)) store.set(levelKey("revealed"), [...r, name]);
}

/* Is the test shown in the report? */
function isVisible(t) {
  if (level.public === "all" || isCleared(level.id)) return true;
  if ((level.public || []).includes(t.name)) return true;
  if (probes().some((p) => p.test === t.name)) return !predictionsPending();
  return revealed().has(t.name);
}

/* The prediction for a probe test: null when there is none, else { said, right }. */
function predictionFor(t) {
  const p = predictions();
  if (!p || p === "skipped" || !(t.name in p)) return null;
  return { said: p[t.name], right: p[t.name] === expectedTrue(t.kind) };
}

function allPredictionsRight() {
  const p = predictions();
  if (!p || p === "skipped") return false;
  return probes().every((q) => {
    const t = tests.find((x) => x.name === q.test);
    return t && p[q.test] === expectedTrue(t.kind);
  });
}

function renderPredict() {
  const box = $("predict");
  if (!level || !predictionsPending()) { box.hidden = true; box.innerHTML = ""; return; }
  box.hidden = false;
  const rows = probes().map((q, i) => {
    const t = tests.find((x) => x.name === q.test);
    const [yes, no] = isModelKind(t.kind) ? ["allowed", "not allowed"] : ["true", "false"];
    const pick = draftPredictions[q.test];
    const btn = (val, label) => `<button class="choice${pick === val ? " picked" : ""}" data-i="${i}" data-v="${val}"
      aria-pressed="${pick === val}">${label}</button>`;
    return `<li><span class="statement">${nameToHtml(q.statement)}</span>
      <span class="choices">${btn(true, yes)}${btn(false, no)}</span></li>`;
  }).join("");
  const ready = probes().every((q) => q.test in draftPredictions);
  box.innerHTML = `<h3>Before you run: predict</h3>
    <p class="muted">For each statement, what should the answer be, if the definitions mean what the
      lesson says? Your answers lock in when you confirm them, and the referee then checks your
      definitions on exactly these statements, among others.</p>
    <ol class="probes">${rows}</ol>
    <div class="predict-buttons"><button class="quiet" id="predict-skip">Skip (no ★ for predictions)</button>
      <button class="primary" id="predict-lock"${ready ? "" : " disabled"}>Lock in my predictions</button></div>`;
  for (const b of box.querySelectorAll("button.choice"))
    b.onclick = () => {
      draftPredictions[probes()[Number(b.dataset.i)].test] = b.dataset.v === "true";
      renderPredict();
    };
  $("predict-lock").onclick = () => { store.set(levelKey("predict"), { ...draftPredictions }); afterPredict(); };
  $("predict-skip").onclick = () => { store.set(levelKey("predict"), "skipped"); afterPredict(); };
}

function afterPredict() {
  renderPredict();
  renderTests();
  const p = predictions(), wrong = p && p !== "skipped" ? probes().filter((q) => {
    const t = tests.find((x) => x.name === q.test);
    return p[q.test] !== expectedTrue(t.kind);
  }).length : 0;
  updateSummary(p === "skipped" ? "" : wrong
    ? `${wrong === 1 ? "One prediction was" : `${wrong} predictions were`} wrong: see ✗ below. Re-read the lesson before you write your definition.`
    : "All your predictions are right. Now make your definition agree with them.");
}

/* Hints: the tiers of the first hint that matches the test, and how many are unlocked. */
function hintFor(name) {
  const h = level.hints.find((h) => name.includes(h.match));
  return h ? [...(h.steps || []), h.hint] : null;
}
const failedRuns = () => store.get(levelKey("failedRuns"), 0);
const hintsAfter = () => level.hintsAfter ?? 2;
const tiersUnlocked = () => Math.max(0, failedRuns() - hintsAfter() + 1);

function hintHtml(t) {
  const tiers = hintFor(t.name);
  if (!tiers) return "";
  const k = Math.min(tiers.length, tiersUnlocked());
  if (k === 0) {
    const more = hintsAfter() - failedRuns();
    return `<div class="hint-locked">🔒 A hint unlocks after ${more === 1 ? "one more failed run" : `${more} more failed runs`}.
      Until then: which input would show what is wrong?</div>`;
  }
  const label = tiers.length > 1 ? `Hint (${k} of ${tiers.length})` : "Hint";
  const items = tiers.slice(0, k).map((h) => `<li>${inline(h)}</li>`).join("");
  const more = k < tiers.length ? '<p class="muted">The next step of this hint unlocks after your next failed run.</p>' : "";
  return `<details data-name="${esc(t.name)}"${openHints.has(t.name) ? " open" : ""}><summary>${label}</summary>
    <ol class="hint-steps">${items}</ol>${more}</details>`;
}

/* Stars for the current state of the level; the best ever is kept in `stars.<id>`. */
function starFlags() {
  return { noHints: !store.get(levelKey("hintsOpened"), false),
           sharp: probes().length ? allPredictionsRight() : failedRuns() === 0 };
}
function starsNow() {
  const f = starFlags();
  return 1 + f.noHints + f.sharp;
}
function doneMark(id) {
  const n = store.get(`stars.${id}`, 0);
  return n ? `<span class="done" title="cleared, ${n} of 3 stars">${"★".repeat(n)}${"☆".repeat(3 - n)}</span>`
    : '<span class="done" title="cleared">✓</span>';
}
function starsLine() {
  const f = starFlags();
  const item = (got, what) => `<li class="${got ? "got" : ""}">${got ? "★" : "☆"} ${what}</li>`;
  return `<ul class="stars">${item(true, "level cleared")}${item(f.noHints, "no hint opened")}${
    item(f.sharp, probes().length ? "every prediction right" : "cleared without a failed run")}</ul>`;
}

/* ------------------------------------------------------------ report */

/* Each test remembers the code its result was computed for (`t.code`). A result only
   counts while the editor holds exactly that code; after an edit it is shown as
   undefined. A level is cleared when every test has passed on the same code. */

const KIND = {
  expect_true: "must be true", expect_false: "must be false", expect_open: "must stay open",
  expect_model: "must be allowed", expect_not_model: "must be ruled out",
  expect_caught: "must be caught",
};
const ICON = { pass: "✅", fail: "❌", unknown: "❓", error: "⚠️" };
let tests = [], ticker = null, controller = null;
let setupReady = true;     // false while the app is still installing Lean and Mathlib

/* The state to show: a finished result for other code is undefined ("waiting"). */
function view(t) {
  if (t.state === "running" || t.state === "queued") return t.state;
  return t.code === src.value ? t.state : "waiting";
}

function saveResults() {
  const keep = {};
  for (const t of tests)
    if (ICON[t.state]) keep[t.name] = { state: t.state, detail: t.detail, seconds: t.seconds, cached: t.cached, code: t.code };
  store.set(`results.${level.id}`, keep);
}

function resetReport() {
  const saved = store.get(`results.${level.id}`, {});
  tests = level.tests.map((t) => ({ ...t, state: "waiting", ...(saved[t.name] || {}) }));
  renderTests();
  updateSummary();
}

function setSummary(cls, html) {
  $("summary").className = "summary " + cls;
  $("summary").innerHTML = html;
}

function renderTests() {
  const busy = controller !== null || !setupReady;
  renderPredict();
  const hidden = tests.filter((t) => !isVisible(t));
  $("tests").innerHTML = tests.filter(isVisible).map((t) => {
    const v = view(t);
    let icon = "○", time = "", title = "not run on the current code";
    if (v === "running") { icon = '<span class="spin"></span>'; time = ((Date.now() - t.started) / 1000).toFixed(0) + " s"; title = "running"; }
    else if (v === "queued") { icon = '<span class="spin idle"></span>'; title = "waiting for a free slot"; }
    else if (ICON[v]) { icon = ICON[v]; time = t.cached ? "cached" : t.seconds + " s"; title = ""; }
    else if (v === "skipped") { icon = "–"; title = "not run: the run stopped at the first failure"; }
    const shown = ICON[v] || v === "skipped";
    const hint = v === "fail" ? hintHtml(t) : v === "unknown" ? UNSETTLED : "";
    const p = predictionFor(t);
    const yes = isModelKind(t.kind) ? "allowed" : "true", no = isModelKind(t.kind) ? "not allowed" : "false";
    const said = p && `<div class="prediction ${p.right ? "right" : "wrong"}">You predicted <b>${p.said ? yes : no}</b>
      ${p.right ? "✓" : `✗: the intended answer is <b>${p.said ? no : yes}</b>.`}
      ${p.right && v === "fail" ? " You knew the answer; your definition does not say it yet." : ""}</div>`;
    return `<li class="test ${v}">
      <div class="row"><span class="icon" title="${title}">${icon}</span><span class="name">${nameToHtml(t.name)}</span>
        <span class="kind">${KIND[t.kind] || ""}</span><span class="time">${time}</span>
        <button class="run1" data-id="${t.id}" title="Run only this test on the current code"${busy ? " disabled" : ""}>▶</button></div>
      ${said || ""}
      ${shown && t.detail ? `<div class="detail">${esc(t.detail)}</div>` : ""}
      ${hint}
    </li>`;
  }).join("") + hiddenRow(hidden);
  for (const d of $("tests").querySelectorAll("details[data-name]"))
    d.addEventListener("toggle", () => {
      if (d.open) { openHints.add(d.dataset.name); store.set(levelKey("hintsOpened"), true); }
      else openHints.delete(d.dataset.name);
    });
  for (const b of $("tests").querySelectorAll("button.run1"))
    b.onclick = () => runTests([Number(b.dataset.id)]);
}

/* Shown under a ❓ instead of a hint: hints are written for a test that failed. */
const UNSETTLED = `<div class="hint-locked">❓ is not a verdict against your definition: the referee could
  neither prove nor refute this one in time. If the other tests pass, try a simpler way of writing
  your definition or your example (the referee is a small search, not a mathematician).</div>`;

/* One row standing for the tests that are still hidden. */
function hiddenRow(hidden) {
  if (!hidden.length) return "";
  const vs = hidden.map(view), n = (s) => vs.filter((v) => v === s).length;
  const busy = n("running") + n("queued");
  const parts = [n("pass") && `${n("pass")} ✅`, busy && `${busy} running`,
    hidden.length - n("pass") - busy > 0 && `${hidden.length - n("pass") - busy} not run on this code`].filter(Boolean);
  return `<li class="test hidden-tests"><div class="row"><span class="icon">🔒</span>
    <span class="name">${hidden.length === 1 ? "1 hidden test" : `${hidden.length} hidden tests`}</span>
    <span class="kind">${parts.join(" · ")}</span></div>
    <div class="detail">A hidden test shows up when it fails. Do not wait for it: which inputs could break your definition?</div></li>`;
}

/* The summary box, from the results that hold for the current code. */
function updateSummary(note = "") {
  if (controller) return;
  const vs = tests.map(view), total = tests.length;
  const n = (s) => vs.filter((v) => v === s).length;
  const passed = n("pass"), failed = n("fail") + n("error");
  const stale = tests.some((t) => ICON[t.state] && t.code !== src.value);
  const line = `<div class="score">${passed}/${total} passed on this code</div>`;
  const pre = note ? note + "<br>" : "";
  if (passed === total) {
    const cleared = store.get("cleared", []), n = starsNow();
    const wasHidden = tests.some((t) => !isVisible(t));
    if (!cleared.includes(level.id)) store.set("cleared", [...cleared, level.id]);
    if (n > store.get(levelKey("stars"), 0)) store.set(levelKey("stars"), n);
    renderTabs();
    if (wasHidden) renderTests();          // a cleared level shows every test
    const next = levels[levels.findIndex((l) => l.id === level.id) + 1];
    setSummary("cleared", `🏆 <b>Level cleared!</b> Every test passed on this code.${line}${starsLine()}` +
      (next ? `<button class="primary" id="next">Next: ${esc(next.title)} →</button>` : "You have cleared the last level."));
    if (next) $("next").onclick = () => openLevel(next.id);
  } else if (failed) {
    setSummary("failed", `${pre}🔁 <b>Not yet.</b> Read the ❌ test below: it tells you what your
      definition gets wrong.${line}`);
  } else if (passed || n("unknown")) {
    setSummary("", `${pre}${line}${n("unknown") ? `${n("unknown")} could not be settled. ` : ""}
      Press <b>Run tests</b> to run the rest, or ▶ to run a single test.`);
  } else {
    setSummary("muted", pre + (stale
      ? "Your code changed since the last run, so the earlier results no longer apply. Press <b>Run tests</b>."
      : "Write your definition, then press <b>Run tests</b>."));
  }
}

function progress(ids) {
  const done = ids.filter((i) => ICON[tests[i].state] || tests[i].state === "skipped").length;
  const what = ids.length === 1 ? "1 test" : `${ids.length} tests`;
  setSummary("", `Running ${what}… ${done}/${ids.length} done
    <div class="progress"><div style="width:${(100 * done) / ids.length}%"></div></div>`);
}

function showCompile(c) {
  diagnostics = c.diagnostics;
  render();
  $("diagnostics").innerHTML = c.diagnostics.map((d, i) =>
    `<button class="diag ${d.severity}" data-i="${i}"><span class="where">${d.severity === "error" ? "Error" : "Warning"} on line ${d.line}</span>${esc(d.text)}</button>`).join("") +
    c.problems.map((p) => `<div class="diag error">${inline(p)}</div>`).join("");
  for (const b of $("diagnostics").querySelectorAll("button.diag"))
    b.onclick = () => jumpTo(c.diagnostics[Number(b.dataset.i)]);
}

/* Run the tests `ids` (all of them when null) on the current code. A full run stops at
   the first failure; a single test always runs to the end. */
async function runTests(ids = null) {
  if (!setupReady) return;
  if (predictionsPending()) {
    updateSummary("<b>Predict first.</b> Lock in your predictions above (or skip them): they cannot be changed once you have seen the referee's verdicts.");
    $("predict").classList.remove("flash");
    void $("predict").offsetWidth;                 // restart the animation
    $("predict").classList.add("flash");
    return;
  }
  stopRun();
  const code = src.value, ctl = (controller = new AbortController());
  let run = [], outcome = null, failedThisRun = false;
  $("run").hidden = true;
  $("stop").hidden = false;
  $("diagnostics").innerHTML = "";
  ticker = setInterval(() => tests.some((t) => t.state === "running") && renderTests(), 1000);
  const handle = (event, data) => {
    if (event === "tests") {
      run = data.map((t) => t.id);
      for (const i of run) Object.assign(tests[i], { state: "queued", code, detail: "", cached: false });
      setSummary("", '<span class="spin"></span> Compiling your code…');
    } else if (event === "compile") {
      showCompile(data);
      if (!data.ok) {
        for (const i of run) Object.assign(tests[i], { state: "waiting", code: undefined });
        outcome = "Your code does not compile yet, or does not fit the level. Fix the problems shown below the editor.";
      } else progress(run);
    } else if (event === "start") {
      Object.assign(tests[data.id], { state: "running", started: Date.now() });
    } else if (event === "result") {
      Object.assign(tests[data.id], { state: data.status, detail: data.detail, seconds: data.seconds, cached: data.cached, code });
      if (data.status !== "pass") reveal(tests[data.id].name);
      if (data.status === "fail" || data.status === "error") failedThisRun = true;
      progress(run);
    } else if (event === "skipped") {
      Object.assign(tests[data.id], { state: "skipped", detail: "", code });
    } else if (event === "done") {
      outcome = data.stopped ? "Stopped at the first failure: the remaining tests were not run." : "";
    } else if (event === "fatal") {
      outcome = `The server hit an error: ${esc(data.message)}`;
    }
    renderTests();
  };
  try {
    if (ONLINE) {
      const full = hosted.levels.find((l) => l.id === level.id);
      await LiveRunner.run({ level: full, prelude: hosted.prelude, code, ids, stopOnFail: ids === null }, handle, ctl.signal);
    } else {
      const res = await fetch(`/api/levels/${level.id}/run`, {
        method: "POST", signal: ctl.signal,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ code, tests: ids, stopOnFail: ids === null }),
      });
      const reader = res.body.pipeThrough(new TextDecoderStream()).getReader();
      let buf = "";
      for (;;) {
        const { value, done } = await reader.read();
        if (done) break;
        buf += value;
        let i;
        while ((i = buf.indexOf("\n\n")) >= 0) {
          const chunk = buf.slice(0, i);
          buf = buf.slice(i + 2);
          const ev = /^event: (.*)$/m.exec(chunk), data = /^data: (.*)$/m.exec(chunk);
          if (ev && data) handle(ev[1], JSON.parse(data[1]));
        }
      }
    }
  } catch (err) {
    if (err.name !== "AbortError") outcome = ONLINE ? `Could not check your code: ${esc(err.message || String(err))}`
      : `Lost contact with the server (${esc(String(err))}). Is <code>web/server.py</code> still running?`;
  }
  if (controller !== ctl) return;           // superseded or stopped
  if (outcome === null) outcome = "The run ended unexpectedly. Check the server's terminal.";
  if (failedThisRun) {
    const before = tiersUnlocked();
    store.set(levelKey("failedRuns"), failedRuns() + 1);
    if (tiersUnlocked() > before) outcome += (outcome ? " " : "") + "A new hint step has unlocked.";
  }
  endRun();
  saveResults();
  renderTests();
  updateSummary(outcome);
}

function endRun() {
  clearInterval(ticker);
  controller = null;
  $("run").hidden = false;
  $("stop").hidden = true;
}

function stopRun() {
  if (!controller) return;
  controller.abort();
  endRun();
  tests.forEach((t) => { if (t.state === "running" || t.state === "queued") Object.assign(t, { state: "waiting", code: undefined }); });
  if (level) {
    renderTests();
    updateSummary("Stopped.");
  }
}


/* ------------------------------------------------------------ symbols drawer */

/* symbol, keys to type (the first one is the usual), meaning, ASCII alternative */
const SYMBOLS = [
  ["∀", ["\\forall", "\\all"], "for all", "forall"],
  ["∃", ["\\exists", "\\ex"], "there exists", "exists"],
  ["→", ["\\to", "\\r"], "implies, or function arrow", "->"],
  ["↔", ["\\iff"], "if and only if", "<->"],
  ["∧", ["\\and"], "and", "/\\"],
  ["∨", ["\\or"], "or", "\\/"],
  ["¬", ["\\not", "\\neg"], "not", "Not p"],
  ["≤", ["\\le", "\\leq"], "less than or equal", "<="],
  ["≥", ["\\ge", "\\geq"], "greater than or equal", ">="],
  ["≠", ["\\ne", "\\neq"], "not equal", "¬ a = b"],
  ["ℕ", ["\\N", "\\nat"], "natural numbers", "Nat"],
  ["ℤ", ["\\Z"], "integers", "Int"],
  ["ℚ", ["\\Q"], "rational numbers", "Rat"],
  ["ℝ", ["\\R"], "real numbers", "Real"],
  ["↑", ["\\u"], "cast (Lean shows it; you write (n : ℤ))", ""],
  ["∈", ["\\in"], "is an element of", ""],
  ["∉", ["\\notin"], "is not an element of", "¬ x ∈ s"],
  ["⊆", ["\\sub"], "is a subset of", ""],
  ["∅", ["\\empty"], "the empty set", ""],
  ["∣", ["\\|", "\\mid"], "divides (not the keyboard bar)", ""],
  ["α", ["\\a", "\\alpha"], "a type variable", ""],
  ["ε", ["\\e", "\\epsilon"], "epsilon", ""],
  ["₀ ₁ ₂", ["\\_0", "\\_1", "\\_2"], "subscripts, as in Group₂", ""],
];
const PRIMARY = {};
for (const [sym, keys] of SYMBOLS) if (sym.length === 1) PRIMARY[sym] = keys[0];
for (let i = 0; i <= 9; i++) PRIMARY["₀₁₂₃₄₅₆₇₈₉"[i]] = "\\_" + i;

const DRILL = ["→", "∀", "∃", "∧", "∨", "¬", "≤", "≥", "≠", "ℕ", "x₁",
  "∀ n, n ≤ 5", "∃ n, n ≠ 0 ∧ n ≥ 1", "¬ (p ∨ q)", "Nat → Nat",
  "∀ n, 5 ≤ n → 3 ≤ u n", "∀ M, ∃ N, ∀ n ≥ N, M ≤ u n",
  "ℤ", "x ∈ s", "3 ∣ 12", "{α : Type*}", "∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε"];
let drillAt = 0;

function drillHelp(goal) {
  const keys = [...new Set([...goal].filter((c) => PRIMARY[c]))].map((c) => `<code>${esc(PRIMARY[c])}</code> → ${c}`);
  return keys.length ? keys.join(" · ") + " (then press space)" : "";
}

function renderDrill() {
  const done = store.get("symbolsDone", []);
  if (drillAt >= DRILL.length) {
    $("drill").innerHTML = `<p class="drill-ok">🎉 You can type every symbol of the game.</p>
      <button id="drill-restart">Practise again</button>`;
    $("drill-restart").onclick = () => { drillAt = 0; renderDrill(); };
    return;
  }
  const goal = DRILL[drillAt];
  $("drill").innerHTML = `
    <div class="drill-count">Exercise ${drillAt + 1} of ${DRILL.length}</div>
    <div class="drill-goal">${esc(goal)}</div>
    <div class="drill-help">${drillHelp(goal)}</div>
    <input id="drill-input" spellcheck="false" autocomplete="off" autocapitalize="off" placeholder="Type it here">
    <div class="drill-row"><span id="drill-status" class="muted"></span>
      <button id="drill-skip" class="quiet">Skip</button></div>`;
  const input = $("drill-input");
  let solved = false;
  attachAbbrev(input, () => {
    if (!solved && input.value.trim() === goal) {
      solved = true;
      $("drill-status").textContent = "✅ Correct!";
      store.set("symbolsDone", [...new Set([...done, goal])]);
      setTimeout(() => { drillAt++; renderDrill(); }, 500);
    } else $("drill-status").textContent = "";
  });
  $("drill-skip").onclick = () => { drillAt++; renderDrill(); };
  if (!$("symbols").hidden) input.focus();
}

function buildSymbols() {
  $("symtable").innerHTML = SYMBOLS.map(([sym, keys, meaning, ascii], i) => `
    <button class="sym-row" data-i="${i}" title="Insert into the editor">
      <span class="sym-char">${esc(sym)}</span>
      <span class="sym-keys">${keys.map((k) => `<code>${esc(k)}</code>`).join(" ")}</span>
      <span class="sym-meaning">${esc(meaning)}${ascii ? ` · or <code>${esc(ascii)}</code>` : ""}</span>
    </button>`).join("");
  for (const b of $("symtable").querySelectorAll("button")) {
    b.onclick = () => {
      if (!level) return;                       // the Welcome page has no editor
      const sym = SYMBOLS[Number(b.dataset.i)][0].split(" ")[0];
      replaceRange(src, src.selectionStart, src.selectionEnd, sym);
      diagnostics = [];
      render();
      store.set(`draft.${level.id}`, src.value);
      renderTests();
      updateSummary();
    };
  }
  renderDrill();
}

function toggleSymbols(show) {
  $("symbols").hidden = !(show ?? $("symbols").hidden);
  $("symbols-btn").setAttribute("aria-expanded", String(!$("symbols").hidden));
  if (!$("symbols").hidden && $("drill-input")) $("drill-input").focus();
}
$("symbols-btn").onclick = () => toggleSymbols();
$("symbols-close").onclick = () => toggleSymbols(false);
document.addEventListener("keydown", (e) => { if (e.key === "Escape") toggleSymbols(false); });
buildSymbols();

$("run").onclick = () => runTests();

/* ------------------------------------------------------------ report a problem */

/* Open a prefilled "new issue" page on GitHub. The code goes into the URL, so a long
   file is cut and the whole of it is copied to the clipboard for pasting instead. */
function reportProblem() {
  const lines = ["**What went wrong?**", "", "<!-- Describe the problem here. -->", "", "---",
    `Level: ${level ? `${level.num} · ${level.title}` : "Welcome page"}`,
    `Browser: ${navigator.userAgent}`];
  if (level) {
    const failing = tests.filter((t) => view(t) === "fail").map((t) => `- ❌ ${t.name}`);
    if (failing.length) lines.push("", "Failing tests:", ...failing.slice(0, 8));
    const url = (body) => `https://github.com/${REPO}/issues/new?` +
      new URLSearchParams({ title: level ? `Level ${level.num}: ` : "", body }).toString();
    const fence = (code) => ["", "My code:", "```lean", code.trimEnd(), "```"];
    let body = lines.concat(fence(src.value)).join("\n");
    if (url(body).length > 6000) {
      try { navigator.clipboard.writeText(src.value); } catch { /* no clipboard */ }
      const head = src.value.slice(0, 600);
      body = lines.concat(fence(head + "\n-- … (cut)"),
        ["", "_My full code is too long for the link. It was copied to the clipboard: please paste it here._"]).join("\n");
    }
    return window.open(url(body), "_blank", "noopener");
  }
  window.open(`https://github.com/${REPO}/issues/new?` +
    new URLSearchParams({ body: lines.join("\n") }), "_blank", "noopener");
}
$("report").onclick = reportProblem;

/* ------------------------------------------------------------ app: first-launch setup, quit */

function renderSetup(s) {
  $("setup").hidden = s.ready;
  $("run").disabled = !s.ready;
  $("run").title = s.ready ? "Ctrl+Enter" : "Available once Lean and Mathlib are installed";
  if (s.ready) return;
  $("setup-steps").innerHTML = s.steps.map((name, i) => {
    const icon = i < s.step ? "✅" : i === s.step ? (s.error ? "❌" : '<span class="spin"></span>') : "○";
    return `<li class="${i < s.step ? "done" : i === s.step ? "now" : ""}">${icon} ${esc(name)}</li>`;
  }).join("");
  $("setup-message").textContent = s.message || "";
  const p = s.progress;
  $("setup-bar").parentElement.hidden = !(p && p[1]);
  if (p && p[1]) $("setup-bar").style.width = `${Math.min(100, (100 * p[0]) / p[1]).toFixed(1)}%`;
  $("setup-error").hidden = !s.error;
  $("setup-error").textContent = s.error || "";
  $("setup-retry").hidden = !s.error;
}

async function watchSetup() {
  for (;;) {
    let s = null;
    try { s = await (await fetch("/api/setup")).json(); } catch { /* server restarting */ }
    if (s) {
      $("quit").hidden = !s.app;
      const was = setupReady;
      setupReady = s.ready;
      renderSetup(s);
      if (setupReady !== was && level) renderTests();
      if (s.ready) return;
    }
    await new Promise((r) => setTimeout(r, 700));
  }
}

$("setup-retry").onclick = () => fetch("/api/setup/retry", { method: "POST" });
$("quit").onclick = async () => {
  if (!confirm("Quit Lean Craft Game? Your code and progress are kept.")) return;
  stopRun();
  try { await fetch("/api/quit", { method: "POST" }); } catch { /* already gone */ }
  document.body.innerHTML = '<p class="bye">Lean Craft Game has stopped. You can close this tab.</p>';
};
if (!ONLINE) {
  setupReady = false;
  watchSetup();
}
$("stop").onclick = stopRun;
loadLevels();
