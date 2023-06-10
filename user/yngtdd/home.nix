{ pkgs, ... }: {
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
  
  programs.home-manager.enable = true;
}
