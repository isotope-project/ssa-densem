* Please also provide a way for reviewers to access your mechanized proofs when you submit the revised version.



- - - - - - - - - -

From the reviewers:

Referee: 1

Comments to the Author

* The paper also suffers from some major presentational issues. The
  introduction of the paper is extremely short (1 page!) and does not
  mention many aspects of the paper that then later come as complete
  surprises (effect system? Bohm-Jacopini theorem?).

* The paper is pitched as modeling SSA, but the fact that the
  type-theoretic SSA is so much more flexible than SSA makes me wonder
  what property makes this type theory "SSA" rather than "Monadic
  form". The fact that it is equivalent to an SSA form is of course to
  be expected of all of these intermediate representations.

  There is a compositional, local, linear-space transformation to and from 
  SSA. We clarify this point in Section 4.4. 

* My biggest issues with the paper are in Section 3 and
  Section 4. Though Section 2 gives a good introduction to the
  relationship between SSA and functional representations, Section 3
  jumps immediately into the "type-theoretic" SSA rather than describing
  first the SSA language the authors have told us that they are trying
  to model. An actual formalization of a calculus intended to model SSA
  form directly is not given formally until page 29(!)

  We have rewritten section 2 and heavily revised sections 3 and 4 to take
  these comments into account. 

  We begin by defining SSA, and specify the relationship between it and 
  its functional variants, with an explicit proof of this fact in section 4.4 

* Additionally there is an entire effect system included in
  the type-theoretic SSA that is (1) never motivated or explained and
  (2) never used in the equational theory or semantic models other than
  distinguishing between pure and impure morphisms.

  We have simplified the type theory and categorical semantics to
  retain only the pure/impure distinction. This makes the type theory 
  simpler, and makes the relationship to existing accounts of Freyd 
  categories much clearer. 

* Extend the introduction to more clearly lay out what the technical
  contributions of this work are, as much of it builds on well-known
  ideas such as SSA-functional correspondence and semantics in Freyd
  categories.

  We have rewritten sections 1 and 2 to do this. However, we have kept
  most of the category theory out of the introduction, confining it to
  sections 5 and 6. 

* Section 3/4 to better explain the relationship to SSA form, and
  frontload the actual definition of SSA form and what theorems your
  type-theoretic SSA should satisfy in relation to it.

  We have done this. Section 2 gives the relationship more clearly, 
  and section 4.4 gives detailed proofs of these claims. Section 3 
  is still only about the lambda-SSA type theory. 

* Explain in much more detail the relation to prior work, especially
  in Section 5 on the categorical semantics.

  We have added more references to related work, and added additional
  references to current iTree-based denotational models of Vellvm. 

* Streamline the presentation overall, moving some overly technical
  definitions (e.g., Section 4.5) into the appendix.

* Add a section to the discussion to more clearly describe which
  theorems are formalized in Lean and which are not.

  We have done this. Part of section 7 describes at a high level 
  what has been verified, and there is a link to the mechanized proofs
  of our claims wherever they exist. 

* Explain the relevance of the completeness theorem to the stated
  goals of the work, which are to aid in modeling SSA form and its
  optimization.

  We have added some discussion of this point to the paper.   


Direct comments by Section:

* Section 1

* Line 55-57: ...memory models could be validated by seeing if they
  satisfy the equations of SSA...: How do we know if this is a useful
  criterion? Does it rule out any known bad models?

  TODO: add some models that don't work. 


* Line 63-65: "We show that any denotational model with this categorical
  structure is also a model of SSA" not sure what the distinction
  between "denotational model" and "model of SSA" is here, it seems
  redundant

  We have rephrased this

* Line 66-70: there don't seem to be any applications of a completeness
  result given, only of the soundness. Is there any significance of this
  result for compiler writers?  Usually it would be used to provide
  semantic proof techniques for meta-theoretic properties.

  We briefly explain that, as shown in the paper, completeness allows us
  to freely mix equational and semantic reasoning depending on what is
  convenient for the problem at hand, so long as our semantic reasoning
  remains model-independent.

* Line 75-79: this summary is unclear/confusing. What is a "proof of
  substitution"? How can you prove something forms an initial model
  without defining denotational semantics? What is "soundness of
  substitution"?

  We clarify that we: prove syntactic substitution, give a denotational
  semantics, and then prove the soundness of substitution w.r.t. this
  semantics.

* Is the model in 6.3 actually interesting from a memory model POV? Does
  SSA even manipulate memory?

  SSA is often used as an intermediate representation for low-level 
  languages such as C which manipulate memory via pointers, and hence
  expose memory manipulation operations as primitive instructions. We
  show that we can handle the semantics of these, even under weak memory
  conditions. TSO is in some sense the simplest non-SC model of 
  concurrency, and is used primarily as a proof-of-concept.

* The introduction of the paper is very short and doesn't give an
  overview of many of the technical developments. This makes the paper
  difficult to read as entire sections are self-contained asides that
  don't seem to contribute to the goals laid out in the Introduction.

  We have rewritten the introduction, and some of the earlier sections,
  to clarify the line of argument being laid out.

* Section 2

This section is mostly a nice overview of the known correspondence
between functional IRs/basic blocks with arguments and traditional SSA
form.

