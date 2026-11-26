def squares : Set ℕ := Set.range (fun n => n * n)
def evensPre : Set ℕ := {n | 2 * n ∈ {m : ℕ | m % 4 = 0}}
statement preimage_inter' : ∀ {α β : Type*} (f : α → β) (u v : Set β),
    f ⁻¹' u ∩ f ⁻¹' v = f ⁻¹' (u ∩ v)
def f₀ : ℕ → ℕ := fun _ => 1
def s₀ : Set ℕ := {1}
def t₀ : Set ℕ := {3}
def y₀ : ℕ := 1
