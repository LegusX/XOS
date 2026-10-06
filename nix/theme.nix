{ pkgs, ... }:

{
  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    cursorTheme = {
      package = pkgs.vimix-cursors;
      name = "Vimix-Cursors";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.vimix-cursors;
    name = "Vimix-Cursors";
    size = 24;
  };
}