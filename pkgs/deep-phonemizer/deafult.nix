{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, }:

buildPythonPackage rec {
  pname = "deep-phonemizer";
  version = "0.0.19";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-b0evVY8KUe7CAID8Lc6ZkBDZNCWGrUI1BJbaC6FhDsM=";
  };

  build-system = [ setuptools wheel ];

  pythonImportsCheck = [ "deep_phonemizer" ];

  meta = {
    description = "Grapheme to phoneme conversion with deep learning";
    homepage = "https://pypi.org/project/deep-phonemizer/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
