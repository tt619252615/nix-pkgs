{ lib, buildPythonPackage, fetchPypi, setuptools, pythonOlder, autoPatchelfHook
, stdenv, libXext, libGL, libdrm, xorg }:

let
  url =
    "https://files.pythonhosted.org/packages/2c/db/5379d953d4918278b1f04a5a64b2c112bd7aae8f81021009da0dcb77173c/audioop_lts-0.2.1-cp313-cp313t-musllinux_1_2_aarch64.whl";
in buildPythonPackage rec {
  pname = "audioop-lts";
  version = "0.2.1";
  format = "wheel";

  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:1ywkb838vbgnr16xr6nza1x7y1ifb6pngmhj1a7ib8fc12r7h1hj";
  };

  buildInputs = [ setuptools ];

  #   pythonImportsCheck = [ "audioop_lts" ];

  meta = {
    description = "LTS Port of Python audioop";
    homepage = "https://pypi.org/project/audioop-lts/";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ ];
  };
}
