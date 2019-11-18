(defun c:neck (/ mlin brl1 brl2 inter int_r2 dut_dst ml_anrad ml_an ml_antm
               br_an br_antm br_anrad pt_1 pt_2 pt_3 user ml_sp ml_ep
               br_sp1 br_ep1 br_sp2 br_ep2) 
(setvar "cmdecho" 0)
(command "undo" "g")
(setq osmd (getvar "osmode")) 
(setvar "osmode" 0)
(setq clay (getvar "clayer"))
(setq orig-err *error* *error* ins-err)
(setq mlin (entget (car (entsel "\nSelect Main duct line [ which side you have branch] : "))) 
      brl1 (entget (car (entsel "\nSelect Branch duct 1st line [ Neck chamfer side] : ")))
      brl2 (entget (car (entsel "\nSelect Branch duct 2nd line : ")))  
      br_sp1 (cdr (assoc 10 brl1)) br_ep1 (cdr (assoc 11 brl1))
      br_sp2 (cdr (assoc 10 brl2)) br_ep2 (cdr (assoc 11 brl2))
      ml_sp (cdr (assoc 10 mlin)) ml_ep (cdr (assoc 11 mlin))
      inter (inters br_sp1 br_ep1 ml_sp ml_ep nil)
      int_r2 (inters br_sp2 br_ep2 ml_sp ml_ep nil)
      dut_dst (distance inter int_r2)  ) 
      

(setq ml_lay (cdr (assoc 8 mlin)))

(setvar "blipmode" 1) 
(command "line" inter "") 
(setvar "blipmode" 0)
(initget 0 " ? LT lt LB lb Rt rt RB rb TR tr TL tl BR br BL bl ? ")
(setq user (getkword "\nEnter Neck Chamfer side LT/LB/RT/RB/BL/BR/TL/TR/<?> : "))
     
(if (= user "?")
    (progn
     (command "vslide" "f:/acadwin/neck.sld")   
     (initget 0 " LT lt LB lb RT rt RB rb TR tr TL tl BR br BL bl ")
     (setq user (getkword "\nEnter Neck Chamfer side LT/LB/RT/RB/BL/BR/TL/TR : "))
     (redraw)
))     

;//////////////Bottom Right////////////////
(if 
    (or (= user "BR") (= user "br"))
(progn

(setq ml_an (* 180 (/ (angle ml_sp ml_ep) pi)))
      (if (<= ml_an 180)
          (progn (setq ml_antm (+ ml_an 180.0)  
                       ml_anrad (* pi (/ ml_antm 180.0)))  )  
      
      (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  ))  
          
       ;**********************************************

(setq br_an (* 180 (/ (angle br_sp1 br_ep1) pi)))
      (if (> br_an 180)
          (progn (setq br_antm (- br_an 180.0)  
                       br_anrad (* pi (/ br_antm 180.0)))  )  
          
      (progn (setq br_anrad (* pi (/ br_an 180.0)))  ))  
))

;/////////////Bottom Left///////////////////////////
  (if
    (or (= user "BL") (= user "bl"))
(progn

(setq ml_an (* 180 (/ (angle ml_sp ml_ep) pi)))
      (if (< ml_an 180)
          (progn (setq ml_antm (+ ml_an 180.0)  
                       ml_anrad (* pi (/ ml_antm 180.0)))  )  
      
      (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  ))  
       
       ;**********************************************

(setq br_an (* 180 (/ (angle br_sp1 br_ep1) pi)))
      (if (>= br_an 180)
          (progn (setq br_anrad (* pi (/ br_an 180.0)))  )  
          
          (progn (setq br_antm (+ 180.0 br_an )  
                       br_anrad (* pi (/ br_antm 180.0)))  ))  
          
))
;////////////Top Right/////////////////////////
(if 
    (or (= user "TR") (= user "tr"))
(progn

(setq ml_an (* 180 (/ (angle ml_sp ml_ep) pi)))
      (if (<= ml_an 180)
          (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  )  

          (progn (setq ml_antm (- ml_an 180.0)  
                       ml_anrad (* pi (/ ml_antm 180.0)))  ))  
          
       ;**********************************************

(setq br_an (* 180 (/ (angle br_sp1 br_ep1) pi)))
      (if (> br_an 180)
          (progn (setq br_antm (- br_an 180.0)  
                       br_anrad (* pi (/ br_antm 180.0)))  )  
          
      (progn (setq br_anrad (* pi (/ br_an 180.0)))  ))  
))

;////////////Top Left//////////////////////////////
  (if
    (or (= user "TL") (= user "tl"))
(progn

(setq ml_an (* 180 (/ (angle ml_sp ml_ep) pi)))
      (if (< ml_an 180)
          (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  )  

          (progn (setq ml_antm (- ml_an 180.0)  
                       ml_anrad (* pi (/ ml_antm 180.0)))  ))  
       
       ;**********************************************

(setq br_an (* 180 (/ (angle br_sp1 br_ep1) pi)))
      (if (>= br_an 180)
          (progn (setq br_anrad (* pi (/ br_an 180.0)))  )  
          
          (progn (setq br_antm (+ 180.0 br_an )  
                       br_anrad (* pi (/ br_antm 180.0)))  ))  

))

;///////////////Right TOP/////////////////
(if 
    (or (= user "RT") (= user "rt"))
(progn

(setq ml_an (* 180 (/ (angle ml_sp ml_ep) pi)))
      (if (< ml_an 180)
          (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  )  

          (progn (setq ml_antm (- ml_an 180.0)  
                       ml_anrad (* pi (/ ml_antm 180.0)))  ))  
       
       ;**********************************************

(setq br_an (* 180 (/ (angle br_sp1 br_ep1) pi)))
      (if (> br_an 180)
          (progn (setq br_antm (- br_an 180.0)  
                       br_anrad (* pi (/ br_antm 180.0)))  )  
          
      (progn (setq br_anrad (* pi (/ br_an 180.0)))  ))  
))

;/////////////////Right Bottom/////////////////////
  (if
    (or (= user "RB") (= user "rb"))
(progn

(setq ml_an (* 180 (/ (angle ml_sp ml_ep) pi)))
      (if (< ml_an 180)
          (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  )  

          (progn (setq ml_antm (- ml_an 180.0)  
                       ml_anrad (* pi (/ ml_antm 180.0)))  ))  
       
       ;**********************************************

(setq br_an (* 180 (/ (angle br_sp1 br_ep1) pi)))
      (if (>= br_an 180)
          (progn (setq br_anrad (* pi (/ br_an 180.0)))  )  
          
          (progn (setq br_antm (+ 180.0 br_an )  
                       br_anrad (* pi (/ br_antm 180.0)))  ))  

))

;////////////////////Left Top//////////////////////
(if 
    (or (= user "LT") (= user "lt"))
(progn

(setq ml_an (* 180 (/ (angle ml_sp ml_ep) pi)))
      (if (< ml_an 180)
          (progn (setq ml_antm (+ ml_an 180.0)  
                       ml_anrad (* pi (/ ml_antm 180.0)))  )  
          
          (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  ))  

       ;**********************************************

(setq br_an (* 180 (/ (angle br_sp1 br_ep1) pi)))
      (if (> br_an 180)
          (progn (setq br_antm (- br_an 180.0)  
                       br_anrad (* pi (/ br_antm 180.0)))  )  
          
      (progn (setq br_anrad (* pi (/ br_an 180.0)))  ))  
))

;///////////////////Left Bottom//////////////////////
  (if
    (or (= user "LB") (= user "lb"))
(progn

(setq ml_an (* 180 (/ (angle ml_sp ml_ep) pi)))
      (if (< ml_an 180)
         ; (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  )  

          (progn (setq ml_antm (+ ml_an 180.0)  
                       ml_anrad (* pi (/ ml_antm 180.0)))  )  
      
      (progn (setq ml_anrad (* pi (/ ml_an 180.0)))  ))  
       
       ;**********************************************

(setq br_an (* 180 (/ (angle br_sp1 br_ep1) pi)))
      (if (>= br_an 180)
          (progn (setq br_anrad (* pi (/ br_an 180.0)))  )  
          
          (progn (setq br_antm (+ 180.0 br_an )  
                       br_anrad (* pi (/ br_antm 180.0)))  ))  

))      
      ;//////////// END //////////
 
 (setq pt_1 (polar inter ml_anrad 100.0)
          pt_2 (polar inter br_anrad 100.0)
          pt_3 (polar int_r2 br_anrad 100.0)  )

    (setvar "clayer" ml_lay) 
    (command "break" pt_2 "f" pt_2 inter)
    (command "line" pt_1 pt_2 pt_3 "")

(setvar "clayer" clay)
(setvar "osmode" osmd)
(command "undo" "e")
)

(defun ins-err (st)
  (command nil nil nil)
  (alert st)(terpri)
  (setq *error* orig-err)(princ)
);end of function  
(prompt "\nNECK.lsp is loaded, Start with command NECK")
