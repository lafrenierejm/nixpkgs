{
  buildGoModule,
  fetchFromGitHub,
  lib,
  updateGoGitHubModule,
  versionCheckHook,
}:

buildGoModule (finalAttrs: {
  pname = "mockgen";
  version = "0.6.0";
  commitSha = "2d1c58167e30f380cf78e44a43b100a14767e817";
  commitDate = "2025-08-18T14:58:59Z";

  src = fetchFromGitHub {
    owner = "uber-go";
    repo = "mock";
    tag = "v${finalAttrs.version}";
    hash = "sha256-gYUL+ucnKQncudQDcRt8aDqM7xE5XSKHh4X0qFrvfGs=";
  };

  vendorHash = "sha256-Cf7lKfMuPFT/I1apgChUNNCG2C7SrW7ncF8OusbUs+A=";

  env.CGO_ENABLED = 0;

  subPackages = [ "mockgen" ];

  ldflags = [
    "-X=main.version=${finalAttrs.version}"
    "-X=main.date=${finalAttrs.commitDate}"
    "-X=main.commit=${finalAttrs.commitSha}"
  ];

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "-version";
  doInstallCheck = true;

  passthru.updateScript = updateGoGitHubModule {
    inherit (finalAttrs) pname;
    inherit (finalAttrs.src) owner repo;
  };

  meta = {
    description = "Mocking framework for the Go programming language";
    homepage = "https://github.com/uber-go/mock";
    changelog = "https://github.com/uber-go/mock/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ bouk ];
    mainProgram = "mockgen";
  };
})
