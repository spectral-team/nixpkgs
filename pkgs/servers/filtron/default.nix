{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "filtron";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "asciimoo";
    repo = "filtron";
    rev = "v${version}";
    sha256 = "18d3h0i2sfqbc0bjx26jm2n9f37zwp8z9z4wd17sw7nvkfa72a26";
  };

  vendorSha256 = null; #vendorSha256 = "";

  # The upstream test checks are obsolete/unmaintained.
  doCheck = false;

  meta = with lib; {
    description = "Reverse HTTP proxy to filter requests by different rules.";
    homepage = "https://github.com/asciimoo/filtron";
    license = licenses.agpl3;
    maintainers = [ maintainers.dasj19 ];
    platforms = platforms.linux;
    broken = true; # vendor isn't reproducible with go > 1.17: nix-build -A $name.go-modules --check
  };
}
