{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, pillow, pyglet, pymunk
, pytiled-parser, black, coverage, coveralls, docutils, mypy, pygments, pyright
, pytest, pytest-cov, pytest-mock, ruff, sphinx, sphinx-autobuild
, sphinx-copybutton, sphinx-rtd-dark-mode, sphinx-rtd-theme, sphinx-sitemap
, typer, pyyaml, attrs, typing-extensions, stdenv, libXext, libGL, libdrm, xorg
, libGLU }:

let
  url =
    "https://files.pythonhosted.org/packages/37/0d/17b76efd6b0662cf792cf4933e9fc31a25ed396469e2b7aef8bbb51e03f1/arcade-3.0-py3-none-any.whl";
in buildPythonPackage rec {
  pname = "arcade";
  version = "3.0.0";
  format = "wheel";

  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:0clqwlhppl8cr38ipqn90hyy90xxn85yzw4sclyhbqhk70q1arbc";
  };

  buildInputs =
    [ pillow pyglet pymunk pytiled-parser attrs typing-extensions libGL ];
  doCheck = false;
  # pythonImportsCheck = [ "arcade" ];

  meta = {
    description = "Arcade Game Development Library";
    homepage = "https://pypi.org/project/arcade/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
