We thank the reviewers for their detailed and thoughtful comments. We address the main questions up front, and then answer the detailed questions afterwards.

# Main Questions

- What are the practical implications of this work for compiler writers?

  1. It enables us to show that SSA-based optimizations remain valid on modern computers. 

     Because we have a sound and complete characterization of the equations SSA-based languages must satisfy, we can characterize the properties any weak memory model viable for use in validating compiler optimizations must satisfy in a completely syntax-free way. That is, to show that  a model of weak memory is usable in an SSA-based compiler, it suffices to show that it has (for example) an Elgot monad structure. Once we have this, we know that all the generic transformations of SSA are sound, and we can use the model to add model-specific refinements/equations. 

     This is a genuinely nontrivial problem, because many published models of weak memory violate those assumptions! For example, the Pomsets with Preconditions model of Jagadeesan et al does not preserve associativity of semicolon, and in The Leaky Semicolon model of Jeffrey and Riely the program (if b then C1 else C2); C3 does not have the same semantics as (if b then C1; C3 else C2; C3), and in the Modular Relaxed Dependencies model of Batty and Paviottii, loop unrolling is not a meaning-preserving transformation. 

  2. The Cranelift compiler backend (used by multiple Webassembly runtimes, including Firefox’s WASM implementation) works by using e-graphs to maintain equivalence classes of expressions, and then uses a cost-based optimizer to pick out the most efficient representative of each class. This is currently limited to (roughly) pure expressions, but because our equational theory covers all of SSA, this makes it possible to extend e-graph based rewriting to include control-flow transformations (in the style of Peggy [Tate et al]). 


- What is exactly implemented in Lean? 

  * In Lean: 
  
    1. The type system of lambda-iter, its refinement theory, and the soundness of (directed) substitution are mechanized in Lean. 
    2. The categorical interpretation of lambda-iter, and the soundness of this interpretation (including both the soundness of substitution  and the soundness of the refinement relation) are mechanized in Lean. 
    3. Some, but not all, of the concrete models are proved to be Elgot monads in Lean. We have a stack of monad transformers for different effects, plus a proof they preserve the Elgot structure. We used this to show that languages with combined effects, such as undefined behaviour and sequential state, are models of our calculus. 
    4. Much of the completeness proof is in Lean, up to showing that the term model forms a poset-enriched category. 
  
  * On paper: 
  
    1. We show the term model has the structure of an Elgot category is on paper, which is the final part of the completeness proof.
    2. The equivalence of lambda-ssa and lambda-iter is proved on paper,  since it uses completeness. 
    3. We also have paper proofs that the Brookes-style models for concurrency, including ones for sequential consistency, total store order weak memory, and release/acquire weak memory, are all models of our calculus.
  
- Can you elaborate on the equipment business around l.723?

  The exponential modality in linear logic is a monoidal comonad, which essentially means that it functorially assigns a commutative comonoid structure to every type !A, to model contraction (the comultiplication) and weakening (the counit).

  Instead of doing that, we specify the comonoid structure on a type-by-type basis, to the extent it has it. So the type ℤ will be have both the counit (discard) and comultiplication (copy) maps, letting us freely duplicate and discard variables of this type. On the other hand, a type bearing ownership (such as a linear reference type) will not have either map, and must be used linearly. Yet other types (such as the seed for a random number generator) cannot be duplicated, but can be dropped. This lets us specify the linearity behaviour of each type directly, without having to go through the exponential. 

- Can you compare your quantity annotations to coeffects (from Tomas
  Petricek, Dominic Orchard, Alan Mycroft, Coeffects: a calculus of
  context-dependent computation)?

  There is little relationship between our quantity annotations and
  coeffects, beyond a common use of linear types. 

  Coeffects are best understood as a monoidal category equipped with a
  graded monoidal comonad instead of a general monoidal comonad. The
  annotations on the hypotheses in the type theory are drawn from the
  semiring indexing the graded comonad. As we describe above, our
  quantity annotations actually describe the extent to which each type
  has a specified comonoid structure.


