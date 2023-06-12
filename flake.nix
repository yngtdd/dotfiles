{
  description = "Todd's System Configuration";
  
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      hyprland.url = "github:hyprwm/Hyprland";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs"; 
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    
    lib = nixpkgs.lib;
        
  in {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeManagerConfigurations = {
      inherit system pkgs;
      modules = [ 
        ./user/yngtdd/home.nix 

        {
          home = {
            username = "yngtdd";
            homeDirectory = "/home/yngtdd";
            stateVersion = "22.11";
          };
        }
      ];
    };
  
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        
        modules = [ 
            ./system/configuration.nix 
            
            hyprland.nixosModules.default 
            {
              programs.hyprland.enable = true;
              programs.hyprland.nvidiaPatches = true;
              programs.hyprland.xwayland.enable = true;
            }
        ];
      };
    };
  };
}
