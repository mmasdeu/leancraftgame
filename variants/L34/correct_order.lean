def IsMonoidHom {M N : Type} [Monoid M] [Monoid N] (f : M → N) : Prop :=
  (∀ x y : M, f (x * y) = f x * f y) ∧ f 1 = 1
def IsAddMonoidHom {M N : Type} [AddMonoid M] [AddMonoid N] (f : M → N) : Prop :=
  (∀ x y : M, f (x + y) = f x + f y) ∧ f 0 = 0
def homNotOnto : ℤ → ℤ := fun n => 3 * n
def bijNotHom : ℤ → ℤ := fun n => 4 - n
