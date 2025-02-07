{ lib, buildPythonPackage, fetchPypi, hatch-fancy-pypi-readme, hatchling, anyio
, distro, httpx, pydantic, sniffio, typing-extensions, }:

buildPythonPackage rec {
  pname = "groq";
  version = "0.18.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-jizP6kBtaLNSWvS3wOMh/LPSpz/GC7cLQVbmzYjHLwM=";
  };

  buildInputs = [
    hatch-fancy-pypi-readme
    hatchling
    typing-extensions
    pydantic
    httpx
    sniffio
  ];

  #   pythonImportsCheck = [ "groq" ];

  meta = {
    description = "The official Python library for the groq API";
    homepage = "https://pypi.org/project/groq/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
