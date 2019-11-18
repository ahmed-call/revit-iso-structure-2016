; Edit Multiple Selection Text, Mtext, Dimension, Attributed Inserts
; Date 24-12-2008
; Time 02:25:45
; Author Asad Saeed
; Dedicate M.A. Saeed
(defun c:tE (/ echo *error* ss i ename data)
  (setq echo (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  
  (defun *error* (msg)
    (cond
      ((and
	 msg
	 (not (member msg '("Function cancelled" "quit / exit abort"))) )
       (princ (strcat "\ntEdit error: " msg))
       )
      (t princ)
      )
    (setvar "cmdecho" echo)
    )

  (if (setq
	ss
	 (ssget
	   '((-4 . "<or")
	     (0 . "TEXT,MTEXT,ATTDEF,ARCALIGNEDTEXT,DIMENSION,MULTILEADER")
	     (-4 . "<and") (0 . "INSERT") (66 . 1) (-4 . "and>")
	     (-4 . "or>")
	     )
	   )
	)
    (progn
      (setq i -1)
      (repeat (sslength ss)
	(setq ename (ssname ss (setq i (1+ i))))
	(setq data (cdr (assoc 0 (entget ename))))
	(cond
	  ((wcmatch data "TEXT,ATTDEF,MTEXT,DIMENSION,MULTILEADER")
	   (command "._ddedit" ename "") )
	  
	  ((= "ARCALIGNEDTEXT" data) (command "._arctext" ename))
	  
	  ((= "INSERT" data) (command "._ddatte" ename))
	  
	  )
	(while (> (getvar "cmdactive") 0) (command pause))
	)
      )
    )
  (*error* nil)
  (princ)
  )
  (princ "\nStart Command By *Tedit*")