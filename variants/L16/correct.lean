def squares : Set ℕ := Set.range (fun n => n ^ 2)
def evensPre : Set ℕ := (fun n => 2 * n) ⁻¹' {m | m % 4 = 0}
statement preimage_inter' {α β : Type*} (f : α → β) (u v : Set β) :
    f ⁻¹' (u ∩ v) = f ⁻¹' u ∩ f ⁻¹' v
def f₀ : ℕ → ℕ := fun n => n % 2
def s₀ : Set ℕ := {0}
def t₀ : Set ℕ := {2}
def y₀ : ℕ := 0
