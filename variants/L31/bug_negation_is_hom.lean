def IsMonoidHom {M N : Type} [Monoid M] [Monoid N] (f : M → N) : Prop :=
  f 1 = 1 ∧ ∀ a b, f (a * b) = f a * f b
def IsAddMonoidHom {M N : Type} [AddMonoid M] [AddMonoid N] (f : M → N) : Prop :=
  f 0 = 0 ∧ ∀ a b, f (a + b) = f a + f b
def homNotOnto : ℤ → ℤ := fun n => 2 * n
def bijNotHom : ℤ → ℤ := fun n => -n
