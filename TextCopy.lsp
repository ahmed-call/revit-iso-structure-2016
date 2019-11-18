;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     Written by Munir Hussain  munir7259@yahoo.com          September 2013
;;;     Engineeringgraphics Auto Lisp enggraphics786@gmail.com
;;; This program to match one string of text to another
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;============================================================================
(defun C:K (/ l1 lll1 ll1 lin1 line1 l2 lll2 ll2 line2 med1 med2)
   (setq l1 (nentsel "\nSelect Line of text to match to: "))
   (if (= l1 nil)(exit))
   (setq lll1 (car l1))
   (redraw lll1 3)
   (setq ll1 (entget (car l1)))
   (setq lin1 (cdr (assoc 0 ll1))) 
   (setq line1 (cdr (assoc 1 ll1)))
   (if (= line1 nil)(exit))
(while
     (setq l2 (nentsel "\nSelect  Line(s) of tex to be  matched<enter when done>: "))
     (setq lll2 (car l2))
     (redraw lll2 3)
     (setq ll2 (entget (car l2)))
     (setq lin2 (cdr (assoc 0 ll2)))
     (setq line2 (cdr (assoc 1 ll2)))
     (if (= line2 nil)(progn(redraw lll1 4) (exit)))

      (setq med2 ll2)
      (setq med2 
                (subst (cons 1 line1)
                       (assoc 1 med2)
                       med2
                )
      )
      (entmod med2)
(if
  (or
     (= lin1 "ATTRIB")
     (= lin2 "ATTRIB")
 )
 (command "regenall")
)
)
(redraw lll1 4)
(princ)
)