;;;LV.lsp Viewport Lock and Unlock    (c) Munir Hussain 
;;; Function: Lock/Unlock Viewports
;;; Command Line: LV
;;; Description: By locking the Display you ensure your
;;;              model view will not accidentally shift
;;;              if you activate the viewport
;;;
;;;
(defun get-objects ()
  (setq DPL (vlax-ename->vla-object (ssname SSG CNT))
	CNT (1+ CNT)
  );;setq
);;get-objects

;;;********** Error Handler **********
(defun ERR (msg)
  (princ)
);;ERR

;;;********** Main Program **********
(defun C:LV (/ CME CNT DPL *ERROR* OP SSG)
  (vl-load-com)
  (setq *ERROR* ERR
        CME (getvar "CMDECHO")
  );;setq
  (setvar "CMDECHO" 0)
  (if (= (getvar "TILEMODE") 1) (setvar "TILEMODE" 0))
  (command "pspace")
  (setq SSG (ssget "X" (list (cons 0 "VIEWPORT")))
	CNT 0
  );;setq
  (initget "Yes No")
  (setq OP (getkword "Display locked [Yes/No] <Y>: "))
  (cond
    ((or (= OP nil) (= OP "Yes"))
      (repeat (sslength SSG)
        (get-objects)	
	(vla-put-DisplayLocked DPL :vlax-true)
      );;repeat
      (prompt "\n\tAll Viewports Locked...!")
    );;"Yes"
    ((= OP "No")
      (repeat (sslength SSG)
	(get-objects)
	(vla-put-DisplayLocked DPL :vlax-false)
      );;repeat
      (prompt "\n\tAll Viewports Unlocked...!")
    );;"No"
  );;cond
  (setvar "CMDECHO" CME)
  (princ)
);;C:LV
(princ
  (strcat
    "  LV.LSP v1.0 (Copyright 2016 by "
    "\"Theo Winata and You\") loaded...!"
  )
)
(princ)
  