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
              arcade =
                python-final.callPackage ./pkgs/arcade { inherit pillow; };
              pytiled-parser =
                python-final.callPackage ./pkgs/pytiled-parser { };
              sphinx-sitemap =
                python-final.callPackage ./pkgs/sphinx-sitemap { };
              sphinx-rtd-dark-mode =
                python-final.callPackage ./pkgs/sphinx-rtd-dark-mode { };
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

        packages = {
          inherit (pkgs.python3Packages)
            arcade pytiled-parser sphinx-sitemap sphinx-rtd-dark-mode pillow;
        };
      });
}