- Can you provide more examples of validated optimizations?

  We want to be careful with terminology here. For a compiler writer, an optimization pass consist of a program analysis to learn facts about a program, followed by using those facts to select meaning-preserving rewrites on the program. 

  Our paper is focused on the second half of that: we are trying to fully characterize what the meaning-preserving rewrites are (hence the focus on the completeness of the equational theory). The rewrites performed by the usual standard data- and control-flow transformations (such as common subexpression elimination/global value numbering, constant and copy propagation, dead code elimination, sparse conditional constant propagation, and loop unrolling) are all shown to be sound generically, as part of the basic equational theory of our calculus. 

  In addition to this, if we know something about the specific model, we can extend the equational theory with model-specific rewrites. For example, all the models with state (including the concurrent ones) we have studied so far accept the refinements`store(p, a) ; load(p) → store(p, a) ; a` (load elimination), `store(p, a) ; store(p, b) → store(p, b)` (redundant store elimination), and `(load(p), load(p)) → let x = load(p) ; (x, x)`. These are the rewrites introduced by a mem2reg optimization pass, and are fundamentally why we need all of a refinement theory, linearity and an effect system in our language, because these transformations involve substituting *effectful* terms. 

  Furthermore, note that not all applications of SSA will have this kind of state, or these kinds of equations: the MLIR SSA framework is also used for things like optimizing quantum programs, and qbits work very differently from normal bits. 


# Detailed questions 

## Review A 

- On the other hand, the recipes for dealing with such languages, in particular for defining the denotational semantics are rather standard: Freyd categories, poset-enrichment, copy and discard morphisms.

We agree, but see this as a contribution of the work. We worked very hard to describe SSA in such a way that the standard tools all work on it, and believe this makes both formalization and will make further work (such as proofs about program analyses) easier. 

The presentation looks suboptimal to me. While, I essentially followed (on high level) the technical development related to $\lambda_{iter}$, it was hard to follow the general narrative of the work. I failed to locate explicit clear statements about mutual alignment between $\lambda_{iter}$ and $\lambda_{SSA}$, and what the authors exactly want to do with them, and how I should think about them. For me, the main contribution is $\lambda_{iter}$, as a further refinement of fine-grain call-by-value, and its theory, while $\lambda_{SSA}$ is sort of an application, to show that $\lambda_{iter}$ can model something that is close to something used in practice. 

- By the way, Geron and Levy's "Iteration and Labelled Iteration", I believe, is a relevant related work, as it also considers alternative syntax for iteration though labels, line $\lambda_{SSA}$.

Thank you! We will cite this. 

