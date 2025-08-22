{ config, pkgs, ... }:

{
  # SAMBA share
  services.samba = {
      enable = true;
      openFirewall = true;
      # Add a global configuration for your home network
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "%h server";
          "netbios name" = "peter";
          "security" = "user"; # Use user-based authentication
        };
        # Define your storage share
        storage = {
          path = "/mnt/storage";
          "guest ok" = "no"; # Do not allow guest access
          "read only" = "no";
          "valid users" = "@users"; # Allow all users in the 'users' group
          "create mask" = "0664";
          "directory mask" = "0775";
        };
      };
      # A convenience option to open the firewall ports for Samba
    };
  

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
