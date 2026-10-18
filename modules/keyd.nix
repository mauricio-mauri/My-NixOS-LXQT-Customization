{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(nav, esc)";
        };
        nav = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          y = "home";
          o = "end";
          u = "pageup";
          n = "pagedown";
          i = "insert";
          backspace = "delete";
        };
      };
    };
  };
}
