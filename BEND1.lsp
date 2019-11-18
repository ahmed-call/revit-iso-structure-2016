(defun C:BEND1 ()
   (if (= (getvar "worlducs") 0) (command "ucs" "w")) 
     (setq oldsnap (getvar "Osmode"))      
     (setvar "osmode" 512)  
        (setq li_p1 (getpoint "\nSelect Outer Line-1 :"))
        (setq li_1 (ssget li_p1))
        (setq lin_1 (ssname li_1 0))
        (setq la_nm (cdr (assoc 8 (entget lin_1))))
           (setvar "osmode" 128)    
        (setq li_p2 (getpoint li_p1 "\nSelect Inner Line-1 : "))
        (setq li_2 (ssget li_p2))
        (setq lin_2 (ssname li_2 0))
           (setvar "osmode" 512) 
        (setq li_p3 (getpoint "\nSelect Outer Line-2 :"))
        (setq li_3 (ssget li_p3))
        (setq lin_3 (ssname li_3 0))
           (setvar "osmode" 128)    
        (setq li_p4 (getpoint li_p3 "\nSelect Inner Line-2 : "))
        (setq li_4 (ssget li_p4))
        (setq lin_4 (ssname li_4 0))
           (setvar "osmode" 0)
       (setq li_cp (inters li_p1 li_p2 li_p3 li_p4 nil)
             dist1 (distance li_p1 li_p2))
     (if (> dist1 300) (setq f_rad1 150 f_rad2 (+ 150 dist1))
                       (setq f_rad1 (/ dist1 2.0) f_rad2 (* (/ dist1 2.0) 3)))
     (command "fillet" "r" f_rad1)
     (command "fillet" li_p2 li_p4)                  
     (command "fillet" "r" f_rad2)
     (setq arc1 (entlast))
     (command "fillet" li_p1 li_p3)
     (setq arc_cpt (cdr (assoc 10 (entget arc1))))
     (setq li_pt2 (polar arc_cpt (angle li_p2 li_p1) f_rad1))
     (setq li_pt1 (polar arc_cpt (angle li_p2 li_p1) f_rad2))
     (setq li_pt4 (polar arc_cpt (angle li_p4 li_p3) f_rad1))     
     (setq li_pt3 (polar arc_cpt (angle li_p4 li_p3) f_rad2))
     (command "layer" "s" la_nm "")
     (command "line" li_pt1 li_pt2 "" "line" li_pt3 li_pt4 "")
           (setvar "Osmode" oldsnap)  
)