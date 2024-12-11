{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = {lib, pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
          pkgs.postgresql_17
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfreePredicate = pkg:
         builtins.elem (lib.getName pkg) [
           # Add additional package names here
           "obsidian"
         ];
      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        taps = ["hashicorp/tap" ];
        brews = ["the_silver_searcher" "envoy" "buf" "fzf" "go" "gradle" "helm" "helmfile" "htop" "jdtls" "k9s" "kubernetes-cli" "python@3.13" "terraform"
        "neovim" "node" "nvm" "openjdk" "openssl@1.1" "openssl@3" "protobuf" "reattach-to-user-namespace" "terraform" "tmux" "tmuxinator" "tree-sitter" "wget" "xclip"
        ];
        casks = ["aethersx2" "aldente" "alt-tab" "anki" "calibre" "coconutbattery" "digikam" "istat-menus" "licecap" "omnidisksweeper" "shottr" "obsidian" ];
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Shiqis-MacBook-Pro
    darwinConfigurations."Shiqis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
