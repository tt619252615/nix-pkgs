{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  onnxruntime,
  requests,
  scikit-learn,
  scipy,
  tflite-runtime,
  tqdm,
  acoustics,
  audiomentations,
  datasets,
  deep-phonemizer,
  mutagen,
  onnx,
  onnx-tf,
  pronouncing,
  protobuf,
  pytest,
  pytest-cov,
  pytest-flake8,
  pytest-mypy,
  pyyaml,
  speechbrain,
  tensorflow-cpu,
  tensorflow-probability,
  torch,
  torch-audiomentations,
  torchaudio,
  torchinfo,
  torchmetrics,
  flake8,
  mock,
  types-mock,
  types-pyyaml,
  types-requests,
}:

buildPythonPackage rec {
  pname = "openwakeword";
  version = "0.6.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-NoWNkPEYPjB0hVl6kSpOPDOEsU6pkj+D/q/658FWVWU=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    onnxruntime
    requests
    scikit-learn
    scipy
    tflite-runtime
    tqdm
  ];

  optional-dependencies = {
    full = [
      acoustics
      audiomentations
      datasets
      deep-phonemizer
      mutagen
      onnx
      onnx-tf
      pronouncing
      protobuf
      pytest
      pytest-cov
      pytest-flake8
      pytest-mypy
      pyyaml
      speechbrain
      tensorflow-cpu
      tensorflow-probability
      torch
      torch-audiomentations
      torchaudio
      torchinfo
      torchmetrics
      tqdm
    ];
    test = [
      flake8
      mock
      pytest
      pytest-cov
      pytest-flake8
      pytest-mypy
      types-mock
      types-pyyaml
      types-requests
    ];
  };

  pythonImportsCheck = [
    "openwakeword"
  ];

  meta = {
    description = "An open-source audio wake word (or phrase) detection framework with a focus on performance and simplicity";
    homepage = "https://pypi.org/project/openwakeword";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}