{
  description = "Flake to install YouTube Music v3.7.5";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "youtube-music";
      version = "3.7.5";

      src = pkgs.fetchurl {
        url = "https://github.com/th-ch/youtube-music/releases/download/v3.7.5/youtube-music-3.7.5.tar.gz";
        sha256 = "sha256-OFT+skKuOsgfLhdrrx+bdVkmJJHjzlRnzLBp7uGb2ok="; # Corrected base32 hash
      };

      buildInputs = [ pkgs.nodejs pkgs.electron ];
      nativeBuildInputs = [ pkgs.unzip pkgs.makeWrapper ];

      unpackPhase = ''
        tar -xzf $src
      '';

      installPhase = ''
        mkdir -p $out/opt/youtube-music
        cp -r * $out/opt/youtube-music
        makeWrapper ${pkgs.electron}/bin/electron $out/bin/youtube-music \
          --add-flags "$out/opt/youtube-music"
      '';

      meta = with pkgs.lib; {
        description = "YouTube Music desktop app";
        homepage = "https://github.com/th-ch/youtube-music";
        license = licenses.mit;
        platforms = platforms.linux;
      };
    };
  };
}
