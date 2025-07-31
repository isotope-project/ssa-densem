1. Cleanup 

  * Fix all the minor issues the reviewers identified. 
  * ETA: 31 July 

2. Expand the introduction 

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
