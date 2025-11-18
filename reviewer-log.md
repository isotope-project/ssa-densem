* Please also provide a way for reviewers to access your mechanized proofs when you submit the revised version.



- - - - - - - - - -

From the reviewers:

Referee: 1

Comments to the Author

* The paper also suffers from some major presentational issues. The
  introduction of the paper is extremely short (1 page!) and does not
  mention many aspects of the paper that then later come as complete
  surprises (effect system? Bohm-Jacopini theorem?).

  We have rewritten the introduction, as well as sections 2 and 3, in 
  order to make the paper more accessible. 

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

  We have done this. 

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

  At the end of section 6, we explain how a number of models from the 
  literature fail to satisfy common equations used by compilers (and
  which are required by our axiomatization). 


* Line 63-65: "We show that any denotational model with this categorical
  structure is also a model of SSA" not sure what the distinction
  between "denotational model" and "model of SSA" is here, it seems
  redundant

  We have rephrased this. 

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

We have completely rewritten this section to take reviewer comments into
account 

* It seems against the spirit of a compiler IR to me to rely on the
  existence of product types for branching with multiple
  arguments/multiple phi nodes or sum types for conditional
  branching. This seems like an infelicity to realistic IRs that I
  suspect makes the completeness theorem easier.

  In fact, the internal type systems of many compiler IRs do support
  these types!  The SSA IR in the MLton compiler, the SIL IR used in
  the Swift compiler, and the SSA IR in the Jikes Java compiler all
  have tagged and composite datatypes. If one desires to booleans, we
  can simply specialize all the sum types to 1 + 1 to get the desired
  equations and semantics. However, having sum types makes it much
  easier to express transformations that change control-flow to
  dataflow or vice-versa.
 

* Section 3

We have also rewritten this section, and simplified the effect system
to a pure/impure distinction. 

* Line 439: Seems against the spirit of an IR to have implicit
  evaluation order. Isn't part of the translation to MNF, ANF, CPS and
  SSA specifying evaluation order explicitly?

  It is straightforward to make the effect system more restrictive and
  rule out terms with effectful subexpressions, but allowing them
  simplifies equational transformations of programs by permitting more
  intermediate forms. This is in line with our decision to permit
  composite expressions at all.

* Bottom of page 12: there is an extended discussion here where
  technical definitions of basic block and terminator are introduced,
  but it's not clear to the reader why any of this matters, e.g., what
  it is used for. This makes the claim in 507 that some particular
  choice "greatly simplifies rewriting" very confusing because it's not
  clear how any of this relates to rewriting at all.

  We have rewritten both this section and the introduction to clarify
  this.

* Substitutions and label-substitutions are being used on page 11 but
  aren't introduced until pages 12 and 14.

  We have rewritten sections 2 and 3. 

* In Lemma 3.1, the statement of this theorem seems to imply that case d
  only holds if L ≤ K. Is that actually necessary? I would have assumed
  that the rule would be that if Δ ⊢ σ : L ~~> K and Γ ≤ Δ and K ≤ K'
  then Γ ⊢ σ : L ~~> K' but maybe I'm misunderstanding.

  We have re-stated the lemma for clarity. 

* Is it really necessary to recapitulate capture-avoiding substitution
  in the body of the paper? Seems fine to relegate to the appendix.

  This is now in the appendix. 

* Section 4

* cfg-β₁: why does the expression a have to be pure? Shouldn't this be
  valid for any a?

  Branches are only allowed to provide a pure argument to make label 
  substitution simpler. 

* Line 929: this notation is ambiguous: in ∀ i. Γ, x: Aᵢ ⊢ tᵢ ▷ L,
  (lⱼ(Aⱼ),)ⱼ it isn't clear what i or j range over. In particular it
  appeared to me at first that they index over different sets but now I
  think they are both ranging over the same set?

  They range over different sets. We've added explict domains (i ∈ I, j ∈ J)
  whenever we quantify over two sets. 

* Also, in the notation for a where block do we really need the trailing
  comma in (lᵢ(Aᵢ),)ᵢ ?

  We write it as a comma-separated list, and neither keeping or omitting 
  it "looks right," so we picked the less-ambiguous one. 

* I don't really see why I should think of cfg-η as an η rule at
  all. Where blocks aren't given by a universal property in the
  semantics so I don't think it's appropriate to call any of their rules
  β/η rules.

* Line 1017-1018: What does "r where t" mean? Also why do we have a
  typing side condition for r here but not e,s,t?

  TODO

* Line 1108-1111: if we are appealing to the completeness theorem to
  prove equivalences in the theory is the theory really all that
  convenient to use?

  First, when writing a compiler, the equations are all we have, so it's
  valuable to know we have a complete set. Second, even when doing things by
  hand, there are other cases where it's easier to work syntactically than to 
  work in the model. 

