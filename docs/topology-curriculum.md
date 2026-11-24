# Topology world: curriculum and exercise contract

This is the content contract for T1–T15. It follows the attached implementation plan and
records the precise success conditions used by the implementation. Early levels use a small
pedagogical layer; Mathlib's topology API is introduced explicitly after the underlying ideas.
None of these exercises treats an inconclusive automated check as a refutation.

## Standard exercise metadata

`level.json` may contain an `exercises` list. Each item has:

```json
{
  "title": "Define disjointness",
  "type": "construct",
  "objective": "Express that two sets have no common element.",
  "success": ["disjoint sets have empty intersection"]
}
```

`type` is one of `construct`, `repair`, `classify`, `refute`, `referee`, or `connect`.
`success` names referee checks in `Tests.lean`; those checks are the unambiguous machine
condition. Hints match test names. Each level also keeps the normal `checks` type/signature
gates, `public`/`predict` visibility rules, and `hints` feedback. A level combines several
definitions or witness values in one `Player.lean`; there is no separate UI format per type.

Two outcomes are deliberately distinct: ❌ means Lean proved an axiom false or proved an
anti-theorem true, while ❓ means the checker did not settle it. Finite exhaustive checks are
kept in specialised finite tests; general claims use Lean theorems.

## Dependency order

Sets and families (T1–T2) precede relations (T3) and the topology structure (T4). Standard
examples (T5) feed every later level. Closure and bases (T6–T7) precede continuity (T8), and
continuity precedes homeomorphisms, subspaces and products (T9–T11). Those constructions feed
compactness, connectedness and separation (T12–T14). Neighbourhoods, filters and convergence
(T15) come last; mathematical filters are not used earlier.

## T1 — Sets and operations

**Objective:** use membership, set operations and inverse images without confusing element
and subset statements.

1. **Construct — disjointness:** define `MyDisjoint s t`; success proves equivalence to
   `s ∩ t = ∅` on arbitrary sets and checks overlapping/non-overlapping concrete sets.
2. **Construct — cover:** define `IsCover s C`, meaning every member of `s` belongs to some
   member of `C`; success checks positive/negative finite covers and the union characterisation.
3. **Connect — inverse images:** state preimage compatibility with union and intersection;
   concrete equalities are checked by extensionality and `simp`.
4. **Refute — direct images:** supply two sets and a map for which
   `f '' (s ∩ t) ≠ (f '' s) ∩ (f '' t)`; success verifies the witnesses and inequality.

## T2 — Families of sets

**Objective:** distinguish indexed/arbitrary unions from finite intersections and subcovers.

1. **Construct — family:** define a family as an indexed collection `ι → Set α`, with explicit
   checks on the indexed union.
2. **Construct — closure properties:** define `ClosedUnderUnions` and
   `ClosedUnderBinaryIntersections`; success checks intended positive and negative families.
3. **Connect — finite intersections:** prove binary intersection plus `univ` gives every
   finite intersection, including the empty finite intersection.
4. **Refute — closure mismatch:** construct `{∅,{0},{1},univ}` on `Fin 3` as an executable
   `List (Finset (Fin 3))`; the shared finite checker verifies binary-intersection closure and
   diagnoses the missing union `{0,1}`. General closure claims remain Lean propositions.

## T3 — Relations and partitions

**Objective:** connect equivalence axioms, classes, partitions and fibres.

1. **Construct — relation axioms:** define reflexive, symmetric and transitive predicates;
   concrete models and non-models test each axis independently.
2. **Construct — equivalence relation:** package the three axioms, with equality and modular
   congruence as accepted models and `<` as a rejected model.
3. **Construct — equivalence class:** define `EquivClass R x`; success proves membership and
   equality for a concrete equivalence.
4. **Connect — partition to relation:** define the relation “in the same block”; success
   proves the three axioms from partition hypotheses.
5. **Connect — fibres:** express the fibre of `f` over `y` and prove fibres are equivalence
   classes for the relation `f a = f b`.

## T4 — The definition of a topology

**Objective:** construct and audit `MyTopology` before using Mathlib's `TopologicalSpace`.

1. **Construct — topology structure:** complete `MyTopology` with `IsOpen`, `univ`, arbitrary
   unions and binary intersections; accepted/rejected models test each field.
2. **Classify — empty versus universal:** derive that `∅` is open and check families missing
   `∅` or `univ` are not topologies.
3. **Classify — arbitrary unions and binary intersections:** finite exhaustive tests identify
   concrete violated axioms.
