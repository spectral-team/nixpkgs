{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "tty-share";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "elisescu";
    repo = "tty-share";
    rev = "v${version}";
    sha256 = "sha256-/oK2m2kxmF9HHYfTK6NlZxKKkDS7Oay+ed7jR/+szs0=";
  };

  # Upstream has a `./vendor` directory with all deps which we rely upon.
  vendorSha256 = null;

  ldflags = [ "-s" "-w" "-X main.version=${version}" ];

  meta = with lib; {
    homepage = "https://tty-share.com";
    description = "Share terminal via browser for remote work or shared sessions";
    license = licenses.mit;
    maintainers = with maintainers; [ andys8 ];
  };
}
