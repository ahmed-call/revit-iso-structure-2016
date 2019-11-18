(defun c:C1 () 
  (setq x (entsel "\nSelect object: "))   
  (command "_copy" x "" "0,0" "0,-12")
)
(defun c:C2 () 
  (setq x (entsel "\nSelect object: "))   
  (command "_copy" x "" "0,0" "0,-14")
)
(defun c:C3 () 
  (setq x (entsel "\nSelect object: "))   
  (command "_copy" x "" "0,0" "0,-16")
)
(defun c:C4 () 
  (setq x (entsel "\nSelect object: "))   
  (command "_copy" x "" "0,0" "0,-18")
)

    

