{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, protobuf
, systemd
, libpulseaudio
, openssl
}:

rustPlatform.buildRustPackage {
  pname = "monsgeek-driver";
  version = "unstable-2026-09-15";

  src = fetchFromGitHub {
    owner = "echtzeit-solutions";
    repo = "monsgeek-akko-linux";
    rev = "79c45f11dcc0fdd24d6075a0f30f5dabbc748c9b";
    hash = "sha256-2adOfAvguM2YkTAJaFhnqJKhXiLxDP43o717RhXTFjA=";
  };

  cargoRoot = "iot_driver_linux";
  buildAndTestSubdir = "iot_driver_linux";
  cargoHash = "sha256-P41tsAIfDKQ76qXzjm5t4ZYckb7kdJfpXy56LOdi2vQ=";

  buildNoDefaultFeatures = true;
  buildFeatures = [ "firmware-api" "notify" ];

  nativeBuildInputs = [ pkg-config protobuf ];
  buildInputs = [ systemd libpulseaudio openssl ];

  doCheck = false;

  postInstall = ''
    mkdir -p $out/lib/udev/rules.d
    sed '/BPF battery service/,$d' $src/udev/99-monsgeek.rules > $out/lib/udev/rules.d/99-monsgeek.rules
  '';

  meta = {
    description = "Linux driver for MonsGeek/Akko magnetic keyboards (CLI, TUI and gRPC server)";
    homepage = "https://github.com/echtzeit-solutions/monsgeek-akko-linux";
    license = lib.licenses.gpl3Only;
    mainProgram = "iot_driver";
    platforms = lib.platforms.linux;
  };
}
