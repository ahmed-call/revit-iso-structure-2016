;;;
; MOVE
(defun c:M1 () (command "move" Pause "" "0,0" "5000,0"))
(defun c:M2 () (command "move" Pause "" "0,0" "-5000,0"))
(defun c:M3 () (command "move" Pause "" "0,0" "0,5000"))
(defun c:M4 () (command "move" Pause "" "0,0" "0,-5000"))
