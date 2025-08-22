{ config, pkgs, ... }:
	
{
  # Mount the Dell's Samba share
  fileSystems."/mnt/storage" = {
    device = "//192.168.100.10/storage";
    fsType = "cifs";
    # options = [
    #   "credentials=/etc/nixos/smb-credentials"
    #   "uid=${toString (config.users.users.admin.uid)}"
    #   "gid=${toString (config.users.groups.users.gid)}"
    #   "vers=3.0"
    # ];
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

      # in ["${automount_opts},credentials=/etc/nixos/smb-credentials,uid=1000,gid=100"];
    # or if you have specified `uid` and `gid` explicitly through NixOS configuration,
    # you can refer to them rather than hard-coding the values:
    in ["${automount_opts},credentials=/etc/nixos/smb-credentials,uid=1000,gid=100"];
  };
}