- I am not quite convinced with the semantic treatment of quantity annotations. Normally, one involves genuinely semantic structures like linear logic "!" and the corresponding adjunction to interpret it (I mean, like in Benton's "A Mixed Linear and Non-Linear Logic: Proofs, Terms and Models"). I did not get how "equipping" types with copying/discard morphisms works (see my comment below).

See above. 


- l.134,142: Fig 2 is mentioned before Fig.1 -- maybe swap them then?

Yes, that's a good idea. 

- l.174: what is "A" and what is curly "l"?

Capital L is the metasyntax for a context of declarations for basic blocks with arguments. Curly l is the name of a label, and A is the type of its argument. There is no return type for a block, because every block ends in a jump. 

- l.213: "but we later prove in Subsection 5.3 that the two syntaxes are completely equivalent" -- I do not see why wait until 5.3. It is just two languages -- one can explain the equivalence much  earlier. This would help to motivate/understand the rest. I should,  at least.

Our proof of equivalence exploits the proof of completeness, so it's hard to describe it formally before 5.3. However, we can explain the equivalence informally. 

- l.220: so, who is "a functional analogue of While"?

We mean the While-loop language, the primitive imperative language with while loops, conditionals, and sequencing. We will clarify. 

- l.249: a chart depicting the (semi-)lattice structure will help.

We will add this. 

- l.267: the judgments involve 3 faces of "q": italic, bold and serif. This turns them into riddles.

We will clarify this. 

- l.333: previously you already used Q for {1, 1?, 𝜔 +, 𝜔 }.

q(X) is a function taking base types to their associated quantify. In other words, q has the type $\mathcal{X} → Q$.  

- l.360: the language is first-order, so I find if very confusing to use $\lambda$ in the name, as this very suggestively refers to the $\lambda$-calculus.

We think of this language as a functional analogue to the first-order imperative while language. If you have another suggestion for the name, we are happy to change it. 

- l.423: "means 𝑎 is refined by 𝑏" -- please, introduce 𝑎 and 𝑏 properly? What happened to the effect index at the turnstile?

a and b are ordinary terms, defined in Figure 4. The refinement relation is effect-independent, so it does not need an effect annotation. 

- l.633: Is it a new theorem? Say it please. If not, please, cite, where it comes from. Overall, please, appropriately credit results and notions from elsewhere, and be explicit about your own.

No, this is one of the results in Power and Robinson. We will add a citation.  

- l.811: "relevant, a diagonal morphism" -- this is the shakiest place in this semantic model to me. What means "relevant" for a type? The quantity annotations only occur in context, not for all types. And then, [[X]] can be the same for different annotation, so what means "equipping"?

As part of the definition of a λ-iter signature, for each type X we have a q(X) ∈ Q which is its quantity (see section 3.1.1 for more details). A type is relevant if q(X) ≥ ω+, and discardable if q(X) ≥ 0.  In definition 4.11, note that on lines 819-824, we give the equations that the copy and discard morphisms have to satisfy, and that if a type is both relevant and discardable the copy and discard morphisms form a commutative comonoid, exactly as expected for linear logic. 

- l.875: I did not get this lemma. What means [[-]] for derivations?

The interpretation in Figure 13 is defined on typing derivations, not on syntax. In principle, there might be two different derivation trees showing that $Γ^q \vdash_\epsilon a : A$. As a result we have to prove coherence: that regardless of which derivation is chosen, we get the same meaning. 

- l.945: The proof of the theorem, if fully written, can be quite intricate. For example, in appendix, you say "this is well-defined since, by definition, we quotient precisely the equivalence class". It is not automatically well-defined, because one has to show that the definition does not depend on the choice of f and g from the equivalence class.

You are correct. We have proven that this is well-defined in Lean, as part of the proof that the term model forms a poset-enriched category. Specifically we show that if f refines g, then every member of f's equivalence class refines every member of g's equivalence class. 



## Review B 


- 26, Explain what "substitution is then a valid program transformation" means, and why this is important.

When variables are mutable, they can have different values at different program points, and as a result substitution is in general an invalid transformation. 


- 88, In the list of contributions, it would be useful to include links to the relevant sections of the paper.

We will make this change in the final version. 


- 107, Explain who the paper is targeted at, e.g. what kind of knowledge and experience is required.

We will add a description of the prerequisites to the end of section 1. 

- 134, Some further explanation for the particular choice of language in Figure 2 is required.  For example, why are regions used rather than basic blocks and control flow graphs?

Properties like substitution are much easier to formulate when scoping is lexical rather than dominance-based. Our notation for regions makes the dominance tree explicit in the syntax, and as a consequence it makes dominance-based scoping and lexical scoping one and the same. As a result we can now use standard techniques to interpret the syntax of the language. 

- 527, Why use a categorical semantics rather than some other approach?  This seems a key part of the work, so the rationale for this choice needs to be clearly explained and justified.

The categorical semantics packages up all the properties we need to interpret the SSA syntax, without ever explicitly referring to the syntax. As a result, we can prove if a model for weak memory is a valid model for use in a SSA-based IR, without having to look at the details of the syntax. 


- 1182, The paper contains 23 figures, which is a lot.  It also means the reader needs to constantly flick back and forward between the narrative and the figures when reading the paper. The flow would be improved by inlining many of the figures.

We will do this in the final version. 

- 1188, The related work section is rather brief, and would benefit from being expanded.  A discussion of possible directions for further work is also required.

We will buy extra pages to expand the related and future work. 


## Review C

- That said, the paper has fairly limited examples validated by the theory.

We were very space constrained, but will buy additional pages to expand the examples in the final version. 


- It's essentially left to the reader to imagine the practical applications of the work or how it would be integrated into existing systems for mechanically reasoning about compiler transformations.

We will add some discussion of this to the final version.