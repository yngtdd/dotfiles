{ pkgs, ... }: {
  # home.username = "yngtdd";
  # home.homeDirectory = "/home/yngtdd";
  home.packages = with pkgs; [
    alacritty
    bat
    blender
    git
    git-crypt
    gnupg
    helix
    nushell
    starship
    xclip
  ]; 
  
  # home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
