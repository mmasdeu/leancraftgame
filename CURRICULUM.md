# Curriculum: sequences → limits → topology

This is the current narrative specification. The original many-world ordering has been
replaced by a coherent three-act course. Stable directory IDs are shown alongside actual
play positions; the final auditing coda deliberately comes after topology.


## Sequences

### 1. Record a first reading (L1)

*I · First observations*

Define values and a successor: a sequence begins as data with a next step.

### 2. Transform a sequence pointwise (L2)

*I · First observations*

Use functions as transformations u n ↦ f(u n), the simplest way to make a new sequence.

### 3. Sample according to cases (L3)

*I · First observations*

Define a piecewise observation rule and inspect its boundary behaviour.

### 4. Recursive sequences (L4)

*I · First observations*

Give base cases and recursive steps for factorials, powers and Fibonacci-style sequences.

### 5. Counting finite prefixes (L5)

*I · First observations*

Use recursive counts and finite arithmetic to describe the beginning of a sequence.

### 6. Audit a sampling report (L6)

*I · First observations*

Find boundary-case mistakes in packaged functions whose definitions compile but misreport observations.

### 7. Claims about readings (L7)

*I · First observations*

Write predicates—true/false statements about individual values in a sequence.

### 8. Join observations (L8)

*I · First observations*

Express simultaneous properties with conjunctions and intervals of admissible readings.

### 9. Alternatives and exclusions (L9)

*I · First observations*

Use disjunction and negation to separate types of observations and rules.

### 10. Interacting constraints (L10)

*I · First observations*

Translate compound conditions into precise definitions instead of relying on a plausible reading.

### 11. Audit connective readings (L11)

*I · First observations*

Use concrete values to refute definitions that swap a connective or draw an invalid conclusion.

### 12. Indices and integer arithmetic (L12)

*I · First observations*

Work with casts and integer distances when positions and readings no longer have the same type.

### 13. Normalising readings (L13)

*I · First observations*

Define ratios and reciprocal relations while explicitly controlling division by zero.

### 14. Truncated measurements (L14)

*I · First observations*

Use integer sign, absolute difference, ratio and percent without confusing rounded data with exact data.

### 15. Audit numerical claims (L15)

*I · First observations*

Reject a convincing value or definition using a counterexample at a boundary case.

### 16. Every position (L16)

*I · Mathematical language*

Use ∀ to express a property of an entire sequence rather than a finite sample.

### 17. From premise to observation (L17)

*I · Mathematical language*

Use implication to state when a property at one index constrains another observation.

### 18. Existence of a witness (L18)

*I · Mathematical language*

Use ∃ for a zero, a large reading or another special observation, and distinguish naming a witness from proving universality.

### 19. Uniform thresholds and dependent choices (L19)

*I · Mathematical language*

Compare ∀ x, ∃ y with ∃ y, ∀ x: for sequences this is the difference between a uniform threshold and one depending on the observation.

### 20. Eventually and bounded quantifiers (L20)

*I · Mathematical language*

Restrict claims to indices beyond a threshold N, separating finite bad behaviour from long-run behaviour.

### 21. Patterns in the long run (L21)

*I · Mathematical language*

Define periodicity, eventual constancy, maxima and eventual recurrence without confusing repeated and permanent behaviour.

### 22. Audit long-run claims (L22)

*I · Mathematical language*

Choose the counterexample that exposes swapped or misplaced quantifiers in sequence claims.

### 23. Divergence to infinity (L23)

*I · Sequence behaviour*

Define TendsToInfinity with thresholds N and lower bounds M, distinguishing unboundedness from monotone divergence.

### 24. Bounded and monotone sequences (L24)

*I · Sequence behaviour*

Separate boundedness from monotonicity and increasing from nondecreasing behaviour.

### 25. Injective and surjective sampling (L25)

*I · Sequence behaviour*

Distinguish distinct-index distinct-output sampling from covering the output type and from bijectivity.

