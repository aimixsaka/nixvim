{
  description = "A nixvim configuration";
  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/1da52dd49a127ad74486b135898da2cef8c62665";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs =
    {
      nixvim,
      flake-parts,
      rust-overlay,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem =
        { system, ... }:
        let
          overlays = [ (import rust-overlay) ];
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          baseNixvimModule = {
            inherit pkgs;
            module =
              { pkgs, ... }:
              {
                imports = [ ./config ];
                extraPackages = with pkgs; [ sops ];
              };
            extraSpecialArgs = { };
          };
          miniumNvimModule = {
            inherit pkgs;
            module =
              { ... }:
              {
                imports = [ ./config/minium ];
              };
            extraSpecialArgs = { };
          };
          rustNixvimModule = {
            inherit pkgs;
            module =
              { pkgs, ... }:
              {
                imports = [
                  ./config
                  ./config/rust
                ];
                extraPackages = with pkgs; [
                  sops
                  rust-bin.stable.latest.default
                ];
              };
            extraSpecialArgs = { };
          };
          goNixvimModule = {
            inherit pkgs;
            module =
              { pkgs, ... }:
              {
                imports = [
                  ./config
                  ./config/golang
                ];
                extraPackages = with pkgs; [ sops ];
              };
            extraSpecialArgs = { };
          };
          pythonNixvimModule = {
            inherit pkgs;
            module =
              { pkgs, ... }:
              {
                imports = [
                  ./config
                  ./config/python
                ];
                extraPackages = with pkgs; [ sops ];
              };
            extraSpecialArgs = { };
          };
          javascriptNixvimModule = {
            inherit pkgs;
            module =
              { pkgs, ... }:
              {
                imports = [
                  ./config
                  ./config/javascript
                ];
                extraPackages = with pkgs; [ sops ];
              };
            extraSpecialArgs = { };
          };
          cNixvimModule = {
            inherit pkgs;
            module =
              { pkgs, ... }:
              {
                imports = [
                  ./config
                  ./config/c
                ];
              };
          };
          allNixVimModule = {
            inherit pkgs;
            module =
              { pkgs, ... }:
              {
                imports = [
                  ./config
                  ./config/rust
                  ./config/golang
                  ./config/python
                  ./config/javascript
                  ./config/c
                ];
              };
          };
          pkgs = import inputs.nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
          baseNvim = nixvim'.makeNixvimWithModule baseNixvimModule;
          miniumNvim = nixvim'.makeNixvimWithModule miniumNvimModule;
          fullNvim = nixvim'.makeNixvimWithModule allNixVimModule;
          rustNvim = nixvim'.makeNixvimWithModule rustNixvimModule;
          goNvim = nixvim'.makeNixvimWithModule goNixvimModule;
          pythonNvim = nixvim'.makeNixvimWithModule pythonNixvimModule;
          javascriptNvim = nixvim'.makeNixvimWithModule javascriptNixvimModule;
          cNixvimNvim = nixvim'.makeNixvimWithModule cNixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule baseNixvimModule;
          };
          packages = {
            default = baseNvim;
            minium = miniumNvim;
            full = fullNvim;
            rust = rustNvim;
            golang = goNvim;
            python = pythonNvim;
            javascript = javascriptNvim;
            c = cNixvimNvim;
          };
        };
    };
}
