{ lib, buildPythonPackage, fetchPypi, setuptools, sphinx, build, flake8
, pre-commit, pytest, tox, }:

buildPythonPackage rec {
  pname = "sphinx-sitemap";
  version = "2.6.0";
  pyproject = true;

  src = fetchPypi {
    pname = "sphinx_sitemap";
    inherit version;
    hash = "sha256-XgxmufLjce3oDGWYZqnqrTN9RqsCgC+cfl97xYk8KNI=";
  };

  build-system = [ setuptools ];

  buildInputs = [ sphinx ];

  pythonImportsCheck = [ "sphinx_sitemap" ];

  meta = {
    description = "Sitemap generator for Sphinx";
    homepage = "https://pypi.org/project/sphinx-sitemap/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
