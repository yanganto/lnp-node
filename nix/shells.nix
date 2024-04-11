{
  perSystem = { self, pkgs, ...}: {
    devShells = rec {
      default = dev;
      dev = pkgs.mkShell {
        packages = with pkgs; [
          pkg-config
          zeromq
          msrvRust
        ];
      };
    };
  };
}
