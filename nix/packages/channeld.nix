{ self, lib, pkgs, msrvCraneLib }:
let
  cargoToml = "${src}/Cargo.toml";
  nativeBuildInputs = with pkgs; [
    openssl
    pkg-config
  ];
  cargoExtraArgs = "--bin lnpd";
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
  name = "lnpd";
  inherit src cargoToml cargoArtifacts cargoExtraArgs buildInputs nativeBuildInputs outputHashes;
  strictDeps = true;
  doCheck = false;
}
