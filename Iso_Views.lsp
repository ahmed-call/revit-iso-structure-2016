**********************************************************
;;;     Written by Munir Hussain  munir7259@yahoo.com 
;;;     Engineeringgraphics Auto Lisp enggraphics786@gmail.com
;Iso_Views.lsp September 2013                        
;A routine to redraw objects into an isometric view         
;Works with lines, circles, arcs, text, lwplines, & splines 
;***********************************************************

(Defun C:ISO (/ iso_dcl _view _filter ss count _ref _disp _x _y _minor _major clayer cecolor celtype
	      celtscale osmode ent _type layer color ltype ltscale pt1 pt2 rad cen oblq pt3 pt4 rot)
  (create_dcl_file)						;create "Iso_Views.dcl" if missing
  (setq iso_dcl(load_dialog "Iso_Views.dcl"))			;load dialog
  (new_dialog "iso" iso_dcl)
  (if(findfile(strcat(getvar "tempprefix") "Iso_Settings.lsp"))
    (load(strcat(getvar "tempprefix") "Iso_Settings.lsp"))	;load settings from previous use or...
    (progn							;select all types for first use
      (set_tile "line" "1")
      (set_tile "circle" "1")
      (set_tile "arc" "1")
      (set_tile "text" "1")
      (set_tile "lwpolyline" "1")
      (set_tile "spline" "1")
    );end progn
  );end if
  (start_image "left")   (draw_left_button)(draw_box_frame)(end_image);draw "Left" button
  (start_image "right") (draw_right_button)(draw_box_frame)(end_image);draw "Right" button
  (start_image "top_left") (draw_top_panel)(draw_tl_arrow)(draw_box_frame)(end_image);draw "Top Left" button
  (start_image "top_right")(draw_top_panel)(draw_tr_arrow)(draw_box_frame)(end_image);draw "Top Right" button
  (action_tile "left" "(setq _view \"L\")(set_iso_filter)")
  (action_tile "right" "(setq _view \"R\")(set_iso_filter)")
  (action_tile "top_left" "(setq _view \"TL\")(set_iso_filter)")
  (action_tile "top_right" "(setq _view \"TR\")(set_iso_filter)")
  (action_tile "help" "(iso_views_help)")
  (start_dialog)						;display dialog box
  (if(null _view)(quit))					;quit if dialog box cancelled
  (setq ss(ssget(list(cons 0 _filter)))				;select objects
	count -1)
  (repeat(sslength ss)
    (redraw(ssname ss(setq count(1+ count)))3)			;highlight objects
  );end repeat
  (setq _ref(getpoint "Enter a reference point: ")
	_disp(getpoint _ref "Enter a displacement point: ")
	count 0)
  (if(= _view "L")						;angles (in radians) for "Left" view
    (setq _x (* pi(/ 1 6.0)) _y (* pi 0.5) _minor (* pi(/ 5 6.0)) _major (* pi(/ 2 6.0)))
    (if(= _view "R")						;angles (in radians) for "Right" view
      (setq _x (* pi(/ 11 6.0)) _y (* pi 0.5) _minor (* pi(/ 1 6.0)) _major (* pi(/ 4 6.0)))
      (if(= _view "TL")						;angles (in radians) for "Top Left" view
	(setq _x (* pi(/ 1 6.0)) _y (* pi(/ 5 6.0)) _minor (* pi 0.5) _major pi)
	(if(= _view "TR")					;angles (in radians) for "Top Right" view
	  (setq _x (* pi(/ 11 6.0)) _y (* pi(/ 1 6.0)) _minor (* pi 0.5) _major pi)
	);end "TR" if
      );end "TL" if
    );end "R" if
  );end "L" if
  (setvar "cmdecho" 0)
  (command ".undo" "be")					;begin undo group
  (setq clayer(getvar "clayer")
	cecolor(getvar "cecolor")
	celtype(getvar "celtype")
	celtscale(getvar "celtscale")
	osmode(getvar "osmode"))
  (setvar "osmode" 0)
  (repeat(sslength ss)						;repeat for each object
    (setq ent(entget(ssname ss count))				;entity data
	  _type(cdr(assoc 0 ent))				;object type
	  layer(cdr(assoc 8 ent))
	  color(cdr(assoc 62 ent))
	  ltype(cdr(assoc 6 ent))
	  ltscale(cdr(assoc 48 ent)))
    (if(null color)(setq color "ByLayer")(setq color(itoa color)))
    (if(null ltype)(setq ltype "ByLayer"))
    (setvar "clayer" layer)					;match object's layer
    (setvar "cecolor" color)					;match object's color
    (setvar "celtype" ltype)					;match object's ltype
    (command ".celtscale" ltscale)				;match object's ltype scale
    (cond((= _type "LINE")
	  (setq pt1(get_iso_point(cdr(assoc 10 ent)))		;endpoint1
		pt2(get_iso_point(cdr(assoc 11 ent))))		;endpoint2
	  (make_ent ent(list(cons 10 pt1)(cons 11 pt2)))	;create new line
	 );end LINE cond
	 ((= _type "CIRCLE")
	  (setq rad(cdr(assoc 40 ent))				;radius
		cen(get_iso_point(cdr(assoc 10 ent))))		;center point
	  (draw_iso_circle rad cen nil nil)			;draw full ellipse
	 );end CIRCLE cond
	 ((= _type "ARC")
	  (setq rad(cdr(assoc 40 ent))				;radius
		cen(cdr(assoc 10 ent))				;center point
		pt1(get_iso_point(polar cen(cdr(assoc 50 ent))rad));new endpoint1
		pt2(get_iso_point(polar cen(cdr(assoc 51 ent))rad));new endpoint2
		cen(get_iso_point cen))				;new center point
	  (draw_iso_circle rad cen pt1 pt2)			;draw partial ellipse
	 );end ARC cond
	 ((= _type "TEXT")
	  (setq rot(cdr(assoc 50 ent))				;rotation angle
		oblq(cdr(assoc 51 ent))				;obliquing angle
		pt1(cdr(assoc 10 ent))				;first alignment point
		pt2(get_iso_point(cdr(assoc 11 ent)))		;new second alignment point
		pt3(get_iso_point(polar pt1 rot 1))		;point in rotation angle
		pt4(get_iso_point(polar pt1(-(+ rot(* pi 0.5))oblq)1));point in obliquing angle
		pt1(get_iso_point pt1)				;new first alignment point
		rot(angle pt1 pt3)				;new rotation angle
		oblq(- 0(-(angle pt1 pt4)(* pi 0.5)rot)))	;new obliquing angle
	  (make_ent ent (list(cons 10 pt1)(cons 11 pt2)(cons 50 rot)(cons 51 oblq)));create new text object
	 );end TEXT cond
	 ((= _type "LWPOLYLINE")
	  (if(vl-remove-if-not '(lambda(code)(and(= 42(car code))(/= 0.0(cdr code))))ent);if arc segments are included...
	    (draw_arc_lwplines)					;draw segments individually
	    (progn						;otherwise copy lwpline directly
	      (foreach code ent					;step through entity data
		(if(= 10(car code))				;for code 10...
		  (setq pt1(get_iso_point(cdr code))		;new pline point
			ent(subst(cons(car code)pt1)code ent))	;update entity data
		);end if
	      );end foreach
	      (entmake ent)					;create new lwpline
	    );end progn
	  );end arc segment if
	 );end LWPOLYLINE cond
	 ((= _type "SPLINE")
	  (foreach code ent					;step through entity data
	    (if(or(= 10(car code))(= 11(car code)))		;for codes 10 or 11...
	      (setq pt1(get_iso_point(cdr code))		;new spline point
		    ent(subst(cons(car code)pt1)code ent))	;update entity data
	    );end if
	  );end foreach
	  (setq tan1(assoc 12 ent)				;end tangency1
		tan2(assoc 13 ent))				;end tangency2
	  (if tan1
	    (setq ent(subst(cons 12(polar(polar '(0 0 0) _x (cadr tan1)) _y (caddr tan1))) tan1 ent));calculate new tangency
	  );end tan1 if
	  (if tan2
	    (setq ent(subst(cons 13(polar(polar '(0 0 0) _x (cadr tan2)) _y (caddr tan2))) tan2 ent));caluclate new tangency
	  );end tan2 if
	  (entmake ent)						;create new spline
    ));end SPLINE cond
    (setq count(1+ count))					;set counter to next object
  );end repeat
  (setvar "clayer" clayer)					;reset layer
  (setvar "cecolor" cecolor)					;reset color
  (setvar "celtype" celtype)					;reset linetype
  (setvar "celtscale" celtscale)				;reset linetype scale
  (setvar "osmode" osmode)					;reset osmode
  (command ".regen" ".undo" "e")				;end undo group
  (setvar "cmdecho" 1)
  (princ)							;exit quietly
);end C:ISO

;create Iso_Views.dcl if it is missing
(defun create_dcl_file (/ support file)
  (vl-load-com)							;load Visual Lisp extensions
  (cond((null(findfile "Iso_Views.dcl"))
	(if(findfile "Iso_Views.lsp")				;match directory of "Iso_Views.lsp" or use root directory
	  (setq support(vl-filename-directory(findfile "Iso_Views.lsp")))
	  (setq support(vl-filename-directory(findfile "Acad.exe")))
	);end if
	(setq file(open(strcat support "\\Iso_Views.dcl")"w"))
	(write-line "iso : dialog {label=\"Isometric Views\";\n  : row {\n    : boxed_column {label=\"Include:\";" file)
	(write-line "      : toggle {key=\"line\";label=\"Lines\";}\n      : toggle {key=\"circle\";label=\"Circles\";}" file)
	(write-line "      : toggle {key=\"arc\";label=\"Arcs\";}\n      : toggle {key=\"text\";label=\"Text\";}" file)
	(write-line "      : toggle {key=\"lwpolyline\";label=\"LWPlines\";}\n      : toggle {key=\"spline\";label=\"Splines\";}\n    }" file)
	(write-line "    : boxed_column {label=\"Select drawing plane:\";\n      : row {\n        spacer_0;" file)
	(write-line "        : image_button {key=\"left\";width=10;aspect_ratio=1;fixed_width=true;color=254;}" file)
	(write-line "        : image_button {key=\"right\";width=10;aspect_ratio=1;fixed_width=true;color=254;}" file)
	(write-line "        spacer_0;\n      }\n      : row {\n        spacer_0;" file)
	(write-line "        : image_button {key=\"top_left\";width=10;aspect_ratio=1;fixed_width=true;color=254;}" file)
	(write-line "        : image_button {key=\"top_right\";width=10;aspect_ratio=1;fixed_width=true;color=254;}" file)
	(write-line "        spacer_0;\n      }\n      spacer;\n    }\n  }\n  spacer;" file)
	(write-line "  : row {:spacer{width=17;}cancel_button;help_button;spacer_1;}\n}" file)
	(close file)
  ));end cond
);create_support_files

;save current settings and specify filter for entity selection
(defun set_iso_filter (/ file)
  (setq file(open(strcat(getvar "tempprefix") "Iso_Settings.lsp")"w"));open settings file
  (foreach item(list "line" "circle" "arc" "text" "lwpolyline" "spline")
    (write-line(strcat "(set_tile \"" item "\" \"" (get_tile item) "\")") file)
    (if(= "1"(get_tile item))					;if item is checked, add item to _filter
      (if _filter
        (setq _filter(strcat _filter "," item))
	(setq _filter item)
      );end if
    );end if
  );end foreach
  (close file)							;close settings file
  (if _filter							;if _filter is specified...
    (done_dialog)						;close dialog box
    (alert "At least one object type needs to be specified.\nPlease try again.")
  );end if
);end set_iso_filter

;help message for dialog box.
(defun iso_views_help (/ msg)
  (setq msg(strcat
	     "Iso_Views.lsp				(c) 2017 Munir Hussain\n\n"
	     "The Iso Views function will take any number of objects and redraw them\n"
	     "in one of the four different isometric planes.  All objects remain in 2D,\n"
	     "but use AutoCAD's isometric mode to represent a 3D view.\n\n"
	     "The dialog box allows you to specify filters for use when selecting objects.\n"
	     "Only those you specify will be included, any others will be filtered out.\n\n"
	     "There are four buttons showing each of the isometric planes.  Selecting one\n"
	     "of these buttons will close the dialog box and prompt you to select objects.\n"
	     "After you have selected objects, you will need to specify a base point and a\n"
	     "displacement point.  Now you can simply watch the new view take shape."))
  (alert msg)
);end iso_views_help

;calculate corresponding point in the isometric view
(defun get_iso_point (pt1 / iso_pt)
  (setq iso_pt(polar _disp _x(-(car pt1)(car _ref)))		;shifted in _x direction from _ref
	iso_pt(polar iso_pt _y (-(cadr pt1)(cadr _ref))))	;shifted in _y direction from _ref
  iso_pt
);end get_iso_point

;create new entity with old entity data and list of modified group codes
(defun make_ent (ent codes / old new)
  (foreach code codes
    (setq old(cons (car code)(cdr(assoc(car code)ent)))		;current value for group code
	  ent(subst code old ent))				;updated entity data
  );end foreach
  (entmake ent)							;create new entity
);end make_ent

;draw ellipse to represent circles or arcs
(defun draw_iso_circle (rad cen pt1 pt2 / minor major)
  (setq minor(polar cen _minor(* rad 0.70710678))		;point for minor axis
	major(polar cen _major(* rad 1.22474487)))		;point for major axis
  (if(and pt1 pt2)						;if endpoints are specified...
    (command ".ellipse" "a" "c" cen minor major pt1 pt2)	;draw partial ellipse
    (command ".ellipse" "c" cen minor major)			;draw full ellipse
  );end endpoint if
);end draw_iso_circle

;draw lwpline segments individually if arcs are included because plines cannot contain ellipse segments
(defun draw_arc_lwplines (/ pts pt1 bulge pt2 1/2c ang mpt rise rad cen pt3)
  (setq pts(vl-remove-if-not					;vertexes of lwpline
	     '(lambda(code)(or(= 10(car code))(and(= 42(car code))(/= 0.0(cdr code)))));codes 10 or 42
	     ent);end vl-remove-if-not
  );end setq
  (if(or(= 1(cdr(assoc 70 ent)))(= 129(cdr(assoc 70 ent))))	;if lwpline is closed...
    (setq pts(append pts(list(car pts))))			;add first point to end of list
    );end if
  (while(< 1(length pts))
    (setq pt1(cdr(car pts)))					;start point of segment
    (cond((= 42(car(car(cdr pts))))				;if segment is an arc...
	  (setq bulge(cdr(cadr pts))				;bulge angle
		pt2(cdr(caddr pts))				;end point of segment
		1/2c(/(distance pt1 pt2)2)			;1/2 length of chord
		ang(angle pt1 pt2)				;angle of chord
		mpt(polar pt1 ang 1/2c)				;midpoint of chord
		rise(* bulge 1/2c)				;rise distance of arc
		rad(/(+(* rise rise)(* 1/2c 1/2c))(* rise 2))	;radius of arc
		cen(get_iso_point(polar mpt(+(/ pi 2)ang)(- rad rise)));center point
		pt1(get_iso_point pt1)				;new endpoint1
		pt2(get_iso_point pt2)				;new endpoint2
		pts(cdr(cdr pts)))				;set pts variable to next segment
	  (if(> 0 bulge)(setq pt3 pt1 pt1 pt2 pt2 pt3))		;if bulge is negative, reverse endpoints
	  (draw_iso_circle rad cen pt1 pt2)			;draw partial ellipse
	  );end arc cond
	 ((= 10(car(car(cdr pts))))				;if segment is a line...
	  (setq pt1(get_iso_point pt1)				;new endpoint1
		pt2(get_iso_point(cdr(cadr pts)))		;new nedpoint2
		pts(cdr pts))					;set pts variable to next segment
	  (command ".line" pt1 pt2 "")
	  ));end line cond
    );end while
);end draw_arc_lwplines

;fill image tiles from list of points
(defun draw_vectors (_list _color / coords)
  (foreach coords _list						;draw line for each list of coordinates
    (vector_image (nth 0 coords)(nth 1 coords)(nth 2 coords)(nth 3 coords) _color)
  );end foreach
);end draw_vectors

;draw left panel & arrow
(defun draw_left_button ()
  (draw_vectors							;draw left panel
    '((23 33 23 7)(22 34 22 9)(21 35 21 9)(20 36 20 10)(19 37 19 11)(18 38 18 12)
      (17 39 17 13)(16 40 16 14)(15 41 15 15)(14 42 14 16)(13 43 13 17)(12 44 12 18)
      (11 45 11 19)(10 45 10 20))				;list of points
    152								;color to use
  );end draw_vectors
  (draw_vectors							;draw left arrow
    '((19 22 19 22)(18 23 18 21)(18 23 18 20)(18 24 18 19)(17 24 17 18)(17 36 17 17)
      (16 36 16 17)(16 37 16 17)(16 37 16 19)(15 26 15 20)(15 26 15 22)(14 27 14 24)
      (14 27 14 25)(14 27 14 27))				;list of points
    9								;color to use
  );end draw_vectors
);end draw_left_button

;draw right panel & arrow
(defun draw_right_button ()
  (draw_vectors							;draw right panel
    '((24 6 50 14)(24 32 50 39)(24 31 50 38)(24 30 50 37)(24 29 50 36)(24 28 50 35)
      (24 27 50 34)(24 26 50 33)(24 25 50 32)(24 24 50 31)(24 23 50 30)(24 22 50 29)
      (24 21 50 28)(24 20 50 27)(24 19 50 27)(24 19 50 26)(24 18 50 26)(24 18 50 25)
      (24 17 50 25)(24 17 50 24)(24 16 50 24)(24 16 50 23)(24 15 50 23)(24 15 50 22)
      (24 14 50 22)(24 14 50 21)(24 13 50 21)(24 13 50 20)(24 12 50 20)(24 12 50 19)
      (24 11 50 19)(24 11 50 18)(24 10 50 18)(24 10 50 17)(24 9 50 17)(24 9 50 16)
      (24 8 50 16)(24 8 50 15)(24 7 50 15)(24 7 50 14))		;list of points
    152								;color to use
  );end draw_vectors
  (draw_vectors							;draw right arrow
    '((42 23 42 22)(42 23 42 21)(41 23 41 21)(41 22 41 20)(40 22 40 19)(40 22 40 18)
      (39 22 39 17)(39 33 39 16)(39 33 39 15)(38 33 38 15)(38 33 38 14)(37 33 37 13)
      (37 33 37 14)(36 33 36 14)(36 33 36 15)(35 21 35 15)(35 21 35 16)(35 21 35 17)
      (34 21 34 17)(34 21 34 18)(33 20 33 18)(33 20 33 19)(32 20 32 20));list of points
    9								;color to use
  );end draw_vectors
);end draw_right_button

(defun draw_top_panel ()
  (draw_vectors							;draw top panel
    '((50 41 50 40)(49 41 49 40)(48 42 48 40)(47 43 47 40)(47 43 47 39)(46 44 46 39)
      (45 45 45 39)(44 46 44 39)(43 47 43 39)(43 47 43 38)(42 48 42 38)(41 49 41 38)
      (40 50 40 38)(39 51 39 37)(38 52 38 37)(37 53 37 37)(36 53 36 37)(35 53 35 36)
      (34 53 34 36)(33 53 33 36)(32 52 32 35)(31 52 31 35)(30 52 30 35)(29 52 29 35)
      (28 51 28 34)(27 51 27 34)(26 51 26 34)(25 50 25 34)(24 50 24 33)(23 50 23 34)
      (22 50 22 35)(22 49 22 35)(21 49 21 36)(20 49 20 37)(19 49 19 38)(18 49 18 39)
      (18 48 18 39)(17 48 17 40)(16 48 16 41)(15 48 15 41)(15 48 15 42)(14 47 14 43)
      (13 47 13 43)(13 47 13 44)(12 47 12 45)(11 47 11 45)(11 47 11 46));list of points
    152								;color to use
  );end draw_vectors
);end draw_top_panel

(defun draw_tl_arrow ()
  (draw_vectors							;draw top-left arrow
    '((39 47 40 47)(37 46 40 46)(36 46 40 46)(34 46 41 46)(33 45 41 45)(25 45 26 45)
      (32 45 40 45)(25 45 27 45)(30 44 38 44)(24 44 27 44)(29 44 37 44)(24 44 36 44)
      (23 43 34 43)(23 43 33 43)(22 43 31 43)(22 42 30 42)(21 42 30 42)(21 41 30 41)
      (20 41 30 41)(20 41 31 41))				;list of points
    9								;color to use
  );end draw_vectors
);end draw_tl_arrow

(defun draw_tr_arrow ()
  (draw_vectors							;draw top-right arrow
    '((26 49 27 49)(25 49 27 48)(24 49 28 47)(24 48 29 47)(23 48 29 46)(36 44 36 44)
      (23 48 30 46)(35 44 36 43)(24 47 30 45)(34 44 36 43)(25 46 31 45)(34 43 36 43)
      (25 46 32 44)(33 43 36 42)(26 45 32 43)(26 45 36 42)(28 44 36 41)(28 43 36 41)
      (29 42 36 40)(28 42 36 39)(27 42 36 39)(27 41 36 39)(26 41 35 38));list of points
    9								;color to use
  );end draw_vectors
);end draw_tr_arrow

(defun draw_box_frame ()
  (draw_vectors							;draw box frame
    '((36 54 36 27)(9 20 36 27)(51 13 36 27)(36 54 51 40)(9 47 36 54)(9 20 24 6)
      (9 47 9 20)(9 47 24 33)(51 40 51 13)(24 6 51 13)(24 33 24 6)(24 33 51 40));list of points
    198								;color to use
  );end draw_vectors
);end draw_box_frame
