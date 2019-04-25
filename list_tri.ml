(* module list tri *)

(* Tri partition-fusion *)
(* 1. *)
let rec partitionne_bis l rang l1 l2 =
match l with
[] -> (l1,l2)
|x::r -> if rang mod 2 == 0 
         then partitionne_bis r (rang+1) (x::l1) l2
         else partitionne_bis r (rang+1) l1 (x::l2) ;;

let partitionne l = 
match l with
[] -> ([],[])
|x::r -> partitionne_bis l 0 [] [] ;;


(* 2. *)
let rec fusionne_bis comp lc =
match lc with
([], []) -> []
|([],a::b) -> a::b
|(x::r,[]) -> x::r
|(x::r, a::b) -> if comp x a then x::(fusionne_bis comp (r, a::b))
                 else a::(fusionne_bis comp (x::r,b)) ;;

let fusionne comp l1 l2 = fusionne_bis comp (l1,l2) ;;

(* 3. *)
let rec tri_partition_fusion comp l =
if l = []
then []
else let (l1, l2) = partitionne l in
     if l1 = [] && l2 =[]
     then []
     else if (List.length l1 <= 1) && (List.length l2 <= 1)
          then fusionne comp l1 l2
          else fusionne comp (tri_partition_fusion comp l1) (tri_partition_fusion comp l2) ;;

(* Tri pivot *)

(* 1. *)

let rec partitionne_pivot_bis comp l pivot l1 l2 =
match l with
[] -> (l1,l2)
|x::r -> if (comp x pivot)
         then partitionne_pivot_bis comp r pivot (x::l1) l2
         else partitionne_pivot_bis comp r pivot l1 (x::l2) 

let partitionne_pivot comp l pivot =
match l with 
[] -> ([],[]) 
|x::r -> partitionne_pivot_bis comp l pivot [] [] ;;

(*
 let list = random_list 100 20 ;;
 *)

partitionne_pivot (>) [4;2;6;1;1;3;9;5] 6 ;;


(* 2. *)

let rec tri_pivot comp l =
if l = []
then []
else let pivot = (List.hd l) in
     let (l1,l2) = partitionne_pivot comp (List.tl l) pivot in
     if l1 =[] && l2 =[]
     then pivot::[]
     else if l1 = [] && l2 <> [] 
          then ((List.hd l) :: []) @ (tri_pivot comp l2)
          else if l1<>[] && l2 = []
               then (tri_pivot comp l1) @ ((List.hd l) :: [])
               else (tri_pivot comp l1) @ ((List.hd l) :: [])@(tri_pivot comp l2) ;;

let list = random_list 50 20 ;;

tri_pivot (>) list ;;



























































