4. **Repair — arbitrary-intersection mutant:** diagnose a proposed arbitrary-intersection
   definition using the usual topology on `ℝ`, where it fails.
5. **Referee — basis confusion:** check a candidate basis that is not closed under intersection
   and explain why this does not violate the topology axioms.

At least two named bad candidates in the test battery produce a concrete violated condition,
not merely a compilation error.

## T5 — Standard examples of topologies

**Objective:** construct reusable discrete, indiscrete, Sierpiński, particular-point and
cofinite topologies.

1. **Construct — discrete and indiscrete:** accepted on arbitrary carriers; their open-set
   characterisations are checked.
2. **Construct — Sierpiński:** define it on `Bool`; success enumerates exactly `∅`, `{true}`,
   and `univ` as opens and rejects the other finite candidate.
3. **Construct — particular point:** define opens as `∅` or sets containing the chosen point;
   success proves all axioms and checks membership on a finite carrier.
4. **Construct — cofinite:** define opens as `∅` or sets with finite complement; success proves
   the general topology axioms and distinguishes finite/infinite carrier behaviour.
5. **Classify — compare examples:** tests distinguish Sierpiński from discrete and indiscrete;
   these definitions live in the shared `Topology.Examples` module.

## T6 — Closed sets and closure

**Objective:** relate complementary open/closed descriptions, interior, closure and density.

1. **Construct — closed and interior:** define both from opens; success checks complement and
   union characterisations.
2. **Construct — closure:** define the intersection of closed supersets; success proves it is
   closed and agrees with Mathlib after the bridge is introduced.
3. **Classify — dense and clopen:** check definitions on discrete, indiscrete and Sierpiński
   examples, including positive and negative cases.
4. **Connect — closure laws:** prove monotonicity and idempotence from the definition.

## T7 — Bases and generated topologies

**Objective:** separate the two basis axioms from the topology they generate.

1. **Construct — basis:** define covering and intersection-refinement conditions; accepted
   and rejected finite families isolate each axiom.
2. **Construct — generated opens:** define unions of basis elements; success proves a basis
   generates a topology containing exactly the intended opens.
3. **Connect — rational intervals:** state the usual `ℝ` basis using Mathlib opens and check
   its density/refinement argument with a general theorem, not finite enumeration.
4. **Refute — not a basis:** produce an open family failing intersection refinement.
5. **Referee — basis versus topology:** accept a basis not closed under unions/intersections.

## T8 — Continuous maps

**Objective:** define continuity through inverse images and distinguish it from openness.

1. **Construct — continuity:** define `MyContinuous f` using preimages of opens; success
   proves equivalence with Mathlib `Continuous` for the bridged instances.
2. **Connect — identity and constants:** prove both are continuous for arbitrary topologies
   (constant maps use the appropriate codomain hypotheses).
3. **Refute — continuous bijection:** give the identity from discrete to indiscrete `Bool`;
   success proves continuity and bijectivity and refutes continuity of its inverse.
4. **Refute — continuous need not be open:** provide an explicit map and open set whose image
   is not open; success checks the witness.
5. **Classify — preservation:** tests distinguish inverse-image preservation from direct-image
   preservation.

## T9 — Homeomorphisms

**Objective:** understand a bijection with continuous inverse as topological equivalence.

1. **Construct — homeomorphism:** complete a structure containing a bijection and continuity
   in both directions; models and one-sided mutants test all fields.
2. **Connect — open/closed preservation:** prove both directions using the inverse.
3. **Connect — equivalence relation:** construct identity, inverse and composition
   homeomorphisms and check their fields.
4. **Classify — finite spaces:** compare explicit finite topologies using bijections.
5. **Refute — bijective but not homeomorphic:** reuse T8's discrete/indiscrete identity and
   prove it is not a homeomorphism.

## T10 — Subspace topology

**Objective:** construct the induced topology and understand inclusion and relative openness.

1. **Construct — subspace:** define opens as preimages under the subtype inclusion; success
   proves equivalence with Mathlib's induced topology.
2. **Connect — inclusion:** prove continuity of the inclusion map.
3. **Classify — relative opens:** prove the `∃ U open, s ∩ U` characterisation on concrete
   and general examples.
4. **Classify — intrinsic comparison:** compare inherited and intrinsic discrete/indiscrete
   topologies on finite subsets.
5. **Refute — open not closed:** exhibit a subset in a standard finite space with the requested
   status and verify it explicitly.

## T11 — Product topology