The end of Section 2 describing the benefits for reasoning is very
unclear, there is only about a paragraph of prose here. Most of the
work is on the reader to figure out what is going on in the
examples. The ultimate example seems to be rewriting the example in 7b
to the one in 6c, which doesn't seem like much of an optimizaiton. I
would try to find a better optimization as an example of the
dinaturality property.

Also it hardly seems necessary to repeat example 6b as 7a, this just
adds to the confusion in my opinion.

Fig 6 part b description doesn't make sense: "Programs 6a and 6b after
substitution; since the result is the same, both programs must be
equivalent". This is introducing Program 6b, so how can it be 6a and
6b after substitution? "since the result is the same" result of what?

Fig 7 part c says "equivalent to 7a by substitution" but it also
involves arithmetic, as mentioned in the prose.

Fig 7 description says "from 7c to 7a and therefore to 6c", but I
think the ultimate examples is intended to be 7b to 7c to 7a/6b to 6c?

It seems against the spirit of a compiler IR to me to rely on the
existence of product types for branching with multiple
arguments/multiple phi nodes or sum types for conditional
branching. This seems like an infelicity to realistic IRs that I
suspect makes the completeness theorem easier.

TODO: reply to this pls Neel

* Section 3

The introduction of effects here without any prior mention or
motivation is very jarring. I honestly don't know why effects are
included at all. They certainly aren't linked by the authors to
anything to do with existing SSA-based IRs.

Additionally no examples of what primitive instructions are used for
is given. I suppose this includes primitives like addition and
comparisons. But these presumably are pure so we haven't seen an
example of an impure primitive instruction.

Unless I'm missing something, it's not even described how a λSSA
program produces a result. Presumably it is by modeling "return" using
a distinguished output label.

Figure 8: Unless I am misunderstanding,
1. The two cases of a case expression should be expressions, not regions
2. abort a should also be a region

The distinction between expressions and regions is that branches are
only allowed to be in tail position. This was mentioned in passing in
section 2 but would be welcome to be re-emphasized here when the
syntax of λSSA is introduced.

* Line 439: Seems against the spirit of an IR to have implicit
  evaluation order. Isn't part of the translation to MNF, ANF, CPS and
  SSA specifying evaluation order explicitly?

  TODO: fix this

  We have reworked our narrative to clarify the distinction between
  lexical ("strict") SSA, ANF, and our slightly generalized 
  type-theoretic SSA. Lexical SSA and ANF both have explicit evaluation
  order; the introduction of type-theoretic SSA is to simplify rewriting.

* Bottom of page 12: there is an extended discussion here where
  technical definitions of basic block and terminator are introduced,
  but it's not clear to the reader why any of this matters, e.g., what
  it is used for. This makes the claim in 507 that some particular
  choice "greatly simplifies rewriting" very confusing because it's not
  clear how any of this relates to rewriting at all.

  We have rewritten both this section and the introduction to clarify
  this.

* Line 527: denotationally isn't it because the weakening of contexts
  corresponds to a function between product types consisting of
  projections, whereas weakening of labels corresponds to a function
  between sum types consisting of injections?

  Yes, but we postpone any discussion of category theory until Section 5.

* Substitutions and label-substitutions are being used on page 11 but
  aren't introduced until pages 12 and 14.

  TODO: address? hmm?

* In Lemma 3.1, the statement of this theorem seems to imply that case d
  only holds if L ≤ K. Is that actually necessary? I would have assumed
  that the rule would be that if Δ ⊢ σ : L ~~> K and Γ ≤ Δ and K ≤ K'
  then Γ ⊢ σ : L ~~> K' but maybe I'm misunderstanding.

  We have re-stated the lemma for clarity

Is it really necessary to recapitulate capture-avoiding substitution
in the body of the paper? Seems fine to relegate to the appendix.

* Section 4

Minor teminological point: Fig 14 is called "Congruence rules" but the
last two rules are not congruence rules, they are η
equivalences. Additionally the first 3 rules (refl/trans/symm) are not
congruence rules.

Line 721: reference to Rust seems a bit out of place

Line 840: How is the completeness theorem "relatively powerful" ?
Relative to what?

Line 834: "for other the other"

Fig 17: again only half of these rules are congruence rules

cfg-β₁: why does the expression a have to be pure? Shouldn't this be
valid for any a?

Line 929: this notation is ambiguous: in ∀ i. Γ, x: Aᵢ ⊢ tᵢ ▷ L,
(lⱼ(Aⱼ),)ⱼ it isn't clear what i or j range over. In particular it
appeared to me at first that they index over different sets but now I
think they are both ranging over the same set?

Also, in the notation for a where block do we really need the trailing
comma in (lᵢ(Aᵢ),)ᵢ ?

I don't really see why I should think of cfg-η as an η rule at
all. Where blocks aren't given by a universal property in the
semantics so I don't think it's appropriate to call any of their rules
β/η rules.

Line 1017-1018: What does "r where t" mean? Also why do we have a
typing side condition for r here but not e,s,t?

Line 1075: "It turns out that this being able to do this"

Line 1108-1111: if we are appealing to the completeness theorem to
prove equivalences in the theory is the theory really all that
convenient to use?

Line 1108-1111: this seems to be the first mention of an application
of the completeness theorem

