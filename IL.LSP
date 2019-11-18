; THIS PROGRAM HELPS YOU TO DRAW THE IL LEVELS IN YOUR DRAWING.

(DEFUN C:IL()
(IF (/= fpoint1 NIL) (PRINC "\nTo Use Last Point as First Point, Just enter "))
(setq tmp1 spoint)
(SETQ fpoint1 (GETPOINT "\n Pick first point "))
(if (= fpoint1 nil) (setq fpoint1 tmp1)) 
(SETQ spoint (GETPOINT fpoint1 "\n Next point ... "))
(command "luprec" 3)
(SETQ DT (/ (DISTANCE fpoint1 spoint) 1000.0))

(IF (/= ILV NIL) (SETQ ILX ILV))
(PRINC "\n Enter the IL < ")
(if (/= ILX NIL)(PRINC ILX))
(PRINC " >")
(SETQ ILY (GETREAL))
(IF (/= ILY NIL) (SETQ ILV ILY))


(IF (/= SLP NIL) (SETQ SLX SLP))
(PRINC "\n Enter the slope 60/80/90/100 < ")
(IF (/= SLX NIL) (PRINC SLX))
(PRINC " >")
(SETQ SLPP (GETINT))
(IF (= SLPP NIL) (SETQ SLP SLX))
(IF (/= SLPP NIL) (SETQ SLP SLPP))


(SETQ V (/ DT SLP))
(SETQ ILV (- ILV V))
(PRINC "ILV +")(PRINC ILV)(PRINC)
(setq ILTXT (rtos ILV))

(SETQ DIMP (GETPOINT spoint "\nPick a point for text"))
(command "_leader" spoint DIMP ""  ILTXT "")
)






