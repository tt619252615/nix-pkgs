{ lib, buildPythonPackage, fetchPypi, setuptools, onnxruntime, requests
, scikit-learn, scipy, tflite-runtime, tqdm, acoustics, audiomentations
, datasets, deep-phonemizer, mutagen, onnx, onnx-tf, pronouncing, protobuf
, pytest, pytest-cov, pytest-flake8, pytest-mypy, pyyaml, speechbrain
, tensorflow-cpu, tensorflow-probability, torch, torch-audiomentations
, torchaudio, torchinfo, torchmetrics, flake8, mock, types-mock, types-pyyaml
, types-requests, }:

buildPythonPackage rec {
  pname = "vosk";
  version = "0.3.45";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-NoWNkPEYPjB0hVl6kSpOPDOEsU6pkj+D/q/658FWVWU=";
  };

  build-system = [ setuptools ];

  pythonImportsCheck = [ "vosk" ];

  meta = {
    description = "This is a Python module for Vosk";
    homepage = "https://pypi.org/project/vosk";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
