{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "whitesur-cursors";
  version = "0-unstable-2025-04-05";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "WhiteSur-cursors";
    rev = "e190baf618ed95ee217d2fd45589bd309b37672b";
    hash = "sha256-hFtfq8F6KeqUEBlypPCr/EKq6rif/g868vJd8c06c1I=";
  };

  installPhase = ''
    runHook preInstall
    install -dm 755 $out/share/icons/WhiteSur-cursors
    cp -r dist/* $out/share/icons/WhiteSur-cursors
    runHook postInstall
  '';

  meta = {
    description = "X-cursor theme inspired by macOS and based on capitaine-cursors";
    homepage = "https://github.com/vinceliuice/WhiteSur-cursors";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ tomasajt ];
    platforms = lib.platforms.linux;
  };
}