**Objective:** understand rectangles, projections and finite restriction in arbitrary products.

1. **Construct — finite/basic rectangles:** define sets restricting two coordinates and check
   them against opens in the product.
2. **Connect — projections:** prove both coordinate projections continuous using Mathlib.
3. **Classify — discrete/indiscrete products:** compare explicit open sets in finite products.
4. **Referee — arbitrary products:** define cylinder sets with finite coordinate restriction
   and distinguish them from arbitrary box rectangles.
5. **Connect — box versus product:** give an infinite-product open box set that is not open in
   the product topology, with a general proof where supported by Mathlib.

## T12 — Compactness

**Objective:** use open covers and finite subcovers, separating finite computation from proof.

1. **Construct — compactness:** define finite-subcover compactness and bridge it to
   `IsCompact`/`CompactSpace`.
2. **Connect — finite spaces:** prove arbitrary finite spaces compact.
3. **Refute — infinite discrete:** give the singleton open cover on `ℕ` and prove it has no
   finite subcover.
4. **Connect — infinite cofinite:** prove compactness by selecting one nonempty open cover
   element and covering the finitely many remaining points.
5. **Connect — continuous images:** prove compactness is preserved by continuous maps.

Positive, negative and distinguishing examples are checked separately.

## T13 — Connectedness

**Objective:** relate separations and nontrivial clopen sets.

1. **Construct — connectedness:** define absence of a separation by nonempty disjoint opens;
   bridge to Mathlib's connected-space predicate.
2. **Classify — clopen characterisation:** prove disconnectedness is equivalent to a nontrivial
   clopen set for a nonempty space.
3. **Classify — standard examples:** prove indiscrete and Sierpiński spaces connected and a
   finite discrete space with at least two points disconnected.
4. **Connect — continuous images:** prove the continuous-image theorem.

## T14 — Separation axioms

**Objective:** distinguish T0, T1 and Hausdorff using strict finite/infinite examples.

1. **Construct — T0:** define distinguishability by an open neighbourhood; bridge to Mathlib.
2. **Construct — T1 and Hausdorff:** define singleton-closed and disjoint-neighbourhood forms;
   success proves the standard equivalences.
3. **Connect — implications:** prove Hausdorff ⇒ T1 ⇒ T0.
4. **Classify — Sierpiński:** prove T0 and refute T1.
5. **Classify — infinite cofinite:** prove T1 and refute Hausdorff on `ℕ` (or another explicit
   infinite carrier), using general theorems rather than enumeration.
6. **Classify — comparison table:** discrete, indiscrete, Sierpiński and cofinite examples are
   the same reusable objects, not unrelated local definitions.

## T15 — Neighbourhoods, filters and convergence

**Objective:** move from neighbourhoods to `𝓝`, `Filter.Tendsto`, and limits.

1. **Construct — neighbourhood:** define `s ∈ 𝓝 x` through an open subset containing `x`;
   success proves the Mathlib characterisation.
2. **Connect — neighbourhood filter:** identify `𝓝 x` and distinguish the allowed improper
   bottom filter in Mathlib from any pedagogical proper-filter convention.
3. **Construct — convergence:** define neighbourhood convergence of `u : ℕ → α` to `x`;
   success proves equivalence to `Filter.Tendsto u Filter.atTop (𝓝 x)`.
4. **Connect — discrete limits:** prove convergence implies eventual equality to the limit.
5. **Refute — non-unique limits:** exhibit a Sierpiński sequence with two distinct limits and
   verify both convergence claims.
6. **Connect — Hausdorff uniqueness:** use Mathlib's uniqueness theorem and explain its
   hypothesis; no general converse is asserted.

## Shared examples and validation matrix

The shared modules provide finite discrete, indiscrete, Sierpiński (`Bool`), particular-point
and cofinite topologies, plus continuity/conversion lemmas. The reals use Mathlib's usual
topology. The referee tests each topology axiom independently: missing empty set/universal,
union failure, intersection failure, plus accepted standard examples. Properties receive a
positive, negative and nearby-property check: Sierpiński (T0 not T1, connected not indiscrete),
infinite cofinite (T1 not Hausdorff, compact not Hausdorff), and discrete-to-indiscrete identity
(continuous bijection not homeomorphism).

The first end-to-end vertical slice is fixed as T2 family construction, T4 topology structure,
T5 Sierpiński, T8 continuity and T9 continuous bijection. It must share the standard format,
include finite-model and genuine Lean checks, and include an explicit counterexample before
the remaining content is considered complete.
