;* CLEANUP.LSP
;
;  by Dominic Panholzer
;     Compuserve: 72204,266
;     Flack + Kurtz Consulting Engineers
;     San Francisco
;     April 23, 1992
;*
;*      This routine prepares drawings received from clients
;* to be used for background xrefs.  It will change every layer
;* color to the designated background color, specified by the
;* variable NEW_CLR below.  It will also change all drawing 
;* entities to color BYLAYER.  Next all blocks will be checked
;* for attribute subentities with color designations. These will
;* all be changed to NEW_CLR.  Finally, all block subentities 
;* which are not color BYLAYER will be changed to BYBLOCK.
;*

(defun c:cln ( / NEW_CLR, CMD, TBDATA, ENAME, EDATA, ENXT)
  
  (setq NEW_CLR  8                              ; Color 8 = grey.
        NEW_CLR  (cons 62 NEW_CLR)              ; Set dotted pair for subst.
        CMD      (getvar "CMDECHO")             ; Save command echo setting.
        SS       (ssget "X")                    ; Selection set of all ents.
        SSLEN    (sslength SS)                  ; Length of selection set.
        CNT      0                              ; Counter = 0.
  );setq
  (setvar "CMDECHO" 0)                          ; Set command echoing off.  
;-------------------------------------------------  
; Use this to select color to be changed to 
; else 8 will be used
;-------------------------------------------------    
  (if
    (setq INPUT (getint "Please enter color number <8>: "))
    (setq NEW_CLR (CONS 62 INPUT))
  );if

;-------------------------------------------------  
; Change entities' color to BYLAYER
; and all layers to NEW_CLR 
;-------------------------------------------------    

  (command "CHPROP" SS "" "COLOR" "BYLAYER" "") ; Change color of all ents.
  (command "LAYER" "COLOR" (cdr NEW_CLR) "*" ""); Change layer color.

;-------------------------------------------------  
; CLEANUP ATTRIBUTES not working properly
;-------------------------------------------------

  (setq ss1 (ssget "x" (list (cons 0 "INSERT"))))
  (setq n 0)
  (while (< n (sslength ss1))
    (setq ent (ssname ss1 n))
    (setq done nil)
    (while (not done)
      (if (setq ent (entnext ent))
        (if (= (cdr (assoc 0 (entget ent))) "ATTRIB")
          (progn
            (setq entg (entget ent))
            (setq entg62 (assoc 62 entg))
            (if entg62
              (setq entg (subst (cons 62 256) entg62 entg))
              (setq entg (cons (cons 62 256) entg))
            )
            (entmod entg)
          )
          (setq done 't)
        )
        (setq done 't)
      )
    )
    (setq n (1+ n))
  )
  
;-------------------------------------------------  
; CLEANUP BLOCK LIST
;-------------------------------------------------  

  (setq NEW_CLR  (cons 62 0))                   ; Set NEW_CLR to BYBLOCK.
  (setq TBDATA (tblnext "BLOCK" T))             ; Retreive the first block
  (while TBDATA                                 ; from symbol table.
    (setq ENAME (cdr (assoc -2 TBDATA)))        ; Retrive its entity number.
    (ch_color ENAME NEW_CLR)                    ; Change its color.
    (setq TBDATA (tblnext "BLOCK"))             ; Get the next block.
  );while
  
  (command "REGEN")                             ; Regenerate the drawing.
  (setvar "CMDECHO" CMD)                        ; Reset command echo.
  (princ)                                       ; Finish cleanly.

);defun

; -------------------- COLOR CHANGING FUNCTION -------------------
;                 Changes ENAME's color to NEW_CLR
; ----------------------------------------------------------------

(defun ch_color ( ENAME, NEW_CLR / EDATA, OLD_CLR)
  (setq EDATA (entget ENAME))                 ; Get entity data.
  (while EDATA                                
    (if (setq OLD_CLR (assoc 62 EDATA))       ; If entity has a color,
      (progn
        (setq EDATA (subst NEW_CLR OLD_CLR EDATA))     ; subst. new color
        (entmod EDATA)                                 ; and update entity.
      );progn
    );if
    (setq ENAME (entnext ENAME))              ; Retreive subentity.
    (if ENAME                                 ; If it exists repeat process,
      (setq EDATA (entget ENAME))
      (setq EDATA nil)                        ; else return.
    );if
;    (if (= (cdr (assoc 0 EDATA)) "SEQEND")
;      (setq EDATA nil)
;    )
  );while
);defun

(princ "\nType CLN to run cleanup routine!")
