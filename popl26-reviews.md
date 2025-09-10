POPL 2026 Paper #920 Reviews and Comments
===========================================================================
Paper #920 A Complete Refinement System for Substructural SSA


Review #920A
===========================================================================

Overall merit
-------------
B. OK paper, but I will not champion it

Reviewer expertise
------------------
X. Expert

Paper summary
-------------
The paper presents two languages for controlled use of effects, copying and discarding of values: $\lambda_{SSA}$ and $\lambda_{iter}$, which are shown to be equivalent. If I understood correctly, the former is inspired by concrete intermediate languages used in compilers, while the latter is close to idealizations of functional languages, like Moggi's computational metalanguage and fine-grain call-by-value, capturing core features of functional programming with effects, and well-developed in terms of good theoretical properties, denotational semantics and equational theory. 

Most of the paper is focused on $\lambda_{iter}$, its equational and inequational theories (understood as simulation, to model irreversible program transformations), and on the categorical denotational semantics. The authors prove soundness and completeness theorems using a term model construction. They also give examples of some concrete models, with nondeterminism, state and concurrency effects.

Comments for authors
--------------------
The core of the paper is the $\lambda_{iter}$ language, which is a reminiscent of fine-grain call-by-value, but  adds the following features: (Elgot) iteration, effect system, resource annotation for variable contexts, indicating how many times the variables may be used (at most once, exactly once, unconstrained, etc). I have not previously seen all these features combined together in one language -- that seems novel. On the other hand, the recipes for dealing with such languages, in particular for defining the denotational semantics are rather standard: Freyd categories, poset-enrichment, copy and discard morphisms. These aspects combine well with each other. On the other hand, combining all these aspects altogether makes is technically difficult to prove things like completeness (Theorem 4.17). The proof (by term model construction) is only sketched in the appendix, but it seems plausible. The authors claim that "many" results are formalized in Lean, which is a plus. But I would like to know which ones.

The presentation looks suboptimal to me. While, I essentially followed (on high level) the technical development related to $\lambda_{iter}$, it was hard to follow the general narrative of the work. I failed to locate explicit clear statements about mutual alignment between $\lambda_{iter}$ and $\lambda_{SSA}$, and what the authors exactly want to do with them, and how I should think about them. For me, the main contribution is $\lambda_{iter}$, as a further refinement of fine-grain call-by-value, and its theory, while $\lambda_{SSA}$ is sort of an application, to show that $\lambda_{iter}$ can model something that is close to something used in practice. 

By the way, Geron and Levy's "Iteration and Labelled Iteration", I believe, is a relevant related work, as it also considers alternative syntax for iteration though labels, line $\lambda_{SSA}$.