* In my opinion, since the article is supposed to be about SSA,
  Section 4 should *start* with the description of strict SSA and
  Figure 26 and then introduce the "type-theoretic SSA" as a
  generalization, then return to their equivalence, paralleling the
  structure of Section 2.

  We have rewritten section 4.4. along these lines. 


* Line 1250: this version of the translation into ANF is in the worst
  case exponential in the size of the input program, because it
  duplicates the continuation r in the translation of a case
  expression. To avoid this you can create a *join point*. This doesn't
  affect the correctness of the translation but it would be better if
  you verified the non-naive version (which I think you should be able
  to).

  We have replaced it with the linear-time algorithm. 

* Fig 26: Why does your standard SSA allow for the branches of a case
  to be arbitrary terminators (so including case as well?). Maybe it's
  a typo. It seems unrealistic and also doesn't seem to be necessary
  as your translation to strict SSA never has nested cases

  Many SSA IRs have an n-ary exit form to defer deciding whether
  C-style switch statements or pattern matching should be compiled
  with jump tables or a sequence of conditionals. We can represent
  n-ary branches with nested cases. 

* Section 4.5: this is all very technical but ultimately
  straightforward. Does it really need to be in this much detail in the
  body of the paper?

  We have taken it out of the main body. 

* Section 5

* Section 5: This is a pretty nice introduction to Premonoidal/Freyd
  categories and recursion, but the lack of citations gives the
  misleading and unintentional impression that these are new
  concepts. In particular, Power and Robinson MSCS 1997 which introduces
  premonoidal categories and Levy, Power and Thielecke Information and
  Computation 2003 which introduces Freyd categories are not cited
  anywhere in the paper, even though they provide similar soundness and
  completeness results to those formalized in this work.

  We have added this citation. 

* Especially the formulation of Elgot structure should be discussed and
  compared with (co)-cartesian Traced monoidal categories, which were
  studied in Hasegawa TLCA 1997 and Simpson and Plotkin LICS 2000.

  We reworked this section slightly to give more context, but felt discussing
  traces was better left to the later section on string diagrams, where we
  already had a citation for Hasegawa CTCS 2002 in which the correspondence
  between traces on the coproduct and fixpoints is laid out.

* Theorem 5.2: what does it mean for a subcategory to be an equivalence
  relation? I think you just want to say that it is a thin subcategory

  We give the definition immediately afterwards.

* 1855-56: what is meant by "continuous" here? homomorphism of join
  semilattices?

  We have simplified the definition to remove this complication

* 2077-78: this was already defined on page 30

  TODO: confused

* Section 6

* 2302: "literature on strong Elgot monads": no citation????

  We have reworked this slightly, and added a citation

* 2304: Maybe worth pointing out this is not constructive. This can be
  done constructively if you use the partial elements monad Partial A := Σ(ϕ : Prop) ϕ ⇒ A.

  We have added a footnote

* Section 6.3: I am not an expert on weak memory and found this section
  very hard to follow, and again I don't know which parts are novel
  contributions and which are taken from prior work (Kavanagh and
  Brookes 2017).

  We have reworked this section slightly, and adjusted our wording to make it
  clear that we only slightly adapt Brookes' model to our framework

* Section 6.3: I am not an expert on weak memory and found this section
  very hard to follow, and again I don't know which parts are novel
  contributions and which are taken from prior work (Kavanagh and
  Brookes 2017).

  The model is essentially that of Kavanagh and Brookes, but we
  additionally show that their model has the structure of an Elgot
  monad (which they did not prove).

* 7.4.3: this section doesn't explain what guarded iteration is in
  enough detail to be self-contained

  Our paper doesn't use guarded iteration, so we think that explaining
  it in detail (rather than pointing to the literature) would be distracting
  to readers. 


Referee: 2


# Higher-level Comments

- There are lots of minor typo-level mistakes throughout the paper. Around
  Section 5, I kind of ran out of steam about checking at that level of detail,
  so I'm not confident that I've caught errors at that point. 

  We have went over the paper and have attempted to correct typos and clarify
  our exposition.

- Given the length of the paper and the comments below about the rest of the
  paper; I haven't read the technical appendix carefully enough to be confident
  about the correctness of the proofs it contains. (Given the number of
  typo-level issues throughout the paper, I expect the appendix would also have
  similar mistakes.) Ideally, all of the results in the paper would be verified
  in Lean, including the claims of the appendix.

  We have clearly stated what was verified in Lean and what was proven on paper. 

  In fact, in followup work we have formalized many of the soundness properties 
  for a more general language, but because that type theory is somewhat different
  we don't want to claim that for this paper. 

- The mechanized proofs in Lean mentioned in the intro and in a few theorems
  later in the paper weren't available for this reviewer to inspect. Access to
  them should somehow be made available somehow -- can you at least point to a
  git repo?

  We have added a section with links to the Git repository, and a description
  of the formalization.

- Nowwhere in this paper does it discuss some other important, practical choices
  made for "real" implementations of SSA, such as found in LLVM's
  implementation.  

  Representations like sea-of-nodes are obviously important from the
  perspective of an implementator, but are largely orthogonal to our
  work. Because our lexical SSA is just ordinary SSA with annotations
  for the dominance tree, type-theoretic and normal SSA should be 
  represented identically in a compiler. 

