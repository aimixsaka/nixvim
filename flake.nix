{
  description = "A nixvim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = {
    nixvim,
    flake-parts,
    rust-overlay,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem = {system, ...}: let
        overlays = [(import rust-overlay)];
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        baseNixvimModule = {
          inherit pkgs;
          module = {pkgs, ...}: {
            imports = [./config];
            extraPackages = with pkgs; [sops];
          };
          extraSpecialArgs = {};
        };
        miniumNvimModule = {
          inherit pkgs;
          module = {...}: {
            imports = [./config/minium];
          };
          extraSpecialArgs = {};
        };
        rustNixvimModule = {
          inherit pkgs;
          module = {pkgs, ...}: {
            imports = [
              ./config
              ./config/rust
            ];
            extraPackages = with pkgs; [
              sops
              rust-bin.stable.latest.default
            ];
          };
          extraSpecialArgs = {};
        };
        goNixvimModule = {
          inherit pkgs;
          module = {pkgs, ...}: {
            imports = [
              ./config
              ./config/golang
            ];
            extraPackages = with pkgs; [sops];
          };
          extraSpecialArgs = {};
        };
        pythonNixvimModule = {
          inherit pkgs;
          module = {pkgs, ...}: {
            imports = [
              ./config
              ./config/python
            ];
            extraPackages = with pkgs; [sops];
          };
          extraSpecialArgs = {};
        };
        javascriptNixvimModule = {
          inherit pkgs;
          module = {pkgs, ...}: {
            imports = [
              ./config
              ./config/javascript
            ];
            extraPackages = with pkgs; [sops];
          };
          extraSpecialArgs = {};
        };
        allNixVimModule = {
          inherit pkgs;
          module = {pkgs, ...}: {
            imports = [
              ./config
              ./config/rust
              ./config/golang
              ./config/python
              ./config/javascript
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
      in {
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
        };
      };
    };
}
