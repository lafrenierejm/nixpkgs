{
  lib,
  buildGoModule,
  fetchFromGitHub,
  updateGoGitHubModule,
  versionCheckHook,
}:

buildGoModule (finalAttrs: {
  pname = "chroma";
  version = "2.23.1";
  commitSha = "5b4188b4057fe666b2501704f40c38b5a0e4d496";
  commitDate = "2026-01-23T02:31:21Z";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Znmcds0ru9VyH/0qE7KnW7l0QeRDoh9PnUPHTYPAA6w=";
  };

  vendorHash = "sha256-3mmO5hjjIqVqKiSOrFFQH8OaQTviJVHrznMYsgHP82A=";

  modRoot = "./cmd/chroma";

  ldflags = [
    "-X=main.version=${finalAttrs.version}"
    "-X=main.commit=${finalAttrs.commitSha}"
    "-X=main.date=${finalAttrs.commitDate}"
  ];

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;

  passthru.updateScript = updateGoGitHubModule {
    inherit (finalAttrs) pname;
    inherit (finalAttrs.src) owner repo;
  };

  meta = {
    homepage = "https://github.com/alecthomas/chroma";
    description = "General purpose syntax highlighter in pure Go";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ sternenseemann ];
    mainProgram = "chroma";
  };
})
