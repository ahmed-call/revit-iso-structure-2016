BLOCKS : dialog {
         label = "BLOCKS - Get The Quantity of Blocks using filters. by Munir Hussain";
         : column {
           : boxed_row {
             : list_box { 
               label = "Filter by Block Name";
               key = "blklist";  
               height = 10;
               width = 30;
               multiple_select = true;
               value = 0;
             }
             : list_box { 
               label = "Filter by Attribute Tag";
               key = "taglist";  
               height = 10;
               width = 30;
               multiple_select = true;
               value = 0;
             }
             : list_box { 
               label = "Filter by Attribute Value";
               key = "vallist";  
               height = 10;
               width = 30;
               multiple_select = true;
               value = 0;
             }
           }
           : boxed_column {
             : list_box{
               label = "Results";
               key = "totallist";
               height = 15;
               width = 90;
               multiple_select = false;
               fixed_width_font = true;
             }
           }
           : column {
             : boxed_row {
               : button { 
                 key = "cancel";
                 label = "Exit";
                 is_default = false;
                 is_cancel = true;
               }
               : button { 
                 key = "write";
                 label = "Write data to File";
                 is_default = false;
                 is_cancel = false;
               }
             }
           }
         }
}