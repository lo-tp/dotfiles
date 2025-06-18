{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # Use `github:nix-darwin/nix-darwin/nix-darwin-24.11` to use Nixpkgs 24.11
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, nixpkgs, ... }:
  let
    configuration = { lib, pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
        pkgs.postgresql_17
        pkgs.fzf
        pkgs.pyright
      ];

      # Necessary for using flakes on this system
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin
      programs.zsh.enable = true;
      nix.enable = false;

      # Set Git commit hash for darwin-version
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          # Add additional package names here
          "obsidian"
        ];

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        taps = [
          "homebrew/bundle"
          "hashicorp/tap"
        ];
        brews = [
          "the_silver_searcher"
          "whisper-cpp"
          "ffmpeg"
          "envoy"
          "buf"
          "go"
          "gradle"
          "helm"
          "helmfile"
          "htop"
          "jdtls"
          "k9s"
          "kubernetes-cli"
          "python@3.13"
          "terraform"
          "smartmontools"
          "ollama"
          "yt-dlp"
          "iperf3"
          "neovim"
          "node"
          "nvm"
          "openjdk"
          "openssl@1.1"
          "openssl@3"
          "protobuf"
          "reattach-to-user-namespace"
          "terraform"
          "tmux"
          "tmuxinator"
          "tree-sitter"
          "wget"
          "xclip"
          "pipx"
          "awscli"
          "telnet"
          "aider"
          "ta-lib"
        ];
        casks = [
          "dbeaver-community"
          "google-chrome"
          "visual-studio-code"
          "aethersx2"
          "aldente"
          "alt-tab"
          "anki"
          "calibre"
          "coconutbattery"
          "digikam"
          "istat-menus"
          "licecap"
          "omnidisksweeper"
          "shottr"
          "obsidian"
        ];
      };

      system = {
        primaryUser = "lotp";
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Shiqis-MacBook-Pro
    darwinConfigurations."Shiqis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "lotp";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
