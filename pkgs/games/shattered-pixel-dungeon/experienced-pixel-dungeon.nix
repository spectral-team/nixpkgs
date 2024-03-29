{ callPackage
, fetchFromGitHub
}:

callPackage ./generic.nix rec {
  pname = "experienced-pixel-dungeon";
  version = "2.15.3";

  src = fetchFromGitHub {
    owner = "TrashboxBobylev";
    repo = "Experienced-Pixel-Dungeon-Redone";
    rev = "ExpPD-${version}";
    hash = "sha256-qwZk08e+GX8YAVnOZCQ6sIIfV06lWn5bM6/PKD0PAH0=";
  };

  postPatch = ''
    substituteInPlace build.gradle \
      --replace "gdxControllersVersion = '2.2.3-SNAPSHOT'" "gdxControllersVersion = '2.2.3'"
  '';

  depsHash = "sha256-MUUeWZUCVPakK1MJwn0lPnjAlLpPWB/J17Ad68XRcHg=";

  desktopName = "Experienced Pixel Dungeon";

  meta = {
    homepage = "https://github.com/TrashboxBobylev/Experienced-Pixel-Dungeon-Redone";
    downloadPage = "https://github.com/TrashboxBobylev/Experienced-Pixel-Dungeon-Redone/releases";
    description = "A fork of the Shattered Pixel Dungeon roguelike without limits on experience and items";
  };
}
