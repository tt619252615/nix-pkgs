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
              # pillow = python-final.callPackage ./pkgs/pillow { };
              cn2an = python-final.callPackage ./pkgs/cn2an { };
              funasr-onnx = python-final.callPackage ./pkgs/funasr-onnx { };
              edge-tts = python-final.callPackage ./pkgs/edge-tts { };
              tensorflow-addons =
                python-final.callPackage ./pkgs/tensorflow-addons { };
              onnx-tf = python-final.callPackage ./pkgs/onnx-tf { };
              imsearch = python-final.callPackage ./pkgs/imsearch { };
              openai-whisper =
                python-final.callPackage ./pkgs/openai-whisper { };
              lameenc = python-final.callPackage ./pkgs/lameenc { };
              cylimiter = python-final.callPackage ./pkgs/cylimiter { };
              audiomentations =
                python-final.callPackage ./pkgs/audiomentations { };
              deep-phonemizer =
                python-final.callPackage ./pkgs/deep-phonemizer { };
              vosk = python-final.callPackage ./pkgs/vosk { };
              mycroft-precise =
                python-final.callPackage ./pkgs/mycroft-precise { };
              pyglet = python-final.callPackage ./pkgs/pyglet { };
              proces = python-final.callPackage ./pkgs/proces { };
              standard-chunk =
                python-final.callPackage ./pkgs/standard-chunk { };
              standard-aifc = python-final.callPackage ./pkgs/standard-aifc { };
              arcade = python-final.callPackage ./pkgs/arcade { };
              pocketsphinx = python-final.callPackage ./pkgs/pocketsphinx { };
              pvporcupine = python-final.callPackage ./pkgs/pvporcupine { };
              groq = python-final.callPackage ./pkgs/groq { };
              audioop-lts = python-final.callPackage ./pkgs/audioop-lts { };
              pvrecorder = python-final.callPackage ./pkgs/pvrecorder { };
              speech-recognition =
                python-final.callPackage ./pkgs/speech-recognition { };
              pytiled-parser =
                python-final.callPackage ./pkgs/pytiled-parser { };
              sphinx-sitemap =
                python-final.callPackage ./pkgs/sphinx-sitemap { };
              sphinx-rtd-dark-mode =
                python-final.callPackage ./pkgs/sphinx-rtd-dark-mode { };
              RPi.GPIO = python-final.callPackage ./pkgs/rpi { };
              tushare = python-final.callPackage ./pkgs/tushare { };
            })
          ];
        };
      };
    } // inputs.utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ] (system:
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
          funasr-onnx = pkgs.python3Packages.funasr-onnx;
          edge-tts = pkgs.python3Packages.edge-tts;
          audiomentations = pkgs.python3Packages.audiomentations;
          openai-whisper = pkgs.python3Packages.openai-whisper;
          onnx-tf = pkgs.python3Packages.onnx-tf;
          cylimiter = pkgs.python3Packages.cylimiter;
          lameenc = pkgs.python3Packages.lameenc;
          vosk = pkgs.python3Packages.vosk;
          cn2an = pkgs.python3Packages.cn2an;
          mycroft_precise = pkgs.python3Packages.mycroft_precise;
          pyglet = pkgs.python3Packages.pyglet;
          groq = pkgs.python3Packages.groq;
          standard-aifc = pkgs.python3Packages.standard-aifc;
          standard-chunk = pkgs.python3Packages.standard-chunk;
          pocketsphinx = pkgs.python3Packages.pocketsphinx;
          audioop-lts = pkgs.python3Packages.audioop-lts;
          speech-recognition = pkgs.python3Packages.speech-recognition;
          proces = pkgs.python3Packages.proces;
          pvporcupine = pkgs.python3Packages.pvporcupine;
          pytiled-parser = pkgs.python3Packages.pytiled-parser;
          sphinx-sitemap = pkgs.python3Packages.sphinx-sitemap;
          pvrecorder = pkgs.python3Packages.pvrecorder;
          imsearch = pkgs.python3Packages.imsearch;
          sphinx-rtd-dark-mode = pkgs.python3Packages.sphinx-rtd-dark-mode;
          # ! you can use nix build .#tushare to install tushare
          tushare = pkgs.python3Packages.tushare;
          # pillow = pkgs.python3Packages.pillow;
          RPi.GPIO = pkgs.python3Packages.RPi.GPIO;
        };
      });
}
