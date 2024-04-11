{ self, lib, pkgs, msrvCraneLib }:
let
  name = "lnpd";
  cargoToml = "${src}/Cargo.toml";
  nativeBuildInputs = with pkgs; [
    openssl
    pkg-config
  ];
  cargoExtraArgs = "--bin ${name}";
  outputHashes = {
  };
  src = self;
  buildInputs = with pkgs; [
    zeromq
    pkg-config
  ];
  cargoArtifacts = msrvCraneLib.buildDepsOnly {
    inherit src cargoToml buildInputs nativeBuildInputs cargoExtraArgs outputHashes;
  };
in
msrvCraneLib.buildPackage {
  inherit name src cargoToml cargoArtifacts cargoExtraArgs buildInputs nativeBuildInputs outputHashes;
  strictDeps = true;
  doCheck = false;
}
