{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, }:

let
  url =
    "https://files.pythonhosted.org/packages/c4/9e/4716d4737a4a6a3de306c97f3cd6040e66ef23ad8b6b8fca80190dbcc3ad/pvporcupine-3.0.5-py3-none-any.whl";
in buildPythonPackage rec {
  pname = "pvporcupine";
  version = "3.0.5";
  format = "wheel";
  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:0mikf80hzy8dsp50z0q449kd3pfwxxh3ys0r5r4jwqhsifik22xq";
  };

  buildInputs = [ setuptools wheel ];

  # nativeBuildInputs = [ lib.cleanSource ];

  pythonImportsCheck = [ "pvporcupine" ];

  meta = {
    description = "Porcupine wake word engine";
    homepage = "https://pypi.org/project/pvporcupine/";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
  };
}
