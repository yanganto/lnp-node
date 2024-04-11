{ self, ... }: {
    perSystem = { config, self', pkgs, ... }: rec {
      packages = {
        lnp-cli = pkgs.callPackage ./lnp-cli.nix {
          inherit self;
        };
        lnpd = pkgs.callPackage ./lnpd.nix {
          inherit self;
        };
        peerd = pkgs.callPackage ./peerd.nix {
          inherit self;
        };
        routed = pkgs.callPackage ./routed.nix {
          inherit self;
        };
        signd = pkgs.callPackage ./signd.nix {
          inherit self;
        };
        watchd = pkgs.callPackage ./watchd.nix {
          inherit self;
        };
      };
  };
}
