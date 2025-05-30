{
  lib,
  buildPythonPackage,
  fetchPypi,

  # build-system
  setuptools,
  versioneer,

  # dependencies
  httpx,
  httpx-ws,
  httpx-sse,
  pydantic,
  pillow,

  # optional dependencies
  fastapi,
  gitignore-parser,
  openapi-spec-validator,
  prance,
  safetensors,
  tabulate,
  torch,
  tqdm,
}:

buildPythonPackage rec {
  pname = "fireworks-ai";
  version = "0.15.13";
  pyproject = true;

  # no source available
  src = fetchPypi {
    pname = "fireworks_ai";
    inherit version;
    hash = "sha256-ZZSF4R1HOYpNmKnL2OPWoUwdSJJ2j2e3+hzW0QH55io=";
  };

  build-system = [
    setuptools
    versioneer
  ];

  dependencies = [
    httpx
    httpx-ws
    httpx-sse
    pydantic
    pillow
  ];

  optional-dependencies = {
    flumina = [
      fastapi
      gitignore-parser
      openapi-spec-validator
      prance
      safetensors
      tabulate
      torch
      tqdm
    ];
  };

  # no tests available
  doCheck = false;

  pythonImportsCheck = [
    "fireworks"
  ];

  meta = {
    description = "Client library for the Fireworks.ai platform";
    homepage = "https://pypi.org/project/fireworks-ai/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ sarahec ];
  };
}
