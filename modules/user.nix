{ config, pkgs, ... }:

{
  users.users.admin = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "with great power comes great responsibility";
    extraGroups = [ "networkmanager" "docker" "wheel" "video" "render" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIER4S+aFma+Vhg7zR1smua2plzOy8R/TPArb14+zO3oL abde2006llah@gmail.com"
    ];
  };
}
