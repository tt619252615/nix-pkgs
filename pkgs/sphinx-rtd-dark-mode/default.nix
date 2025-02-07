{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, sphinx-rtd-theme, }:

buildPythonPackage rec {
  pname = "sphinx-rtd-dark-mode";
  version = "1.3.0";
  pyproject = true;

  src = fetchPypi {
    pname = "sphinx_rtd_dark_mode";
    inherit version;
    hash = "sha256-AnK/PZ72IJIa3GflY0pmlpQZ50TahOoYgwraz9sWDqg=";
  };

  build-system = [ setuptools wheel ];

  buildInputs = [ sphinx-rtd-theme ];

  pythonImportsCheck = [ "sphinx_rtd_dark_mode" ];

  meta = {
    description = "Dark mode for the Sphinx Read the Docs theme";
    homepage = "https://pypi.org/project/sphinx-rtd-dark-mode/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
