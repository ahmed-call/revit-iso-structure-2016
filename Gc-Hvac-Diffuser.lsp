		
			 	  -: WELL COME GC HVAC WORLD:-


;   Convert angle in degrees to radians

(defun dtr (a)
     (* pi (/ a 180.0))
)
;   TO INSERT DIFFUSER

(defun C:D ()
(setq pt1 (getpoint "\nLOCATE ONE CORNER OF ROOM: " )) (setq 
pt2(getpoint"\nLOCATE OPOSITE CORNER OF ROOM: " ))(setq B1 (
getSTRING"\nDIFFUSER TO INSERT: ")) (setq N1 (getINT"\nNUMBER OF COLM: "))
(setq N2 (getINT"\nNUMBER OF ROWS: ")) (setq DIS 
( / (-(CAR PT2)(CAR PT1)) N1))(setq DES ( / (-(CADR PT2) (CADR PT1)) 
N2))   (setq DAS(IF (= 1 N2) DIS DES))(setQ PT3 (LIST (+ (CAR PT1) 
(/ DIS 2))(+ (CADR PT1) (/ DES 2))))(COMMAND"INSERT" B1 PT3 1 1 0)
(COMMAND"ARRAY" "L" "" "R" N2 N1 DAS DIS))


;  TO INSERT GRILLES

(defun C:GG ()
(setq B1 (getSTRING"\nGRILL TO INSERT: "))
(setq pt1 (getPOINT"\nLOCATION OF GRILLE: "))
(COMMAND "INSERT" B1 PT1 1 1 0))

                                
;			   -: THANKS AND WORK HARD :-
                                
