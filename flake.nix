{
  description = "Todd's System Configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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

    homeConfigurations = {
      yngtdd = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        
        modules = [ ./user/yngtdd/home.nix ];
      };
    };
  
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        
        modules = [ ./system/configuration.nix ];
      };
    };
  };
}
