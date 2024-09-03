// Feather disable all

var _string = "";
_string += $"BeadyEye {BEADY_VERSION}, {BEADY_DATE}\n";
_string += "Left mouse = Knockback\n";
_string += "Space = Move to origin\n";
_string += "Control = Move towards mouse\n";
_string += "I = Circular screenshake\n";
_string += "K = Axis screenshake\n";
_string += "M = Rectangular screenshake\n";

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(10, 10, string_width(_string)+30, string_height(_string)+30, false);

draw_set_color(c_white);
draw_set_alpha(1);
draw_text(20, 20, _string);