### 26. Recurrent behaviour (L26)

*I · Sequence behaviour*

Express eventually positive, eventually equal, infinitely often and recurrent behaviour with precise quantifiers.

### 27. Be the referee for sequences (L27)

*I · Sequence behaviour*

Design examples that reject unbounded but non-divergent sequences, not just examples matching your intuition.

### 28. Sets of indices (L28)

*I · Sequence behaviour*

Describe even indices, multiples and bounded index sets, so conditions can be treated as set membership.

### 29. Library facts about observations (L29)

*I · Sequence behaviour*

Use established definitions while distinguishing a satisfactory statement from the library statement you intended.

### 30. Generic bounds and comparisons (L30)

*I · Sequence behaviour*

Generalise bounds, intervals and maxima from a numerical example to the right ordered type.

### 31. Divisibility of indices (L31)

*I · Sequence behaviour*

Define common divisors, coprimality, gcd and primality as predicates on sequence indices.

### 32. Relations on indices (L32)

*I · Sequence behaviour*

Build reflexivity, symmetry, transitivity, equivalence and partial order without conflating their roles.

### 33. Audit relations and number claims (L33)

*I · Sequence behaviour*

Refute plausible library-style predicates with a concrete counterexample.


## Limits

### 34. Finite sums of observations (L34)

*II · Accumulation*

Sum values over an exactly specified finite set of indices, learning how range endpoints affect every sample.

### 35. Filtering finite samples (L35)

*II · Accumulation*

Use Finset.filter to sum, count or multiply only the observations satisfying a predicate—this is not the convergence filter Filter.

### 36. Closed forms for accumulations (L36)

*II · Accumulation*

Compare sums of powers and other finite sums with formulas rather than guessing a closed form from a few values.

### 37. Telescoping and partial sums (L37)

*II · Accumulation*

Recognise when successive differences telescope and how endpoints determine the whole sum.

### 38. Audit finite accumulations (L38)

*II · Accumulation*

Reject incorrect summation and counting claims by checking the actual index set and boundary values.

### 39. Convergent sequences (L39)

*II · Convergence*

Define ConvergesTo u a with ∀ ε > 0, ∃ N, every later term lying within ε of a—quantifying over all positive errors, not just a convenient one.

### 40. Continuity as error control (L40)

*II · Convergence*

Define ContAt f a using δ for every ε, relating a targeted error in output to an allowed error in input.

### 41. Cauchy sequences (L41)

*II · Convergence*

Separate Cauchy closeness of terms from convergence to a named limit, using eventual indices and positive errors.

### 42. Cluster values and subsequences (L42)

*II · Convergence*

Define a cluster value through a convergent subsequence, distinguishing recurrence at arbitrary distance from eventual convergence.

### 43. Audit limit claims (L43)

*II · Convergence*

Use explicit sequences to disprove an incorrect proposed limit or convergence claim.


## Topology

### 44. Package a point as data (L44)

*III · Language for spaces*

Use structures to package coordinates and other observational data, learning the syntax later used to package axioms.

### 45. Functions on packaged data (L45)

*III · Language for spaces*

Define operations on structures by reading, transforming and returning their fields.

### 46. Extend and update structures (L46)

*III · Language for spaces*

Use extension, update and parameterisation to enrich the description of mathematical objects.

### 47. Compound structural calibrations (L47)

*III · Language for spaces*

Practise building richer structures whose fields fit together correctly, so that packaging a future topological object is routine rather than mysterious.

### 48. Audit compound structures (L48)

*III · Language for spaces*

Identify where a structure declaration stops recording the intended information even though it compiles.

### 49. Predicates and small structures (L49)

*III · Language for spaces*

Bundle values with evidence such as positivity or interval bounds—the first step from syntax to mathematical structure.

### 50. Structures of order (L50)

*III · Language for spaces*

Package reflexivity, antisymmetry and transitivity as independent requirements instead of assuming an order from its name.

### 51. Metric spaces (L51)

