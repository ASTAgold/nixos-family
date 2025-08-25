{
  description = "NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, compose2nix, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.stewie = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./hosts/stewie/configuration.nix
        {
        environment.systemPackages = [ inputs.compose2nix.packages.x86_64-linux.default ];
        }
      ];
    };
    
    nixosConfigurations.peter = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./hosts/peter/configuration.nix      ];
    };
  };
}
