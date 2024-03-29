(DEFUN C:R1     ()   (COMMAND "ROTATE" PAUSE "" "@" "90"))
(DEFUN C:R2     ()   (COMMAND "ROTATE" PAUSE "" "@" "180"))
(DEFUN C:R3     ()   (COMMAND "ROTATE" PAUSE "" "@" "270"))

(DEFUN C:25     ()   (COMMAND "OFFSET" "@" "25"))
(DEFUN C:50     ()   (COMMAND "OFFSET" "@" "50"))
(DEFUN C:75     ()   (COMMAND "OFFSET" "@" "75"))
(DEFUN C:O1     ()   (COMMAND "OFFSET" "@" "100"))
(DEFUN C:125    ()   (COMMAND "OFFSET" "@" "125"))
(DEFUN C:150    ()   (COMMAND "OFFSET" "@" "150"))
(DEFUN C:175    ()   (COMMAND "OFFSET" "@" "175"))
(DEFUN C:O2     ()   (COMMAND "OFFSET" "@" "200"))
(DEFUN C:225    ()   (COMMAND "OFFSET" "@" "225"))
(DEFUN C:250    ()   (COMMAND "OFFSET" "@" "250"))
(DEFUN C:O1     ()   (COMMAND "OFFSET" "@" "275"))
(DEFUN C:O3     ()   (COMMAND "OFFSET" "@" "300"))
(DEFUN C:O4     ()   (COMMAND "OFFSET" "@" "400"))
(DEFUN C:O5     ()   (COMMAND "OFFSET" "@" "500"))
(DEFUN C:O6     ()   (COMMAND "OFFSET" "@" "600"))
(DEFUN C:O7     ()   (COMMAND "OFFSET" "@" "700"))
(DEFUN C:O8     ()   (COMMAND "OFFSET" "@" "800"))
(DEFUN C:O9     ()   (COMMAND "OFFSET" "@" "900"))
(DEFUN C:O10    ()   (COMMAND "OFFSET" "@" "1000"))

(DEFUN C:F6     ()   (COMMAND "MEASURE" PAUSE "B" "F6" "Y" "80" PAUSE ))
(DEFUN C:F8     ()   (COMMAND "MEASURE" PAUSE "B" "F8" "Y" "40" PAUSE ))
(DEFUN C:F10    ()   (COMMAND "MEASURE" PAUSE "B" "F10" "Y" "40" PAUSE ))
(DEFUN C:F12    ()   (COMMAND "MEASURE" PAUSE "B" "F12" "Y" "40" PAUSE ))

(DEFUN C:ZZ     ()   (COMMAND "ZOOM"  "P" ))
(DEFUN C:FF     ()   (COMMAND "FILLET"  "R" "0" "FILLET" ))
(DEFUN C:FI     ()   (COMMAND "FILLET"  "R" "150" "FILLET" ))
(DEFUN C:FII     ()   (COMMAND "FILLET"  "R" "100" "FILLET" ))
(DEFUN C:FR     ()   (COMMAND "FILLET"  "R" PAUSE "" "FILLET" ))
(DEFUN C:BK     ()   (COMMAND "BREAK" PAUSE "NEA" "@"))
(DEFUN C:J      ()   (COMMAND "PEDIT" PAUSE "" "J" ))

(DEFUN C:H2     ()   (COMMAND "CHPROP" PAUSE "" "LT" "HIDDEN2" ))
(DEFUN C:HH     ()   (COMMAND "CHPROP" PAUSE "" "LT" "HIDDEN" ))
(DEFUN C:AB     ()   (COMMAND "insert" "ASBUILT" PAUSE "1"   PAUSE))
(DEFUN C:PP     ()   (COMMAND "insert" "PAPER" PAUSE "1" "1" "" "explode" "l"))
(DEFUN C:AR     ()   (COMMAND "insert" "AERO" PAUSE "1"   PAUSE))

(DEFUN C:SLOPE  ()   (COMMAND "LINE" PAUSE PAUSE "" "DIVIDE" PAUSE "B" "ARO" "Y" PAUSE))
(DEFUN C:SC2    ()   (COMMAND "SCALE" PAUSE "0.5" ))
(DEFUN C:FL     ()   (COMMAND "FILLET" "R" "150" "FILLET"  "L" "O"))
(DEFUN C:AU     ()   (COMMAND "AUDIT"  "Y" ))

