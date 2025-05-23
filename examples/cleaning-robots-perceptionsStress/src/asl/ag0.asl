// Agent developed for stressing the quantity of critical beliefs (18/Jan/2024)

/* Initial beliefs */
belA.
belB.
at(P) :- pos(P,X,Y) & pos(r1,X,Y).

/* Initial goal */
!start. 

+!start : true <- !check(slots). 
//+!start : true <- .stopMAS(17000); !check(slots).

//!check(slots).

+theEnd(_) : true 
   <- .stopMAS.

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


/* Critical Plans */
+cb0 [cr]: belA & belB <- critReac(0). 
+cb1 [cr]: belA & belB <- critReac(1).

/* Regular Plans needed for supporting Critical Reactions*/
+cr0Per(_) : belA & belB <- critReac(0). 
+cr1Per(_) : belA & belB <- critReac(1).

/* Dummy perception Plans */
+fakeP(K) : true <- .drop_desire(gold(K,Y)). 
