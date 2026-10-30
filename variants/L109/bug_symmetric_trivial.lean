def Reflexive' (r : ℕ → ℕ → Prop) : Prop := ∀ a, r a a

def Symmetric' (r : ℕ → ℕ → Prop) : Prop := ∀ a b, r a b → r a b

def Transitive' (r : ℕ → ℕ → Prop) : Prop := ∀ a b c, r a b → r b c → r a c

def Antisymmetric' (r : ℕ → ℕ → Prop) : Prop := ∀ a b, r a b → r b a → a = b

def IsEquivalence' (r : ℕ → ℕ → Prop) : Prop := Reflexive' r ∧ Symmetric' r ∧ Transitive' r

def IsPartialOrder' (r : ℕ → ℕ → Prop) : Prop := Reflexive' r ∧ Antisymmetric' r ∧ Transitive' r
