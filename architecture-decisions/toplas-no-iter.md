# No iteration in expression language for λSSA

## Reasons

- It will take a long time to re-do the formalization, and it is unclear what is the best form for
  the associated CFG rules
  - It might be interesting to look at the connection with Böhm-Jacopini here, but we can do that
    later.

## Justifications

- `iter` is an impure sequencing construct, whereas branching and sequencing are pure, so it makes
  sense that `iter` is not included
  - Categorically, that makes our expression language free w.r.t. Freyd categories, rather than
    Elgot-Freyd categories.
 