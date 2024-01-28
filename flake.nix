{
  description = "JupyterLabDevShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    devShell.${system} = pkgs.mkShell {
      CHROMEDRIVER = "${pkgs.chromedriver}/bin/chromedriver";
      CHROMIUM = "${pkgs.chromium}/bin/chromium";

      packages = with pkgs; [
        bashInteractive

        (python3.withPackages (ps: with ps; with python3Packages; [
          jupyter

          matplotlib
          beautifulsoup4
          requests
          selenium
        ]))

        chromium
        chromedriver
      ];

      shellHook = "jupyter notebook &";
    };
  };
}
