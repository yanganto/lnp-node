{ self, lib, pkgs, msrvCraneLib }:
let
  cargoToml = "${src}/Cargo.toml";
  nativeBuildInputs = with pkgs; [
    openssl
    pkg-config
  ];
  cargoExtraArgs = "--bin lnp-cli";
  outputHashes = {};
  # TODO trim the source let build quick for the user only need lnp-cli
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
  name = "lnp-cli";
  inherit src cargoToml cargoArtifacts cargoExtraArgs buildInputs nativeBuildInputs outputHashes;
  strictDeps = true;
  doCheck = false;
}