In my opinion, since the article is supposed to be about SSA, Section
4 should *start* with the description of strict SSA and Figure 26 and
then introduce the "type-theoretic SSA" as a generalization, then
return to their equivalence, paralleling the structure of Section 2.

Section 4.4 is structured in a way that is difficult to follow. You
say you "introduce" strict regions, then you make several claims about
it, but you don't actually introduce strict regions for several pages.
This is the part of the article where the authors explain how their
type-theoretic calculus is related to ordinary SSA, but the structure
here makes it difficult for the reader to understand what the strict
region subset of the language is, because the description depends on
several different figures and a third version of the calculus, ANF.

Line 1174: "as an strict region"

Line 1250: this version of the translation into ANF is in the worst
case exponential in the size of the input program, because it
duplicates the continuation r in the translation of a case
expression. To avoid this you can create a *join point*. This doesn't
affect the correctness of the translation but it would be better if
you verified the non-naive version (which I think you should be able
to).

Fig 26: Why does your standard SSA allow for the branches of a case to
be arbitrary terminators (so including case as well?). Maybe it's a
typo. It seems unrealistic and also doesn't seem to be necessary as
your translation to strict SSA never has nested cases

Section 4.5: this is all very technical but ultimately
straightforward. Does it really need to be in this much detail in the
body of the paper?

* Section 5
Section 5: This is a pretty nice introduction to Premonoidal/Freyd
categories and recursion, but the lack of citations gives the
misleading and unintentional impression that these are new
concepts. In particular, Power and Robinson MSCS 1997 which introduces
premonoidal categories and Levy, Power and Thielecke Information and
Computation 2003 which introduces Freyd categories are not cited
anywhere in the paper, even though they provide similar soundness and
completeness results to those formalized in this work.

Especially the formulation of Elgot structure should be discussed and
compared with (co)-cartesian Traced monoidal categories, which were
studied in Hasegawa TLCA 1997 and Simpson and Plotkin LICS 2000.

Theorem 5.2: what does it mean for a subcategory to be an equivalence
relation? I think you just want to say that it is a thin subcategory

1855-56: what is meant by "continuous" here? homomorphism of join
semilattices?

2077-78: this was already defined on page 30

* Section 6

2302: "literature on strong Elgot monads": no citation????

2304: Maybe worth pointing out this is not constructive. This can be
done constructively if you use the partial elements monad Partial A := Σ(ϕ : Prop) ϕ ⇒ A.

2513: fewer not less

Section 6.3: I am not an expert on weak memory and found this section
very hard to follow, and again I don't know which parts are novel
contributions and which are taken from prior work (Kavanagh and
Brookes 2017).

* Section 7

2814-2815: then why is the more general setting included at all?

7.4.3: this section doesn't explain what guarded iteration is in
enough detail to be self-contained

Referee: 2

# Paper Summary

This paper studies the denotational semantics of programs in SSA (Static Single
Assignment) form.  SSA is an intermediate representation that is widely used in
practice (for instance in LLVM IR) because its structural properties make it
especially convenient for computing dataflow analyses and performing program
optimizations.  Defining any semantics for SSA programs is non-trivial, however.
Typical representations use "$\phi$-nodes", whose meanings depend on the dynamic
control-flow behaviors of the program, and SSA isn't fully compositional -- it
is too restrictive to permit good substitution principles.

This paper builds on prior understanding of SSA as a particular form of stylized
functional programming, observing that an SSA program can be seen as isomorphic
to a functional program with mutually-recursive functions that are called only
in tail position.  The resulting calculus is called $\lambda_{SSA}$.  The
authors use that structure to define a type system for programs in in this form,
where the typing judgments track (scoped) SSA variables along with the labels
(with arguments) that might be jumped to as exits from SSA terminators.

The paper then defines an equational theory over the $\lambda_{SSA}$ terms and
statements and shows that it is sufficient to express various program
transformations, including conversion to a "strict" SSA form that corresponds,
more or less, to the kinds of code supported by, e.g., LLVM IR.  The paper also
uses the equational theory to prove the B\"ohm-Jacopini theorm for SSA--this
theorem basically says that every SSA program is equivalent to one that uses
only well-structured loops, conditionals, and sequential composition.

Next, the paper gives a categorical semantics to $\lambda_{SSA}$, showing how to
intepret the syntax in any category that satisfies the conditions that make it
"Freyd Elgot".  Intuitively, "Freyd" categories support the notion of "impure"
morphisms, such as would be needed to model imperative state, distinguishing
such morphisms from the "pure" ones.  The operations on Freyd categories soundly
model the sitution in which pure operations can be commuted with other
operations, but impure operations (in general) cannot.  On the other hand
"Elgot" categories support a notion of iteration, providing the way to model the
(potentially looping) mutually recursive tail calls needed by $\lambda_{SSA}$.
This categorical semantics is shown to be sound and complete with respect to the
equational theory introduced earlier. 

Finally, as a last technical contribution the paper considers some concrete
models that have the needed structure to be Freyd Elgot categories, including
various kinds of monads, monad transformers, and trace models.  It culminates by
giving a semantics based on a "total store order" concurrent memory model.

The paper concludes with a survey of related work and possible future
directions.

# Top-level Review


