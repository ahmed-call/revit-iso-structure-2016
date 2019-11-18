; This program help you to draw Duct Shoo Branch 
; Created my Munir Hussain On 26-12-04
(DEFUN C:shoo1()
(defun dtr (deg) (/ (* pi deg) 180))
(defun rtd (deg) (/ (* 180.0 deg) pi))  
(setq osp (getvar"osmode"))
(setvar"osmode" 2)  
(SETQ p1 (getpoint"\nPick Mid & end of Diffuser : "))
(setvar"osmode" 128) 
(SETQ p2 (getpoint p1 "\nPick a point on Main Duct : "))
(setvar"osmode" 0) 
(setq an (angle p2 p1))

(if (= wd nil) (setq wd 300))
(princ "\nEnter Duct width size < ")
(princ wd)
(princ " >")
(setq w (getreal))
(if (= w nil) (setq w wd))
(setq wd (fix w))
(if (= de nil) (setq de 100))
(princ "\nEnter Duct end size < ")
(princ de)
(princ " >")
(setq dend (getreal))
(if (= dend nil) (setq dend de))
(setq de (fix dend))
  
(setq p3 (polar p1 an dend)  
      p4 (polar p3 (+ an (dtr 90)) (* 0.5 w))
      p5 (polar p3 (- an (dtr 90)) (* 0.5 w))
      p6 (polar p5 (+ an (dtr 180)) (+ (distance p1 p2) (- dend 100)))
      p7 (polar p6 (+ an (dtr 90)) w)
      p8 (polar p6 (+ an (dtr 180)) 100)
      p9 (polar p8 (- an (dtr 90)) 100)
     p10 (polar p4 (+ an (dtr 180)) (+ (distance p1 p2) dend))
     p11 (polar p10 (+ an (dtr 90)) 100)
)     
(command "_line" p4 p5 p6 p7 p4 "")

(setq pt (getpoint"\nShow Shoo direction Side >> "))

(setq d1 (distance pt p6))
(setq d2 (distance pt p7))  

(if (> d1 d2) (progn   
(command "_line" p6 p8 "")
(command "_line" p7 p11"")  
))

(if (< d1 d2) (progn  
(command "_line" p6 p9 "")  
(command "_line" p7 p10 "")
))

(setvar"osmode" osp)  
)