- The first part of the "story" of Section 2 on pages 2--4 is a nice way to
  arrive at SSA, but later, when you then introduce ANF, and note that it
  doesn't have good substitution properties, you (line 290) "relax the
  restriction that expressions in a program must be atomic".  [...]  
  I think that it would help to be more explicit about your aim to produce
  $\lambda_{SSA}$, which is a well-behaved _superset_ of "real" SSA, but for
  which it is easy to show how to translate *into* "real" SSA.

  We have rewritten this section completely in an attempt to clarify the
  narrative.
  
- Section 4.6: the B{\"o}hm-Jacobini theorem could really benefit from some kind
  of example.  

  We ended up moving our discussion of the B{\"o}hm-Jacobini theorem to the
  appendix as part of cleaning up our narrative.

- Section 5: It wasn't completely clear to me what part of this
  section is "new" and what part is just a presentation of existing
  work. [...] Also, the transition to this section is a bunch of
  background and then (at the top of page 34) we get "Given that we
  want to model SSA with some category C, ..." but, by this point in
  the paper, the reader may have lost track of the goal of giving a
  categorical semantics.

  We added some more citations, reworded this section somewhat, and began the 
  section with a recap and a primer on notation.
  
- Section 6.3: This TSO weak memory model is a *lot* of added complexity on top
  of an already *very* technical and dense paper.  I'm not sure that it is
  actually needed here.  Moreover, this section is almost all "set up"--it
  introduces pom sets, and then builds up the relevant theory to define an SSA
  semantics, but there isn't really any "punchline"---can you justify an
  interesting/important program transformation using this model?  Is there a
  clear example of that?  

  First, we wanted to show that a weak memory model that is actually
  shipped in real hardware, in fact forms a model of SSA. One of the biggest
  payoffs of this is, in some sense, the dogs which didn't bark. All
  of the usual control and dataflow optimizations remain valid, even 
  in the presence of weak memory. 

* More egregiously, it seems to be missing any discussion of *very*
  related work.  Although it cites the Vellvm project's POPL 2012
  paper, it neglects the much more relevant work from ICFP 2021
  [ZB+21] which gives a *denotational* semantics to LLVM IR based on
  the ITrees paper presented in POPL 2020 [XZHH+20]. There is also
  recent follow-on work that addresses concurrency [CHZ25].

  We have added citations to both papers, and have discussed how 
  iTrees form a model of λssa. 
  
# Detailed Comments


- Already in Figure 1.(b) I was a bit confused by the presence of `ret a` in the
  else branch of the 3-address code.  That looks a bit nonstandard by comparison
  to "strict" SSA.

  We clarify that returns are just jumps to a distinguished exit label. 

- line 128: I don't think this description of the dominance tree is correct --
  you don't want to intersect the strict dominance relation with the direct
  predecessor relation because there are "immediate dominators" in the dominance
  tree that don't follow the control-flow edges.  

  We have fixed the definition. 

## Operational semantics for phi nodes

* A couple times in the paper, you assert that phi nodes do not have an obvious
  operational semantics. (e.g. line 174).  Is it really that hard?  Yes, the
  operational semantics machine configurations would need to track a bit more
  information than is usual (namely, the label of the currently executing block)
  and, yes, we would need a separate judgment to handle phi nodes, since they
  execute "in parallel" and with respect to the state at the end of the block that
  they were jumped to from, but that doesn't seem too conceptually difficult.

  As you note, nothing about this is impossible. It just adds friction
  to the metatheory and to reasoning about programs, and one of our goals
  was to identify and eliminate these sources of friction (for example, we 
  admit nested expressions to simplify subsitution). 

* line 209: this is where the "story" of the this section started to get lost on
  me.  First you simplified down to SSA, now you pivot to "relaxing" the ssa
  back to a more compositional language

  We have completely rewritten this section

* line 409 and line 1237: Many variants of SSA (including the one used by LLVM
  IR) do *not* allow just a variable on right-hand-side of an assignment.

  We have added a footnote explaining this. . 

- line 471: the syntax for the where statement is missing a comma compared to
  the grammar shown on line 415.  This is a good place to mention that you
  should explicitly spell out your "indexing" scheme for the use of subscripts.

  We have made the indexing in our rules more explicit

- line 634: is the choice of left extension here important?  are you somehow
  indicating that you'll only substitute for the "rightmost" variable in the
  context somehow?

  Because weakening and exchange are both admissible, it doesn't really matter.  

  
- line 963: Your assertion that you only need to add the ability to get rid of a
  single, trivial where-block isn't completely obvious.  Maybe expand the
  explanation about why that is sufficient?

  TODO: Neel





- line 976: I agree that explaining the rule point-by-point is a good strategy,
  but you could also connect your explanation back to the example introduced
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