This paper is massive, quite technical, pretty dense, and, I expect, will be
quite a challenging read for many potential consumers.  However, it has a lot of
very nice ideas that do form a cohesive and comprehensive story about how to
give denotational semantics to SSA-style programming languages.  The type system
for $\lambda_{SSA}$, which is one of the main contributions of the paper, seems
both novel and nicely structured.  I can therefore see that the technologly
introduced in this paper would be used, potentially by language/compiler
implementors, since it might lead to nice IR representations, but probably more
so by people interested in *formalizing* related SSA-based languages.

There are lots of minor typos and unclear details that I describe below, but, on
the whole, I am pretty confident that the technical claims made in this paper
are correct (or at least "morally correct").

The main way that this paper could be improved would be to make the exposition
more accessible, generally, through the use of more concrete examples and by
introducing more explanatory intuitions at appropriate points.  I've tried to
indicate a few such places in the comments below.

Over all, I would be happy to recommend this for publicationi after it has been
thoroughly revised.


# Higher-level Comments

- There are lots of minor typo-level mistakes throughout the paper. Around
  Section 5, I kind of ran out of steam about checking at that level of detail,
  so I'm not confident that I've caught errors at that point. 


- Given the length of the paper and the comments below about the rest of the
  paper; I haven't read the technical appendix carefully enough to be confident
  about the correctness of the proofs it contains. (Given the number of
  typo-level issues throughout the paper, I expect the appendix would also have
  similar mistakes.) Ideally, all of the results in the paper would be verified
  in Lean, including the claims of the appendix.

- The mechanized proofs in Lean mentioned in the intro and in a few theorems
  later in the paper weren't available for this reviewer to inspect. Access to
  them should somehow be made available somehow -- can you at least point to a
  git repo?

- Nowwhere in this paper does it discuss some other important, practical choices
  made for "real" implementations of SSA, such as found in LLVM's
  implementation.  In particular, SSA is "nice" (if you can call it that) for
  implementation in imperative languages because there you represent an SSA
  variable as a pointer to a small data structure that represents the
  right-hand-side defining the variable.  That data structure probably also
  includes a "next" pointer to the instruction following (and potentially also a
  "previous" pointer to make it into a doubly-linked list).  That "pointer
  graph" representation makes it easy to implement some operations on SSA form
  (sometimes by destructively updating the datastructure).  This paper is
  (legitimately) clearly interested in working at a higher level of abstraction,
  which is fine, but it would be good, in such a comprehensive paper, to
  acknowledge that there are other implementation issues at play when SSA is
  used (beyond just the semantics of the constructs).

- The first part of the "story" of Section 2 on pages 2--4 is a nice way to
  arrive at SSA, but later, when you then introduce ANF, and note that it
  doesn't have good substitution properties, you (line 290) "relax the
  restriction that expressions in a program must be atomic".  All of this
  together seems to be a bit convoluted: first you "introduce" SSA by adding
  resrictions, but then you "relax" it by removing them.  Your aim becomes a bit
  clearer only *much* later (all the way in Section 4.4) when you define "Strict
  SSA" and in Figure 26 "standard SSA" (which I read to mean "real" SSA).  For
  the reader, and especially one who already knows about SSA, this is all a bit
  of a roller-coaster ride.  
  
  I think that it would help to be more explicit about your aim to produce
  $\lambda_{SSA}$, which is a well-behaved _superset_ of "real" SSA, but for
  which it is easy to show how to translate *into* "real" SSA.
  
  
