{
  description = "Provide extra Nix packages for wonder modules.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    {
      overlays = {
        # It is recommended that the downstream user apply overlays.default directly.
        default = final: prev: {
          pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
            (python-final: python-prev: rec {
              pillow = python-final.callPackage ./pkgs/pillow { };
              cn2an = python-final.callPackage ./pkgs/cn2an { };
              proces = python-final.callPackage ./pkgs/proces { };
              arcade =
                python-final.callPackage ./pkgs/arcade { inherit pillow; };
              pytiled-parser =
                python-final.callPackage ./pkgs/pytiled-parser { };
              sphinx-sitemap =
                python-final.callPackage ./pkgs/sphinx-sitemap { };
              sphinx-rtd-dark-mode =
                python-final.callPackage ./pkgs/sphinx-rtd-dark-mode { };
              RPi.GPIO = python-final.callPackage ./pkgs/rpi { };
            })
          ];
        };
      };
    } // inputs.utils.lib.eachSystem [ "aarch64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ self.overlays.default ];
        };
      in {
        devShells.default = pkgs.callPackage ./pkgs/dev-shell { };

        packages = pkgs.python3Packages // {
          arcade = pkgs.python3Packages.arcade;
          cn2an = pkgs.python3Packages.cn2an;
          proces = pkgs.python3Packages.proces;
          pytiled-parser = pkgs.python3Packages.pytiled-parser;
          sphinx-sitemap = pkgs.python3Packages.sphinx-sitemap;
          sphinx-rtd-dark-mode = pkgs.python3Packages.sphinx-rtd-dark-mode;
          pillow = pkgs.python3Packages.pillow;
          RPi.GPIO = pkgs.python3Packages.RPi.GPIO;
        };
      });
}
