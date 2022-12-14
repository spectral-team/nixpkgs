{ lib, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "shadowfox";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "SrKomodo";
    repo = "shadowfox-updater";
    rev = "v${version}";
    sha256 = "125mw70jidbp436arhv77201jdp6mpgqa2dzmrpmk55f9bf29sg6";
  };

  vendorSha256 = null; #vendorSha256 = "";

  doCheck = false;

  ldflags = [
    "-s"
    "-w"
    "-X main.tag=v${version}"
  ];

  meta = with lib; {
    description = "Universal dark theme for Firefox while adhering to the modern design principles set by Mozilla";
    homepage = "https://overdodactyl.github.io/ShadowFox/";
    license = licenses.mit;
    maintainers = with maintainers; [ infinisil ];
    mainProgram = "shadowfox-updater";
    broken = true; # vendor isn't reproducible with go > 1.17: nix-build -A $name.go-modules --check
  };
}