- Section 4.6: the B{\"o}hm-Jacobini theorem could really benefit from some kind
  of example.  My intuition is that this involves doing a lot of code copying to
  "massage" the CFG into the right form, and I was naturally wondering about
  control-flow-graphs that are irreducible because of non-well structured
  jumps. Something like (variations on):
  
  ```
  if x then br l(0) else br r(1)
  where 
    l(y) : let x = y+1 in br r(x)
	r(w) : let z = w+1 in br l(z)
  ```

  In general, this section is a lot of pretty dense set up to get to the
  theorem, but without giving any intuitions about what the $WH$ and $PW$
  transformations do (e.g., why are $WH$ and $PW$ even the acronyms?)


- Section 5: It wasn't completely clear to me what part of this section is "new"
  and what part is just a presentation of existing work.  Surely the concepts of
  Freyd and Elgot structures already exist, but are you claiming that the
  combination is new? 
  
  Also, the transition to this section is a bunch of background and then (at the
  top of page 34) we get "Given that we want to model SSA with some category C,
  ..." but, by this point in the paper, the reader may have lost track of the
  goal of giving a categorical semantics.  I would *start* this section by
  reminding the reader that the goal is to do that and *then* go into the
  desiderata and background.  You might also confirm a bit of the notation that
  you implicitly use, for instance, it is not always "standard" to use the name
  of an object as the name of its identity morphism when presenting category
  theory (sometimes people write $id_{A}$, for instance); similarly for `;` for
  composition rather than `circ`, so a brief recap of what category theory
  notation you adopt would be welcome here too.
  
- Section 6.3: This TSO weak memory model is a *lot* of added complexity on top
  of an already *very* technical and dense paper.  I'm not sure that it is
  actually needed here.  Moreover, this section is almost all "set up"--it
  introduces pom sets, and then builds up the relevant theory to define an SSA
  semantics, but there isn't really any "punchline"---can you justify an
  interesting/important program transformation using this model?  Is there a
  clear example of that?  

# Additional / more-comprehensive related work:

  The paper has a decent related work secction (but perhaps it spends too much
  real estate on compositional concurrency models, given how that is mostly
  pertinent only to Section 6.3.

  Section 7.2 describes some related work about formalizations of SSA and
  mechanizations of SSA semantics, but it is missing some important references
  for LLVM IR, particularly K-LLVM [LG20] and Crellvm [KKSJ+18] (see references
  below).
    
  More egregiously, it seems to be missing any discussion of *very* related
  work.  Although it cites the Vellvm project's POPL 2012 paper, it neglects the
  much more relevant work from ICFP 2021 [ZB+21] which gives a *denotational*
  semantics to LLVM IR based on the ITrees paper presented in POPL 2020
  [XZHH+20]. There is also recent follow-on work that addresses concurrency
  [CHZ25].
  
  In particular, as shown in the POPL 2020 paper, ITrees (and monad transformers
  based on them) satisfy the Freyd Elgot structure requirements in a way that is
  a generalization (to coninductive trees rather than streams) of the trace
  models presented in this paper's Section 6.2.  The ITrees paper even states
  the same set of equations for working with Elgot structure (i.e., codiagonal,
  etc.). The ICFP 2021 paper uses that structure to give a semantics to LLVM IR
  in almost the same way as done in this paper: the denotation of a control flow
  graph is via their `iter` operation, which corresponds to the use of your
  `rfix` on line 2007.
  
  However, there are also some differences: they build the `rfix` operation in a
  different way: by interpreting via the state transformer after applying
  `iter`/fix.  They also give a different treatment of phi nodes.  However,
  their semantics also embeds the SSA control-flow-graph semantics into a domain
  in which mutually-recursive functions can also be denoted, so they are able to
  interpret `call` operations that appear on the right-hand-sides.
  
  Beyond just doing a thorough comparison to "modern Vellvm" in the related work
  of your paper, I think that it bolsters your case to point to those results as
  another concrete model that can be seen as an instance of your framework.
  Indeed, I see the fact that other researchers exploit more-or-less the same
  structure as a good indicator that the ideas presented by your paper are "on
  the right track"!


# Detailed Comments


- Already in Figure 1.(b) I was a bit confused by the presence of `ret a` in the
  else branch of the 3-address code.  That looks a bit nonstandard by comparison
  to "strict" SSA.

  

- line 128: I don't think this description of the dominance tree is correct --
  you don't want to intersect the strict dominance relation with the direct
  predecessor relation because there are "immediate dominators" in the dominance
  tree that don't follow the control-flow edges.  For example for the
  control-flow-graph below (where all edges point "down"), the dominance tree
  has edge `A -> M`, but `A` is not a predecessor of `M`
  
```
   CFG     Dominance Tree
    A           A
   / \         /|\
  B   C       B | C
   \ /          |
    M           M
```

  Instead, the immediate dominance relation should be something like: If `A` and
  `B` are distinct nodes, then `A` immediately dominates `B` if (1) `A`
  dominates `B` and, (2) for every other node `C` that also dominates `B`, `C`
  dominates `A`. 



## Operational semantics for phi nodes

A couple times in the paper, you assert that phi nodes do not have an obvious
operational semantics. (e.g. line 174).  Is it really that hard?  Yes, the
operational semantics machine configurations would need to track a bit more
information than is usual (namely, the label of the currently executing block)
and, yes, we would need a separate judgment to handle phi nodes, since they
execute "in parallel" and with respect to the state at the end of the block that
they were jumped to from, but that doesn't seem too conceptually difficult.
Something like the following "big step" rules are probably close:

The following rule evaluates a single phi node, having arrived via a branch from
the `from_lbl` block, being sure to use the original local environment,
$\sigma_0$, not the one being produced by running the phi nodes.  P is the
program.

```
<$\sigma_0$, exp_(from_lbl)> ==> v
---------------------------------------------------------------------------------------------------
P |- $\sigma_0$, <$\sigma$, from_lbl, to_lbl, let x = phi[lbl_i = exp_i]> ==> \sigma[x $\mapsto$ v]
```

The following rule executes a branch, "copying" the local environment so the
phis can read it in parallel:

```
P(lbl) = phis ; body; term

P |- $\sigma_0$, <$\sigma_0$, cur_lbl, lbl, phis> ==> $\sigma_1$
P |- <$\sigma_1$, body> ==> $\sigma_2$
P |- <$\sigma_2$, term> ==> $\sigma_3$
---------------------------------------------------
P |- <$\sigma_0$, cur_lbl, br lbl> ==> $\sigma_3$
```

So, I'm not sure that giving an operational semantics to phi nodes is that hard.
However, I would agree that it would probably be hard to *reason about* the
operational semantics I sketched above (for the same reason that operational
semantics that introduce auxilliary information into the machine configurations
are usually hard to work with).


- line 178: "$i_0$ and $i_1$" --> should be "$a_1$ and $i_1$"

- line 279: "simply introduce new anonymous basic blocks...": Shouldn't that say "simply introduce new basic blocks with fresh names"?  These clearly are not anonymous since they have names.

- line 209: this is where the "story" of the this section started to get lost on
  me.  First you simplified down to SSA, now you pivot to "relaxing" the ssa
  back to a more compositional language
  
- line 330 in the caption (b): mentions 6(a) and 6(b), but this *is* 6(b).  Do you mean 5(a) and 5(b)?

- line 340: the branch instructions should have parameters $a$ and $b$, not $x$: 
  `if e { br l(a) } else {b l(b) } where l(x) : {t}`
  
- line 391: missing period

- line 409 and line 1237: Many variants of SSA (including the one used by LLVM
  IR) do *not* allow just a variable on right-hand-side of an assignment.
  Conceptually, that forces even more normalization than your $\lambda_{SSA}$
  requires to be considered "strict" SSA as you define in Figure 23 (where you
  would just drop the var rule). With this restriction, since you can't have
  `let x = y; e` you are forced to always substitute `e{y/x}` whenever you would
  have such a "trivial" binding.  This might be worth mentioning somewhere in
  your paper.

- line 413 Figure 8: Should include $r$ (used often elsewhere, but specifically
  mentioned on line 430) in addition to $s$ and $t$ as metavariables.

- line 436: the math at the end is missing an "and" -- there is no space before $\epsilon \leq epsilon'$

- lines 461 and 469: why say "(potentially effectful)" on line 469 and not for
  line 461, which is describing the analgous evaluation for expressions?

- line 471: the syntax for the where statement is missing a comma compared to
  the grammar shown on line 415.  This is a good place to mention that you
  should explicitly spell out your "indexing" scheme for the use of subscripts.
  In some rules, it is not completely clear whether, i.e., the index $i$ and the
  index $j$ refer to the *same* sequence of terms or to distinct terms.
  
  For example, in the `where` rule of Figure 10, you use labels indexed by $i$
  and $j$ in the same rule and even with different, local quantification over
  $i$ in the second clause.  I would be a bit more careful about how you present
  these indexed terms.  (Personally, I like Ott's "overbar" quantification for
  these kinds of situations.)  In this particular case, I would be tempted to
  always use $i$ to range over the full set of `where`-bound labels and use $j$
  to iterate over the individual clauses. It might also help to present the
  index sets that $i$ and $j$ are ranging over directly (in this case so we can
  see they're the same). Something like:
  
  \[
  \Gamma \vdash r \rhd L, (\ell_i(A_i),)_{i\in I}
  \forall j\in I, \Gamma, x_j : A_j \vdash t_j \rhd L, (\ell_i(A_i),)_{i\in I}
  -----------------------------------------------
  \Gamma \vdash r where (l_i(x_i) : {t_i},)_{i\in I}
  \]
  
  
- line 479: should both clauses here map $defs$ over $r$?  i.e.
  ```
  defs(let x = e; r) = (x,e)::(defs r)
  ```
  
- line 521: "L types less regions than K" --> "L types *fewer* regions than K"

- line 537: I believe these $\sigma$'s should be $\gamma$'s (per the rules in Fig. 11)

- line 538: I don't think you intend $L \leq K$ to be a precondition to (d), but
  the lemma require is.

- line 574: "rules given in Figure 10" --> "rules given in Figure 11"

- lines 570-575 and Fig. 12: the terminology around "empty" versus "identity"
  substitution could be clearer.
  
- lin 585: have you mentioned that you use $\rho$ to also range over
  substitutions?  Why not use $\gamma_1$ and $\gamma_2$ like you do later on
  line 620?

- line 631: The capital $\Gamma$ on this line should be a lower case $\gamma$

- line 634: is the choice of left extension here important?  are you somehow
  indicating that you'll only substitute for the "rightmost" variable in the
  context somehow?
  
- line 653: The notation of the judgment on this line is messed up, it should be
  $\Gamma \vdash \sigma : L ~> K$`

- line 675: "left exension" arrow seems to bind to just the $x$ -- maybe
  parenthesize?

- line 704: (very minor) it is a bit redundant to include the exisential
  quantifier in this rule.  It's OK to leave it there, but it does seem a bit
  inconsitent to include it here but not in, e.g., the transitivity case, which
  also has an existentially quantified $b$ (since it appears only in the
  premises)
  
- line 891: the congruence rule for cfg's is another place where I'd be careful
  with the use of indices.
  
- line 900: the substitution should be $[a/x]r$ not what is written

- pg 19 / lines 926-931: I would not include any text beyond just Figures 18 and
  19 on this page -- the small amount of room on the bottom doesn't give you
  enough space.  Also the current layout puts an inference rule there, which
  visually looks like part of Fig. 18
  
- line 930: the cfgs rule is another one where the indices could be made clearer

- line 963: Your assertion that you only need to add the ability to get rid of a
  single, trivial where-block isn't completely obvious.  Maybe expand the
  explanation about why that is sufficient?
  
- line 976: I agree that explaining the rule point-by-point is a good strategy,
  but you could also conne ct your explanation back to the example introduced
  just prior (on lines 973-974).  That is, as you explain each step of the rule,
  instantiate it to show how to derive the result in equations (10) and
  (11). Doing so would help the reader "follow along" in your point-by-point
  explanation.
  
- line 990: "a new output value of $y$" -- Shouldn't this be $x$? (in the
  pseudocode you assign to $x$)
  
- line 103 / equation (14): you might make your case even more forcefully if you
  include the `; hi` too (after the "end" of the loop).  That would make it
  clear that even though syntactically it looks like the hi could be run,
  semantically it never will be.
  
- line 1015: the word "this" here is, I think, refering to the "uni" rule, but
  that is a bit far away since it was introduced way back on line 967.  Just say
  "the uni rule is equivalent to..."
  
- line 1023: please don't just use $,$ to separate judgments -- help the reader
  with parsing by using "and" or some other bit of text

- line 1047: I think that should just be $\sigma$ and not $\sigma_i$ in the
  dinat rule.  (I'm not sure what $\sigma_i$ would mean here.)
  
- line 1057: I don't think you've defined the terminology "unary" and "n-ary"
  control-flow graphs.  Maybe inline the definitions or explain more clearly
  what you mean?
  
- lines 1095-1107 / equations (16) and (17): I would have appreciated a brief
  description of what these rules accomplish rather than having to try to wade
  through the nested `where` clauses to see what's going on.  Maybe explain them
  in terms of merging scopes of control-flow graphs?

- line 1129: I believe that $L'$ should be $K$ in Lemma 4.1(b)

- line 1135: "note that this lemma" -- I think that the "this" here actually
  refers to the next lemma, Lemma 4.2 that actually uses an equivalence relation
  on substitutions?  (not Lemma 4.1?)
  
- line 1166: Strict SSA - I had been wondering about this for a long time by
  this point in the paper.  Please do more signposting up front.

- line 1255: Lemma 4.4: Maybe swap the order of the bullet points to keep them
  consistent with the earlier part of lemma claims?
  
- lines 1293-1298: This `struct` definition of basic blocks seems quite out of
  place at this point in the paper. It also doesn't seem to be very surprising,
  since we know that we can structure the blocks according to the dominator
  tree.  I might cut this inductive representation from this part of the paper
  -- maybe move it to a discussion section at the end, where you could talk
  about what your theory suggests about implementing SSA-based IRs?
  
- line 1308: I think you *don't* want to recursively invoke `children` on the
  $t_i$'s -- those *are* the children, right?  (doing so would contradict
  equation (24), I think)
  
- line 1410 / Fig. 26: This figure gets buried in the text.  I would put it at
  the top of the page to make it more prominent.  Also, here is where I was
  really wondering about the choice of including "naked" variables as atomic
  expressions for SSA.  Also, I was wondering about why you chose "split"-style
  product elimination rather than projection-style.  The latter seems more
  natural for SSA because in practice, each SSA instruction usually defines only
  *one* variable.  That is a result of conflating addresses with variable names
  in "real" implementations of SSA IRs, in which a "variable name" is just a
  pointer to the instruction that defines the variable.
  
- Section 4.5: This is a very dense bunch of definitions with no concrete
  examples.  Maybe introduce a simple running example that has a record with
  just three fields and/or and enum with just a couple cases and show the
  results of the encoding by `pack`, etc.?

  
- line 1469: the `case_L e` should be `case_L x`, I think.

- line 1486: This equation (48) seems to duplicate the definition of $\infty$
  shown in equation (45).
  
- line 1496+: I found the use of "fixing a distinguished variable $\box$" (and
  later a distinguished label) a bit tricky to think about throughout this
  section.  First, SSA doesn't allow variable re-use, and second, I think there
  are some cases where it's confusing / leads to incorrectness (e.g. line 1558).
  I think that you somehow mean for these operations that introduce $\box$ to
  stand for a "macro" that picks a sufficiently fresh variable each time it is 
  invoked.
  
- line 1500 equation (51): I found it quite hard to even parse the part after
  the ==> here.  Maybe saying in the sentene above that the "variable packing"
  operator is written as $\langle r \rangle^{\otimes}$ would help.  Maybe
  putting parentheses around the $( \box : [\Gamma] )$ before the turnstile, or
  just adding a bit more space would help?

- line 1539 equation (56): Say something about $\ell$ fresh here too?  Again,
  I'm not sure how these distinguished variables work out if the operation is
  applied several times.
  
- line 1557 / loop: I found this rule hard to follow, though I understand the
  intent. The occurrences of distinguished variable $\box$ in this rule aren't
  consistently typed, since one of them has type $A$ and the other must have a
  sum type (in the `case`) (I think!?)  You're binding $\box$ in $\ell$ here,
  but the `seq` also binds it?  Is all this "distguished variable" stuff trying
  to avoid making freshness side conditions in various places?  If so, I'm not
  sure that this is any easier to follow than just being explicit about when you
  need to pick fresh variable names.  It leads to "cute" results like equation
  (57), but I don't know if this acctually helps the reader.
  
  If you were to try to mechanize this part of the paper, how would you deal
  with the "distinguished" variable?
  
- line 1583: I think this should be $pack_{\ell}^{+} (L) (a)$ -- the subsript
  $\ell$ goes with `pack`

- line 1596: It would be helpful to also explain the base case of the PW
  transformation, since that is where the use of `pack` occurs.
  
- line 1603: Again, please don't separate judgment by just `,` -- that makes it
  very hard to parse!
  
- line 1646: I believe the last alpha should be $\alpha_{B,C,D}$ not $A,B,C$.

- line 1686 (and elsewhere): Do you have a citation for the definition of a
  Freyd category?
  
- line 1698: You use the $\to_{\bot}$ notation for a "pure morphism" here, but
  not in the previous bullet where $\Delta_A$ is also "pure".  You don't
  introduce the notation until line 1711.  Maybe move the introduction of the
  notation for morphisms in $C_{\bot}$ into the definition of a Freyd category
  near line 1688?  That way it is "in scope" everywhere you need it.  Also, use
  it consistently everywhere.
  

- line 1697: Is $!_A$ also required to be "pure"?

- line 1875 (Fig 31): red vs. black lines may be had to distinguish if printed
  and also for color-blind readers.  Maybe make the red lines dotted instead?
  
- line 2049 Lemma 5.6.  I'm not sure about the "Givens" here.  Don't you mean $L
  \leq K$ instead of, or in addition to? $K' \leq K$, and don't you also need to
  assume $\Gamma' \leq Delta$?
  
- line 2185: Object ... *are* types $A, B, C$

- line 2244: I think you don' need `br ret $\box$`, just `ret $\box$`

- line 2307: This use of the `Option` monad seems very "classical" -- i.e. the
  fixpoint definition doesn't seem to be very computable, thanks to the
  existential quantifier.  That's probably not a problem "mathematically", but
  might be a bit unsatisfactory from an implementation point of view.  It might
  be more satisfying to use Capretta's "Delay" monad instead, or, as I suggested
  in the  "more related work comments", ITrees.
  
- line 2345: Definition 6.1 Elgot submonad: This part claims that "Elgot
  submonads" are an "important source of models", but doesn't say anything about
  *why* such models are important?  Can you give at least some intuition /
  examples / justification for why that is the case?
  
- line 2415: I would move this paragraph down into 6.3, since it is introducing
  the idea of building a TSO model

- line 2458 equation (97): should the $f_0 a$ on line 2459 be $f_0 a_0$?  Also,
  please give at least some kind of intuition about what this definition is
  trying to capture.  
  
- line 2815: "latter" --> "former" having effect $\bot$

- line 2847: I was wondering thoughout the paper about "refinement" versus
  "equivalence".  In practice, refinement might be more useful to model than
  "just" equivalence, particularly when you get to modeling more "realistic"
  low-level SSA-based languages that have nondeterminism and undefined
  behaviors.  It might be a good idea to state somewhere early on (maybe in the
  intro?) that you're not going to focus on refinement in this paper. (And then
  point to the future work discussion?)

- line 2863 guarded iteration: I wonder how ITrees and other
  coinductively-defined structures connect to this discussion of the future
  work.

# Bib References

```
@inproceedings{LG20,
  author    = {Liyi Li and Elsa Gunter},
  title     = {K-LLVM: A Relatively Complete Semantics of LLVM IR},
  doi = "10.4230/LIPIcs.ECOOP.2020.7",
  booktitle = {34rd European Conference on Object-Oriented Programming, {ECOOP} 2020, Berlin, Germany},
  year      = {2020},
}

@inproceedings{KKSJ+18,
author = {Kang, Jeehoon and Kim, Yoonseung and Song, Youngju and Lee, Juneyoung and Park, Sanghoon and Shin, Mark Dongyeon and Kim, Yonghyun and Cho, Sungkeun and Choi, Joonwon and Hur, Chung-Kil and Yi, Kwangkeun},
title = {Crellvm: Verified Credible Compilation for LLVM},
year = {2018},
isbn = {9781450356985},
publisher = {Association for Computing Machinery},
address = {New York, NY, USA},
url = {https://doi.org/10.1145/3192366.3192377},
doi = {10.1145/3192366.3192377},
booktitle = {Proceedings of the 39th ACM SIGPLAN Conference on Programming Language Design and Implementation},
pages = {631–645},
numpages = {15},
keywords = {credible compilation, LLVM, relational Hoare logic, translation validation, Coq, compiler verification},
location = {Philadelphia, PA, USA},
series = {PLDI 2018}
}

@Article{XZHH+20,
  author = 	 {{Li-yao} Xia and Yannick Zakowski and Paul He and {Chung-Kil} Hur and Gregory Malecha and Benjamin C. Pierce and Steve Zdancewic},
  title = 	 {Interaction Trees},
  journal = 	 {Proceedings of the ACM on Programming Languages},
  doi = "10.1145/3371119",
  year = 	 2020,
  volume = 	 4,
  number = 	 {POPL},
}

@Article{ZB+21,
  author = 	 {Yannick Zakowski and Calvin Beck and Irene Yoon and Ilya Zaichuk and Vadim Zaliva and Steve Zdancewic},
  title = 	 {Modular, Compositional, and Executable Formal Semantics for LLVM IR},
  journal = 	 {Proceedings of the ACM on Programming Languages},
  year = 	 2021,
  volume = 	 5,
  number = 	 {ICFP}
}

@inproceedings{CHZ25,
author = {Chappe, Nicolas and Henrio, Ludovic and Zakowski, Yannick},
title = {Monadic interpreters for concurrent memory models: Executable semantics of a concurrent subset of LLVM IR},
year = {2025},
publisher = {Association for Computing Machinery},
url = {https://perso.ens-lyon.fr/nicolas.chappe/muvellvm-concurrency-draft.pdf},
series = {CPP 2025}
}


```

