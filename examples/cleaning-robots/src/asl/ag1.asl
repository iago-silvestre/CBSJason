// mars robot 1

/* Initial beliefs */
nope.
belA.
at(P) :- pos(P,X,Y) & pos(r1,X,Y).

/* Initial goal */
!start. 
//!getBusy.

//+!getBusy : true <- for ( .range(I,0,22) ) { // creates 22 concurrent intentions for g
//         !!go(999); 
//      };
//      !start.

//+!go(0).
//+!go(X) <- !go(X-1).

+!start : true <- !check(slots). 
//+!start : true <- .stopMAS(17000); !check(slots).

//!check(slots).

/* Plans */
+cb0 [cr]: true <- critReac0.
+cb0 [cr] <- critReac1.
//+any1 [cr]: whatever.
//+any2 [cr]: bel1 & bel2 <- whatever.

+theEnd(_) : true 
   <- .stopMAS.

//+!check(slots) : not garbage(r1)
//   <- next(slot);
//      !check(slots).
//+!check(slots).      

+!check(slots) : not garbage(r1)
   <- next(slot);
      !check(slots).
+!check(slots).      

//@lg[atomic]
+garbage(r1) : not .desire(carry_to(r2))
   <- !carry_to(r2).

+!carry_to(R)
   <- .drop_desire(check(slots)); // stop checking
      
      // remember where to go back
      ?pos(r1,X,Y);
      -+pos(last,X,Y);

      // carry garbage to r2
      !take(garb,R);

      // goes back and continue to check
      !at(last);
      !!check(slots).

+!take(S,L) : true
   <- !ensure_pick(S);
      !at(L);
      drop(S).

+!ensure_pick(S) : garbage(r1)
   <- pick(garb);
      !ensure_pick(S).
+!ensure_pick(_).

+!at(L) : at(L).
+!at(L) <- ?pos(L,X,Y);
           move_towards(X,Y);
           !at(L).

+garbage(r2) : true <- burn(garb).

//+cb0 : true <- critReac0. 

+cr0Per(_) : true <- critReac0. 

+fakeP(K) : true <- .drop_desire(gold(K,Y)). 
