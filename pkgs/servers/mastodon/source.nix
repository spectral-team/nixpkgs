# This file was generated by pkgs.mastodon.updateScript.
{ fetchgit, applyPatches }: let
  src = fetchgit {
    url = "https://github.com/mastodon/mastodon.git";
    rev = "v4.0.2";
    sha256 = "1szb11bss66yvh8750pzib3r0w1fm9h84sf5daqsnbm871hgzlw0";
  };
in applyPatches {
  inherit src;
  patches = [];
}
