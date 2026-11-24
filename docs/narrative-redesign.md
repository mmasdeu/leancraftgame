# The redesigned game: sequences → limits → topology

## What changed and why

The earlier version appended a separate topology world after twelve mostly unrelated worlds.
This redesign changes the *entire learning narrative*. All 60 original lessons have new
story-led titles, objectives, act placement and forward bridges; topology T1–T15 receives
callbacks to the sequence and limit skills it uses. The three auditing levels move after T15
instead of interrupting the build-up to topology.

The path is deliberately cumulative:

1. **Sequences** make functions and predicates concrete. A property `P : (ℕ → ℕ) → Prop`
   is meaningful before it becomes syntax to memorise. Eventually, recurrence, divergence
   and boundedness create the quantifier patterns that convergence later reuses.
2. **Limits** turn those patterns into local and long-run reasoning. Finite sums teach exact
   index domains. Convergence uses `∀ ε > 0, ∃ N, …`; continuity uses the same quantifier
   discipline to control errors; Cauchy and cluster values force distinctions between a
   sequence and its subsequences.
3. **Topology** explains where those ideas live when distance is no longer available.
   Structure and class levels are not an arena of unrelated algebra: they teach how to
   package axioms and provide instances needed for spaces and filters. The topology course
   returns to convergence using neighbourhoods, filters and Hausdorff separation.

The last three levels are a coda about mathematical honesty, not a detour before topology.
They demonstrate that toy-world evidence, vacuity and compiler acceptance never justify a
universal conjecture.

## Progression and compatibility

`order` in `level.json` is now the narrative position. Stable IDs (`L1`, `T1`, saved drafts and
cleared-level records) do not change, so existing work is preserved. `web/server.py` discovers
levels and sorts them by `order`; online export uses the same registry. T15 is position 72,
and L58–L60 become positions 73–75 as the coda.

The mathematical answer formats and tests are retained, so every changed lesson still checks
against its existing solution and mutants. The narrative itself is validated separately:
every original lesson has a new objective and bridge, no old world remains, and every level
appears exactly once in the new three-act order.

## How to review the redesign

The full new sequence is listed in [CURRICULUM.md](../CURRICULUM.md). Each browser lesson
opens with its act and a reason for inclusion, preserves the worked explanation needed to
complete the exercise, and ends with the mathematical purpose of the next step.

A redesign review should ask:

* Does every task help a player describe or analyse a sequence, a limit, or a space?
* Are structure/class operations learned as tools for topological definitions?
* Does T15 genuinely depend on earlier convergence and separation concepts?
* Can a player finish topology and then understand what the coda does—and does not—establish?
