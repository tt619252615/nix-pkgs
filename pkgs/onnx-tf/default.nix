{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, onnx, pyyaml
, tensorflow-addons, }:

buildPythonPackage rec {
  pname = "onnx-tf";
  version = "1.10.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-7ugMcqkh3FNFzd0DAAG2WFUmTWWVlLHRgLKVhAXhAmk=";
  };

  build-system = [ setuptools wheel ];

  dependencies = [ onnx pyyaml tensorflow-addons ];

  pythonImportsCheck = [ "onnx_tf" ];

  meta = {
    description = "Tensorflow backend for ONNX (Open Neural Network Exchange";
    homepage = "https://pypi.org/project/onnx-tf/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