*III · Language for spaces*

Package a distance with nonnegativity, identity, symmetry and triangle inequality—the named structure behind familiar open-ball examples.

### 52. Audit axioms and models (L52)

*III · Language for spaces*

Use accepted and rejected models to reveal missing or excessive axioms in a colleague's group-like structure, exactly the method used for MyTopology in T4.

### 53. Classes and instances (L53)

*III · Language for spaces*

Give notation a meaning on new types through classes and instances, the mechanism behind TopologicalSpace and filters.

### 54. Standard instances (L54)

*III · Language for spaces*

Interpret arithmetic operations on custom structures through coherent instances, checking the resulting expressions against intended semantics.

### 55. Dependent instances (L55)

*III · Language for spaces*

Use parameters and existing instances to define reusable behaviour generically—the basis for subspaces, products and induced structure.

### 56. Comparing instance-based definitions (L56)

*III · Language for spaces*

A deeper construction exercise in generic operations and instance composition, preparing you for packaged topology and predicates.

### 57. Audit class instances (L57)

*III · Language for spaces*

Reject a compiling but unsuitable instance with an expression whose value contradicts its description.

### 58. Sets and operations (T1)

*III · Foundations*

- **Construct: Define disjointness** — Express that two sets have no common element.
- **Construct: Define a cover** — Supply a family member containing each point of the covered set.
- **Connect: Connect inverse images to set operations** — Require both union and intersection preservation for every pair of sets.
- **Refute: Refute direct-image intersection preservation** — Use a constant map and disjoint nonempty sets.

### 59. Families of sets (T2)

*III · Foundations*

- **Construct: Define a family of subsets** — Represent an indexed family as a function into Set α.
- **Construct: Express closure under unions** — Quantify over every subfamily, not only binary unions.
- **Construct: Express binary intersection closure** — Require every pairwise intersection to remain in the family.
- **Refute: Separate finite and arbitrary closure** — Exhibit a finite-intersection-closed family with a missing arbitrary union.

### 60. Relations and partitions (T3)

*III · Foundations*

- **Construct: Define the three equivalence axioms** — Separate reflexivity, symmetry and transitivity.
- **Construct: Package an equivalence relation** — Use the three predicates as independent structure fields.
- **Construct: Define equivalence classes** — Collect exactly the elements related to the chosen point.
- **Connect: Connect classes and fibres** — Use equality of function values as the kernel relation.

### 61. The definition of a topology (T4)

*III · Foundations*

- **Construct: Complete the topology structure** — State universal, arbitrary-union, and binary-intersection axioms.
- **Connect: Derive the empty set** — Use the empty subfamily instead of assuming a redundant axiom.
- **Referee: Diagnose bad candidates** — Identify concrete topologies and axiom violations.

### 62. Standard examples of topologies (T5)

*III · Examples and maps*

- **Construct: Construct discrete and indiscrete spaces** — Compare the largest and smallest topologies.
- **Construct: Construct Sierpinski space** — Use the particular-point construction at true on Bool.
- **Construct: Construct a particular-point topology** — Keep exactly empty sets and sets containing zero open.
- **Construct: Construct the cofinite topology** — Use finite complements and reserve infinite claims for general proofs.

### 63. Closed sets and closure (T6)

*III · Examples and maps*

- **Construct: Define closed sets** — Use openness of the complement.
- **Construct: Define interior and closure** — Use open subsets and closed supersets respectively.
- **Construct: Define density and clopen sets** — Connect universal closure and simultaneous openness/closedness.

### 64. Bases and generated topologies (T7)

*III · Examples and maps*

- **Construct: Define the two basis axioms** — Separate covering from intersection refinement.
- **Construct: Construct generated opens** — Allow unions of arbitrary subfamilies of the basis.
- **Referee: Distinguish a basis from a topology** — Use two singleton sets that do not contain their own union.
- **Connect: Connect rational intervals to Mathlib** — Identify the standard rational-endpoint interval basis on the reals.

