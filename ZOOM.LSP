;This Program Purge All un used Layers Blocks Linetypes from Drawing
; Date 28-11-2008
; Time 10:00:45
; Author Asad Saeed
; Dedicate M.A. Saeed
(defun c:pp()
      (command "-purge" "A" "" "n" "")
)
(defun c:Zz()
      (command "ZOOM" "E" "")
)
(defun c:ZP()
      (command "ZOOM" "P" "")
)
(defun c:AU()
      (command "AUDIT" "Y" "")
)
(defun c:rd()
      (command "_revcloud" "s" "c")
)
(defun c:xxx()
      (command "_xline" "v" "")
)
;(princ "\nStart Command By *ZE*")
