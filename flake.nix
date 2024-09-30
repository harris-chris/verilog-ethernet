{
  description = "verilog-ethernet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = {
    self
    , nixpkgs
  }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ ];
      };
      inherit (pkgs) lib;
    in
    {
      packages.${system} = {
        adm_pcie_9v3_10g = with pkgs; callPackage ./nix/adm_pcie_9v3.nix { build10g = true; };
        adm_pcie_9v3_25g = with pkgs; callPackage ./nix/adm_pcie_9v3.nix { };
      };
    };
}
