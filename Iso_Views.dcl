iso : dialog {label="Isometric Views By Munir Hussain";
  : row {
    : boxed_column {label="Include:";
      : toggle {key="line";label="Lines";}
      : toggle {key="circle";label="Circles";}
      : toggle {key="arc";label="Arcs";}
      : toggle {key="text";label="Text";}
      : toggle {key="lwpolyline";label="LWPlines";}
      : toggle {key="spline";label="Splines";}
    }
    : boxed_column {label="Select drawing plane:";
      : row {
        spacer_0;
        : image_button {key="left";width=10;aspect_ratio=1;fixed_width=true;color=254;}
        : image_button {key="right";width=10;aspect_ratio=1;fixed_width=true;color=254;}
        spacer_0;
      }
      : row {
        spacer_0;
        : image_button {key="top_left";width=10;aspect_ratio=1;fixed_width=true;color=254;}
        : image_button {key="top_right";width=10;aspect_ratio=1;fixed_width=true;color=254;}
        spacer_0;
      }
      spacer;
    }
  }
  spacer;
  : row {:spacer{width=17;}cancel_button;help_button;spacer_1;}
}


