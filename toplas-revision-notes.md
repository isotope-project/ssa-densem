1. Cleanup 

  * Fix all the minor issues the reviewers identified. [DONE]
  * ETA: 31 July 

2. Expand the introduction

   Here are the questions we need to answer:

   1. Articulate the problem. [DONE]
   2. Explain the state of the art, and why it does not solve the problem. 
      + SSA is the most widely used compiler IR
      + Giving it a semantics is a nuisance (eg, phi-functions are a PITA)	
      - Using the semantics you make up is very, very painful (Vellvm example) 
      - The reason is that we do not have a good equational theory for SSA as a language.
      - This has more bad side-effects
      - Modern computers have weak memory
      - We do not know which SSA equations should remain under weak memory 
      - We do not know how to cleanly integrate weak memory semantics and SSA semantics. 
      	The state of the art is using a free monad for the memory actions, but many weak memory
	models do not actually form a monad, and if-then-else and associativity of semicolon
	can and do break. Furthemore, almost no weak memory models say what should happen in the 
	presence of loops, because they are litmus-test focused. (So soundness of loop unrolling 
	is not known!)

   3. Concretely, what do we do?

      - We give a type system and equational theory for λSSA. 
      - We prove the soundness of syntactic substitution for this language. 
      - We prove that there are equational translations between regular SSA and λSSA. 
      - We give a categorical axiomatization of this language using distributive Freyd categories
      	with Elgot structure. 
      - We show that λSSA can be soundly interpreted into this categorical structure, including
      	the soundness of the equational theory and a proof that subsitution is composition. 
      - We show that our equational theory is complete, by proving that the syntactic model 
      	is the initial model. 
      - We give a number of concrete models, including some for weak memory. This demonstrates 
      	that standard sequential SSA optimizations like loop unrolling remain valid in the 
	presence of weak memory. 

   4. Of what we did, what is new, and what is an application of known results?

      - Freyd categories and Elgot structure are categorical machinery known from the literature. 
      - As far as we know, a type system + equational theory complete for this structure 
      	is novel, so therefore the initiality proof is novel. (Goncharov gives a syntax but
	no equational theory.) 
      - The observation that this structure corresponds to SSA is also completely new. 
      - Many of our weak memory models (eg, TSO) had to be extended slightly to prove they 
      	form an Elgot monad. This amounts to a proof that weak memory and loops play nice 
	together. This is also new. 

   5. How does what we did actually solve the problem? 
      (a) from a theorist's perspective?

      	  - We have related SSA to standard models of iterative computation from the 
	    literature. This enables us to do stuff like extend weak memory to loops 
	    in a syntax-free way. 

      (b) from a practitioner's perspective? 

          - Completeness means we have enumerated -all- of the equations that must hold 
	    for SSA. No weak memory model which breaks any of these can be used 
	    for an SSA-based compiler. 
          - Cranelift uses e-graphs for rewriting pure expressions. Peggy proposed doing
	    the same thing for control-flow graphs. We believe our semantics can be used to 
	    justify this for SSA as well. 


   6. Enumerate the contributions, and outline the paper. 


   - What are the technical contributions, relative to the related work?
   - What's the connection between memory models and our SSA model?
   - What are the applications of the results, including completeness?







   - Extend the introduction to more clearly lay out what the technical
     contributions of this work are, as much of it builds on well-known
     ideas such as SSA-functional correspondence and semantics in Freyd
     categories.

   - Line 55-57: ...memory models could be validated by seeing if they
     satisfy the equations of SSA...: How do we know if this is a useful
     criterion? Does it rule out any known bad models?

   - Line 63-65: "We show that any denotational model with this categorical
     structure is also a model of SSA" not sure what the distinction
     between "denotational model" and "model of SSA" is here, it seems
q     redundant

   - Line 66-70: there don't seem to be any applications of a completeness
     result given, only of the soundness. Is there any significance of this
     result for compiler writers?  Usually it would be used to provide
     semantic proof techniques for meta-theoretic properties.

   - Line 75-79: this summary is unclear/confusing. What is a "proof of
     substitution"? How can you prove something forms an initial model
     without defining denotational semantics? What is "soundness of
     substitution"?

   - Is the model in 6.3 actually interesting from a memory model POV? Does
     SSA even manipulate memory?

   - The introduction of the paper is very short and doesn't give an
     overview of many of the technical developments. This makes the paper
     difficult to read as entire sections are self-contained asides that
     don't seem to contribute to the goals laid out in the Introduction.



3. Change the description of SSA to make narrative sense to the reviewers (mostly section 2)

   - First, introduce standard SSA. 
   - Then, introduce where blocks to show that making the dominator tree creates
     lexical scoping. 
   - Observe that this is ANF + letrec. Call this functional SSA. 
   - Give the typing rules for functional SSA. 
     Explain stuff like the L target judgement here. 
   - Next, explain that we are going to define a superset of functional SSA to
     make formulating its equational theory easier. Maybe be a little less down on ANF. 
   - Then, explain that we will show that the superset is equivalent to the 
     original formulation of SSA, and has exactly the same expressive power.

4. λssa (section 3 and 4) 

   - simplify the effect system to pure and impure only (eventually we can stick with normal Freyd categories)

     * relate this to SSA-isms (expressions in global value numbering have to be pure)
     * Give examples of instructions (eg, addition, division, memory, etc)

   - Frontload the statement of the theorems establishing a relationship between SSA and λssa. 

   - move obvious technical stuff (like ANF translation) to the appendix. 

   - Some more narrative about the equational theory: 
     * what is it for (directly specify equivalence without the indirection of an 
       operational semantics + contextual equivalence, and also makes validating semantic models easier and/or harder)
     * what good is it? Both mathematically and hackerly (eg, once we have it, we don't need to work in the model, which
       a compiler can't anyway)

   - more narrative: Bohm-Jacopini theorem? 
     * Move more of the technical detail to the appendix. 
     * Emphasize that this is a purely equational proof, which shows off the equational theory. 

5. Semantics 
   - Primer of category theory 
   - More citations to the literature
   - What is "new"? 
     * The categorical structures we use are a combination of well-known parts 
     * The novelty is that 
       a. we give a sound and complete calculus + equational theory for this structure
       b. that calculus is already widely-used in industrial practice: SSA!
       c. Identifying the connection enables new things like proving SSA + weak memory is safe 
   - Put this in the intro as well 

6. Fix related work 

   - as per comments 

n. Lean formalization stuff
   - Actually say what's formalized in Lean, and what's not formalized. 
   - Give a link to the Github/zenodo repo 
