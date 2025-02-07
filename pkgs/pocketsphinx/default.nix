{ lib, buildPythonPackage, fetchFromGitHub, cython, scikit-build-core
, sounddevice, }:

let
  url =
    "https://files.pythonhosted.org/packages/be/63/e91c6c77a6af3049fd168e42cae868bad71e2248a8f7a3cfedfe50d95f6c/pocketsphinx-5.0.4-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl";
in buildPythonPackage rec {
  pname = "pocketsphinx";
  version = "5.0.4";
  format = "wheel";

  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:1659phy5bxycvwvq7g1i2l1jw99sika21rbgv45j606fnvc1lm53";
  };

  buildInputs = [ cython scikit-build-core ];

  #   pythonImportsCheck = [ "pocketsphinx" ];

  meta = {
    description = "A small speech recognizer";
    homepage = "https://github.com/cmusphinx/pocketsphinx";
    changelog =
      "https://github.com/cmusphinx/pocketsphinx/blob/${src.rev}/NEWS";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
  };
}
