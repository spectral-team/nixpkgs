# Provide an initial copy of the NixOS channel so that the user
# doesn't need to run "nix-channel --update" first.

{ config, lib, pkgs, ... }:

with lib;

let
  nixpkgs = lib.cleanSource pkgs.path;

  # We need a copy of the Nix expressions for Nixpkgs and NixOS on the
  # CD.  These are installed into the "nixos" channel of the root
  # user, as expected by nixos-rebuild/nixos-install. FIXME: merge
  # with make-channel.nix.
  channelSources = pkgs.runCommand "nixos-${config.system.nixos.version}"
    { preferLocalBuild = true; }
    ''
      mkdir -p $out
      cp -prd ${nixpkgs.outPath} $out/nixos
      chmod -R u+w $out/nixos
      if [ ! -e $out/nixos/nixpkgs ]; then
        ln -s . $out/nixos/nixpkgs
      fi
      ${optionalString (config.system.nixos.revision != null) ''
        echo -n ${config.system.nixos.revision} > $out/nixos/.git-revision
      ''}
      echo -n ${config.system.nixos.versionSuffix} > $out/nixos/.version-suffix
      echo ${config.system.nixos.versionSuffix} | sed -e s/pre// > $out/nixos/svn-revision
    '';

in

{
  nix.registry.nixpkgs.flake.outPath = builtins.path { name = "source"; path = pkgs.path; };
  # Provide the NixOS/Nixpkgs sources in /etc/nixos.  This is required
  # for nixos-install.
  boot.postBootCommands = mkAfter
    ''
      if ! [ -e /var/lib/nixos/did-channel-init ]; then
        echo "unpacking the NixOS/Nixpkgs sources..."
        mkdir -p /nix/var/nix/profiles/per-user/root
        ${config.nix.package.out}/bin/nix-env -p /nix/var/nix/profiles/per-user/root/channels \
          -i ${channelSources} --quiet --option build-use-substitutes false \
          ${optionalString config.boot.initrd.systemd.enable "--option sandbox false"} # There's an issue with pivot_root
        mkdir -m 0700 -p /root/.nix-defexpr
        ln -s /nix/var/nix/profiles/per-user/root/channels /root/.nix-defexpr/channels
        mkdir -m 0755 -p /var/lib/nixos
        touch /var/lib/nixos/did-channel-init
      fi
    '';
}
