let
  colors = {
    black = "rgb(0, 0, 0)";
    white = "rgb(255, 255, 255)";
    gray = "rgb(146, 131, 116)";
    gray_pale = "rgb(168, 153, 132)";
    red = "rgb(204, 36, 29)";
    red_pale = "rgb(251, 73, 52)";
    green = "rgb(152, 151, 26)";
    green_pale = "rgb(184, 187, 38)";
    yellow = "rgb(215, 153, 33)";
    yellow_pale = "rgb(250, 189, 47)";
    blue = "rgb(69, 133, 136)";
    blue_pale = "rgb(131, 165, 152)";
    purple = "rgb(177, 98, 134)";
    purple_pale = "rgb(211, 134, 155)";
    aqua = "rgb(104, 157, 106)";
    aqua_pale = "rgb(142, 192, 124)";
    orange = "rgb(214, 93, 14)";
    orange_pale = "rgb(254, 128, 25)";
    bg_0 = "rgb(29, 32, 33)";
    bg_1 = "rgb(40, 40, 40)";
    bg_2 = "rgb(60, 56, 54)";
    bg_3 = "rgb(80, 73, 69)";
    bg_4 = "rgb(102, 92, 84)";
    bg_5 = "rgb(124, 111, 100)";
    fg_0 = "rgb(251, 241, 199)";
    fg_1 = "rgb(235, 219, 178)";
    fg_2 = "rgb(213, 196, 161)";
    fg_3 = "rgb(189, 174, 147)";
    fg_4 = "rgb(168, 153, 132)";
  };
in {
  background_dark = colors.bg_1;
  background_light = colors.bg_5;
  waybar = {
    background_right = colors.bg_2;
    border_right = colors.orange;
    text_right = colors.fg_1;
    icons = colors.blue;
    clock_text = colors.bg_1;
    clock_background = colors.fg_2;
    clock_border = colors.bg_1;
    background_alert = colors.orange;
    text_alert = colors.bg_1;
    workspace_background = colors.bg_1;
    workspace_border = colors.orange;
    workspace_active_background = colors.bg_5;
    workspace_active_text = colors.fg_0;
    workspace_inactive_background = colors.bg_3;
    workspace_inactive_text = colors.fg_4; 
  };
  
}