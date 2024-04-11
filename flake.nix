{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./nix/packages/flake-module.nix
        ./nix/shells.nix
      ];
      systems = [ "x86_64-linux" ];
      perSystem = { pkgs, system, ... }:
      let
        cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
      in
      {
        _module.args.pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          overlays = [
            (import inputs.rust-overlay)
            (_self: super: rec {
              msrvRust = super.rust-bin.stable."${cargoToml.package.rust-version}".default;
              msrvCraneLib = (inputs.crane.mkLib pkgs).overrideToolchain msrvRust;
            })
          ];
        };
      };
    };
}
