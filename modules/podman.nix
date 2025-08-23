# modules/docker.nix
{ config, pkgs, ... }:

{
  virtualisation.podman.enable = true;
}