I am not quite convinced with the semantic treatment of quantity annotations. Normally, one involves genuinely semantic structures like linear logic "!" and the corresponding adjunction to interpret it (I mean, like in Benton's "A Mixed Linear and Non-Linear Logic: Proofs, Terms and Models"). I did not get how "equipping" types with copying/discard morphisms works (see my comment below).

Overall, the paper make quite a bit of sense to me, but it is certainly not in ideal shape.

# Detailed Comments 
 
- l.25: "then" -- "then"
- l.35: "all" -- "all"
- l.134,142: Fig 2 is mentioned before Fig.1 -- maybe swap them then?
- l.174: what is "A" and what is curly "l"?
- l.213: "but we later prove in Subsection 5.3 that the two syntaxes are completely equivalent" -- I do not see why wait until 5.3. It is just two languages -- one can explain the equivalence much earlier. This would help to motivate/understand the rest. I should, at least.
- l.220: so, who is "a functional analogue of While"? 
- l.249: a chart depicting the (semi-)lattice structure will help.
- l.267: the judgments involve 3 faces of "q": italic, bold and serif. This turns them into riddles. 
- l.273: "discarable"
- l.333: previously you already used Q for {1, 1?, 𝜔 +, 𝜔 }.
- l.360: the language is first-order, so I find if very confusing to use $\lambda$ in the name, as this very suggestively refers to the $\lambda$-calculus.
- l.364: "split the context" -- $\Gamma$ should be mentioned
- l.423: "means 𝑎 is refined by 𝑏" -- please, introduce 𝑎 and 𝑏 properly? What happened to the effect index at the turnstyle?
- l.633: Is it a new theorem? Say it please. If not, please, cite, where it comes from. Overall, please, appropriately credit results and notions from elsewhere, and be explicit about your own.
- l.723: "we will later see that dinaturality is derivable" -- that is in appendix, so we won't see it.
- l.811: "relevant, a diagonal morphism" -- this is the shakiest place in this semantic model to me. What means "relevant" for a type? The quantity annotations only occur in context, not for all types. And then, [[X]] can be the same for different annotation, so what means "equipping"?
- l.875: I did not get this lemma. What means [[-]] for derivations?
- l.945: The proof of the theorem, if fully written, can be quite intricate. For example, in appendix, you say "this is well-defined since, by definition, we quotient precisely the equivalence clases". It is not automatically well-defined, because one has to show that the definition does not depend on the choice of f and g from the equivalence class.
- l.1169: "guve".

Specific questions to be addressed in the author response
---------------------------------------------------------
- Can you elaborate on the equipment business around l.723?
- What is exactly implemented in Lean? 
- Can you compare your quantity annotations to coeffects (from Tomas Petricek, Dominic Orchard, Alan Mycroft, Coeffects: a calculus of context-dependent computation)?



Review #920B
===========================================================================

Overall merit
-------------
C. Weak paper, though I will not fight strongly against it

Reviewer expertise
------------------
Y. Knowledgeable

Paper summary
-------------
This paper presents a type-theoretic account of a single
static assignment (SSA) form that is capable of handling
a range of features found in modern source languages and
target hardware.  A sound and complete categorical semantics
is provided, along with a number of concrete models.

Comments for authors
--------------------
General comments:

The topic of the paper is interesting, and relevant to POPL.
However, the paper itself is hard going, even for a reader
with some experience in this area.  In particular, it is
rather dense in terms of the volume of technical material
that is presented, and I found myself becoming swamped.

The introduction also promises that a "variety of interesting
optimizations are validated by our model", but the paper itself
seems to contain little on this.  I was expecting a section
near the end that focused on practical examples, but after
section 6 on models it jumps straight into related work.

Overall, this work seems technically interesting, but the
manner in which the paper is written means that it is unlikely
to be accessible to many in the POPL community, and further
work is needed to demonstrate its practical applicability.

Specific comments:

26, Explain what "substitution is then a valid program
transformation" means, and why this is important.

30, "Unfortunately" -> "However" ?

88, In the list of contributions, it would be useful to include
links to the relevant sections of the paper.

107, Explain who the paper is targeted at, e.g. what kind of
knowledge and experience is required.

134, Some further explanation for the particular choice of
language in Figure 2 is required.  For example, why are regions
used rather than basic blocks and control flow graphs?

241-243, "corresponding to" can be removed from each line.

527, Why use a categorical semantics rather than some other
approach?  This seems a key part of the work, so the rationale
for this choice needs to be clearly explained and justified.

1182, The paper contains 23 figures, which is a lot.  It also
means the reader needs to constantly flick back and forward
between the narrative and the figures when reading the paper.
The flow would be improved by inlining many of the figures.

1188, The related work section is rather brief, and would
benefit from being expanded.  A discussion of possible
directions for further work is also required.



Review #920C
===========================================================================

Overall merit
-------------
B. OK paper, but I will not champion it

Reviewer expertise
------------------
Y. Knowledgeable

Paper summary
-------------
This paper develops a type-theoretic and categorical foundation for
reasoning about static single assignment in the presence of effects
such as undefined behavior, nondeterminism, nontermination, memory
effects, and release-acquire weak concurrency models.  It introduces
two language models: $\lambda$SSA, an SSA language with explicit
dominator-tree lexical scoping, and $\lambda$iter, an
expression-oriented calculus better suited for the refinement theory
developed in the paper.  The two are proven to be equivalent by appeal
to the categorical semantics, showing that there are
meaning-preserving translations both ways that agree in all models.

Comments for authors
--------------------
This paper appears to be an advance in foundational accounts of
compiler IRs, offering a number of notable advantages such as
refinement (not just equivalence) and an account of substructural
effects that seems critical for reasoning about compiler optimizations
as refinements.

The paper is dense and likely inaccessible for compiler researchers
without a categorical background.  Although the completeness result
essentially frees them from engaging at this level since they can
reason at the level of the type theory (all valid refinements are
derivable).  That said, the paper has fairly limited examples
validated by the theory.

It's essentially left to the reader to imagine the practical
applications of the work or how it would be integrated into existing
systems for mechanically reasoning about compiler transformations.

Minor:

"Becaise" "guarantree"

Specific questions to be addressed in the author response
---------------------------------------------------------
Can you provide more examples of validate optimizations?

Can you elaborate on what has been mechanized?  I was surprised the
mechanization was not included in the supplemental material and the
paper gives few details.  Doe the mechanization cover concrete models
or only the general metatheory?

What are the practical implications of this work for compiler writers?