{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, proces, }:

let
  url =
    "https://files.pythonhosted.org/packages/02/5c/03f0cb3d31c132e09f5523c76e963436fcd13c0318428021bd210f7bb216/cn2an-0.5.23-py3-none-any.whl";
in buildPythonPackage rec {
  pname = "cn2an";
  version = "0.5.23";
  format = "wheel";

  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:1gqw3wj6jmwki10c6fc1i05lzykykgv53aydih1mqxkn6v2v76mi";
  };

  buildInputs = [ setuptools wheel proces ];

  dependencies = [ proces ];

  pythonImportsCheck = [ "cn2an" ];

  meta = {
    description = "Convert Chinese numerals and Arabic numerals";
    homepage = "https://pypi.org/project/cn2an/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