(defun c:jt()
(setq ftxt (entsel))
(setq stxt (entsel))
(setq ent (entget (car ftxt)))
(setq txt2 (strcat (cdr (assoc 1 ent)) " " (cdr (assoc 1 (entget (car stxt))))))
(setq txt (cons 1 txt2))
(setq ent (subst txt (assoc 1 ent) ent))
(command "erase" stxt "")
(entmod ent)(princ))


(defun c:BXx ()
  (command "-xref" "r" "*")
  (command "-xref" "b" "*" )
  (command "purge" "all" "" "N")
  (command "purge" "all" "" "N")
  (command "purge" "all" "" "N")
  (command "purge" "all" "" "N")
  (command "qsave" "")
  (command "CLOSE" "Y")

(defun c:CT()
(setq Stxt (entsel))
(setq Ftxt (entsel))
(setq ent (entget (car ftxt)))
(setq txt2 (cdr (assoc 1 (entget (car stxt)))))
(setq txt (cons 1 txt2))
(setq ent (subst txt (assoc 1 ent) ent))
(entmod ent)(princ))

(defun c:ARCH()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "LA" "ARCH" ""))
(defun c:DRNG()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "LA" "DRNG" ""))
(defun c:CHWP()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "LA" "CHWP" ""))
(defun c:ACDUCT()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "LA" "ACDUCT" ""))
(defun c:TEXTLAY()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "LA" "TEXT" ""))
(defun c:DIMLAY()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "LA" "DIM" ""))
(defun c:FURNLAY()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "LA" "FURN" ""))
(defun c:SC3()
	(setq x1 (ssget))
	(command "SCALE" x1 PAUSE "1.5" ""))
(defun c:1()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "1" ""))
(defun c:2()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "2" ""))
(defun c:3()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "3" ""))
(defun c:4()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "4" ""))
(defun c:5()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "5" ""))
(defun c:6()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "6" ""))
(defun c:7()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "7" ""))
(defun c:8()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "8" ""))
(defun c:9()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "9" ""))
(defun c:10()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "10" ""))
(defun c:11()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "11" ""))
(defun c:12()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "12" ""))
(defun c:13()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "13" ""))
(defun c:14()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "14" ""))
(defun c:15()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "15" ""))
(defun c:16()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "16" ""))
(defun c:17()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "17" ""))
(defun c:30()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "30" ""))
(defun c:31()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "31" ""))
(defun c:100()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "100" ""))
(defun c:101()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "101" ""))
(defun c:102()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "102" ""))

(defun c:103()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "103" ""))

(defun c:104()
	(setq x1 (ssget))
	(command "change" x1 "" "p" "c" "140" ""))

(defun rottxt_err (s)
   (if (/= s "Function cancelled")
       (princ (strcat "\nError: " s))
   ) 
   (setq *error* old_error)
   (princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun rot ()
   (setq leng (sslength txt_set)
         n 0
   )
   (while (/= n leng)
          (setq ent (entget (ssname txt_set n))
                n (1+ n)
                ent (subst (cons 50 ang)
                           (assoc 50 ent)
                           ent
                    )
          )
          (entmod ent)
   )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun chk ()
   (cond ((= ent nil)
          (princ "\nNothing found there.\nSelect a \"LINE\" to align. ")
          (setq ent (entsel))
          (chk)
         )
         ((/= (cdr (assoc 0 (entget (car ent)))) "LINE")
          (princ "\nNo \"LINE\" found there.\nSelect a \"LINE\" to align. ")
          (setq ent (entsel))
          (chk)
         )
   )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun rottxt ()
   (princ "\nSelect a \"LINE\" to align. ")
   (setq ent (entsel))
   (chk)
   (setq ang (angle (cdr (assoc 10 (entget (car ent))))
                    (cdr (assoc 11 (entget (car ent))))
             )
   )
   (rot)
)
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun c:rottxt ()
   (setq old_error *error*
         *error* rottxt_err
   )
   (princ "\nSelect TEXT to rotate. ")
   (setq txt_set (ssget '((0 . "TEXT"))))
   (if txt_set
       (rottxt)
       (alert "No \"TEXT\" found.")
   )
   (setq *error* old_error
         old_error nil
         txt_set nil
         leng nil
         ent nil
         ang nil
         ans nil
         n nil
   )
   (princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

