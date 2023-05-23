{
  description = "Todd's System Configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
  };

  outputs = { nixpkgs, home-manager, ... }: 
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
      # pkgs = nixpkgs.legacyPackages.${system}
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
        
        modules = [ ./system/configuration.nix ];
      };
    };
  };
}