### 65. Continuous maps (T8)

*III · Examples and maps*

- **Construct: Define continuity** — Use inverse images of every open set.
- **Connect: Check identity and finite examples** — Distinguish inverse-image preservation from direct-image openness.
- **Refute: Distinguish continuous and open maps** — Use constant false from discrete Bool to Sierpiński space.

### 66. Homeomorphisms (T9)

*III · New spaces*

- **Construct: Define homeomorphisms** — Package bijection data and continuity in both directions.
- **Construct: Construct the counterexample data** — Choose discrete and indiscrete topologies and the identity map.
- **Classify: Check continuity and bijectivity** — Verify the forward direction without assuming inverse continuity.
- **Refute: Refute homeomorphism** — Use singleton true to refute inverse continuity.

### 67. Subspace topology (T10)

*III · New spaces*

- **Construct: Construct the induced topology** — Use the inclusion from a subtype into the ambient space.
- **Construct: Characterise subspace opens** — Express every relative open as an ambient open preimage.
- **Classify: Exhibit open but not closed** — Use singleton true and its non-open Boolean complement in Sierpiński space.

### 68. Product topology (T11)

*III · New spaces*

- **Construct: Construct the finite product topology** — Use the infimum of the two coordinate-induced topologies.
- **Construct: Define basic open rectangles** — Test openness in both coordinate descriptions.
- **Construct: Define coordinate cylinders** — Restrict exactly one coordinate; finite intersections then restrict finitely many.
- **Referee: Distinguish product and box thinking** — Recognise a box condition on infinitely many coordinates.

### 69. Compactness (T12)

*III · Global properties*

- **Construct: Define compactness with open covers** — Return a finite subcover of every indexed open cover.
- **Classify: Classify finite, discrete, and cofinite spaces** — Distinguish finite compactness, infinite-discrete noncompactness, and infinite-cofinite compactness.
- **Connect: Connect continuity and compact images** — Pull an open cover of the image back to the compact domain.

### 70. Connectedness (T13)

*III · Global properties*

- **Construct: Define connectedness by separations** — Rule out a disjoint covering pair of nonempty open sets.
- **Classify: Classify standard finite spaces** — Show Sierpiński space connected and discrete Bool disconnected.
- **Connect: Connect clopen sets and continuous images** — Relate separation to clopen sets and use inverse images for continuous maps.

### 71. Separation axioms (T14)

*III · Global properties*

- **Construct: Define T0 and T1** — Distinguish one-directional and preferred-direction open separation.
- **Construct: Define Hausdorff spaces** — Require disjoint open neighbourhoods.
- **Connect: Prove the implications and strictness** — Use Hausdorff to T1 to T0, Sierpiński, and infinite cofinite counterexamples.

### 72. Neighbourhoods, filters and convergence (T15)

*III · Convergence*

- **Construct: Define neighbourhoods and their filter** — Contain an open set containing the point and bridge to `nhds`.
- **Connect: Express convergence with neighbourhoods and Tendsto** — Use eventual membership and identify the Mathlib formulation.
- **Refute: Exhibit non-unique Sierpiński limits** — Verify that constant true converges to both Boolean points.
- **Connect: Connect discrete limits and Hausdorff uniqueness** — Use singleton neighbourhoods for eventual equality and Hausdorffness for uniqueness.

### 73. Audit a proof of infinity (L58)

*III · Auditing the journey*

Examine how a vacuous or mis-stated prime predicate can make an 'infinitude proof' compile, and use toy predicates to expose the flaw.

### 74. Audit an orbit conjecture (L59)

*III · Auditing the journey*

Define a Collatz step and orbit with explicit finite behaviour, separating unbounded iteration from successfully reaching a target.

### 75. Audit a famous conjecture (L60)

*III · Auditing the journey*

Use several prime predicates to reveal precedence and hidden-assumption errors in the AI's Goldbach statement, while leaving actual Goldbach open.
