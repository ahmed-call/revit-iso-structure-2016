;;;This Program was created by K.Muraleethara, OTE, Dubai, Ph 671279
::;                                                       Fax 670277 
;;;for the Duct size selection in Inches and mm.
;;;Input Velocity in Feet per Minute &
;;;Input Air Volume in Cubic feet per Minute.


(defun cls() (repeat 23 (princ "\n")))
(defun c:duct()
(setq unit (getvar"lunits"))
(setvar "lunits" 2)
(textscr)
(if (= v nil) (setq v 800))
(princ "\nEnter Velocity in FPM < ")
(princ v)
(princ " >")
(setq vct (getreal))
(if (= vct nil) (setq vct v))
(setq v (fix vct))

(if (= cf nil) (setq cf 770))
(princ "\nEnter Air Volume in CFM  < ")
(princ cf)
(princ " >")
(setq cfm (getreal))
(if (= cfm nil) (setq cfm cf))
(setq cf (fix cfm))
(cls)
(setvar "luprec" 0)

(setq area (* (/ cfm vct) 144 1.1))

;; Round duct size

(setq dia (sqrt (* (/ area pi) 4)))

;; Rectangular Duct size

(setq sz4 (/ area 4))
(setq sz5 (/ area 5))
(setq sz6 (/ area 6))
(setq sz7 (/ area 7))
(setq sz8 (/ area 8))
(setq sz9 (/ area 9))
(setq sz10 (/ area 10))
(setq sz11 (/ area 11))
(setq sz12 (/ area 12))
(setq sz13 (/ area 13))
(setq sz14 (/ area 14))
(setq sz15 (/ area 15))
(setq sz16 (/ area 16))

;; Rectancgular Duct Dimensions in Inches

(setq dim4 (strcat "4 x " (rtos sz4))) 
(setq dim5 (strcat "5 x " (rtos sz5))) 
(setq dim6 (strcat "6 x " (rtos sz6))) 
(setq dim7 (strcat "7 x " (rtos sz7))) 
(setq dim8 (strcat "8 x " (rtos sz8))) 
(setq dim9 (strcat "9 x " (rtos sz9))) 
(setq dim10 (strcat "10 x " (rtos sz10))) 
(setq dim11 (strcat "11 x " (rtos sz11))) 
(setq dim12 (strcat "12 x " (rtos sz12))) 
(setq dim13 (strcat "13 x " (rtos sz13))) 
(setq dim14 (strcat "14 x " (rtos sz14))) 
(setq dim15 (strcat "15 x " (rtos sz15))) 
(setq dim16 (strcat "16 x " (rtos sz16)))

;; Rectancgular Duct Dimensions in Inches

(setq dimm4 (strcat "100 x " (rtos (* 25 sz4)))) 
(setq dimm5 (strcat "125 x " (rtos (* 25 sz5)))) 
(setq dimm6 (strcat "150 x " (rtos (* 25 sz6)))) 
(setq dimm7 (strcat "175 x " (rtos (* 25 sz7)))) 
(setq dimm8 (strcat "200 x " (rtos (* 25 sz8)))) 
(setq dimm9 (strcat "225 x " (rtos (* 25 sz9)))) 
(setq dimm10 (strcat "250 x " (rtos (* 25 sz10)))) 
(setq dimm11 (strcat "275 x " (rtos (* 25 sz11)))) 
(setq dimm12 (strcat "300 x " (rtos (* 25 sz12)))) 
(setq dimm13 (strcat "325 x " (rtos (* 25 sz13)))) 
(setq dimm14 (strcat "350 x " (rtos (* 25 sz14)))) 
(setq dimm15 (strcat "375 x " (rtos (* 25 sz15)))) 
(setq dimm16 (strcat "400 x " (rtos (* 25 sz16))))f


;; Out puts

(setq vct (fix vct))
(setq cfm (fix cfm))
(princ "\nYour VELOCITY is    = ")(princ vct)(princ " FPM")
(princ "\nYour AIR VOLUME  is = ")(princ cfm)(princ " CFM")

(setq dia (fix dia))
(setq mdia (* dia 25))
(princ "\n\nDiameter of Round Duct is = ")(princ dia)(princ " Inch")
                      (princ"\t")(princ mdia)(princ " mm")(princ)

(princ "\n\nRectangular Duct size in Inches below, Choose Among them")
  (princ "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
(terpri)(terpri)(princ dim4)
(princ "\t \t")(princ dim5)
(princ "\t \t")(princ dim6)
(princ "\t \t")(princ dim7)
(princ "\t \t")(princ dim8)(terpri)(terpri) 
(princ dim9)
(princ "\t \t")(princ dim10)
(princ "\t \t")(princ dim11)
(princ "\t \t")(princ dim12)
(princ "\t \t")(princ dim13)(terpri)(terpri)
               (princ dim14)
(princ "\t\t")(princ dim15)
(princ "\t\t")(princ dim16)(princ)

(princ "\n\nRectangular Duct size in MM below, Choose Among them")
  (princ "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
(terpri)(terpri)(princ dimm4)
(princ "\t")(princ dimm5)
(princ "\t")(princ dimm6)
(princ "\t")(princ dimm7) 
(princ "\t")(princ dimm8)
(princ "\t")(princ dimm9)
(princ "\t")(princ dimm10)
(princ "\t")(princ dimm11)
(princ "\t")(princ dimm12)
(princ "\t")(princ dimm13)
(princ "\t")(princ dimm14)
(princ "\t")(princ dimm15)
(princ "\t")(princ dimm16)(princ)
(setvar "lunits" unit)
)


(defun c:gril(/ ccf gsz gh)
(setq ccf (getreal "\nEnter CFM  : "))
;(setq gh (getint "\nEnter Grille Hight 6, 10 <8> : "))

(setq gsz6 (/ (* ccf 207) 3300.0))    
(setq gsz8 (/ (* ccf 207) 4400.0))
(setq gsz10 (/ (* ccf 207) 5500.0))

(if (= gsz6 7) (setq sz6 8))
(if (= gsz6 9) (setq sz6 8))
(if (= gsz6 10) (setq sz6 12))
(if (= gsz6 11) (setq sz6 12))
(if (= gsz6 12) (setq sz6 12))
(if (= gsz6 14) (setq sz6 16))
(if (= gsz6 15) (setq sz6 16))
(if (= gsz6 17) (setq sz6 18))
(if (= gsz6 19) (setq sz6 20))
(if (= gsz6 21) (setq sz6 20))
(if (= gsz6 22) (setq sz6 24))
(if (= gsz6 23) (setq sz6 24))
(if (= gsz6 25) (setq sz6 24))
(if (= gsz6 26) (setq sz6 24))
(if (= gsz6 27) (setq sz6 30))
(if (= gsz6 28) (setq sz6 30))
(if (= gsz6 29) (setq sz6 30))
(if (= gsz6 31) (setq sz6 30))
(if (= gsz6 32) (setq sz6 30))
(if (= gsz6 33) (setq sz6 36))
(if (= gsz6 34) (setq sz6 36))
(if (= gsz6 35) (setq sz6 36))


(setq gszz6 (strcat (itoa (fix  gsz6)) " x 6"))
(setq gszz8 (strcat (itoa (fix gsz8)) " x 8"))
(setq gszz10 (strcat (itoa (fix gsz10)) " x 10"))

;;; STANDARD
(setq std6 (strcat (itoa (fix  sz6)) " x 6"))
;(setq std8 (strcat (itoa (fix sz8)) " x 8"))
;(setq std10 (strcat (itoa (fix sz10)) " x 10"))


(princ "\n Grille size is appox = ") (princ gszz6) (princ"\t")(princ std6)
(princ "\n                        ") (princ gszz8)
(princ "\n                        ") (princ gszz10)(princ)
)

(defun c:sf()
(setq ductw (getint "\nEnter the Duct Width : "))
(setq ducth (getint "\nENter the Duct Hight : "))
(setq ductl (getreal "\nEnter the Duct Lenght: "))
(setq sqfeet (* (+ ductw ducth) 0.167 ductl))
(princ "\nThe are in sq.feet is = ")(princ sqfeet)(princ)
)

(defun c:fpm()
(setq dusize (getpoint "\neEnter Duct Size : "))
(setq w (* (CAR (list (car dusize))) 0.001))
(setq h (* (CAR (list (cadr dusize))) 0.001))
(setq cfm (getint"\nEnter CFM : "))
(setq fpm (/ cfm (* w h 10.76)))
(princ "\nVelocity, FPM = ")
(princ fpm)(princ) 
)