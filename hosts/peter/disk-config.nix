{ config, pkgs, ... }:
	
{

  fileSystems."/mnt/data1" = {
    device = "/dev/disk/by-uuid/a6157074-268b-4d55-9231-be5badc7bb5e";
    fsType = "ext4";
  };
  fileSystems."/mnt/data2" = {
    device = "/dev/disk/by-uuid/892e3360-8a18-4390-b1ea-0c873acc4423";
    fsType = "ext4";
  };
  fileSystems."/mnt/parity" = {
    device = "/dev/disk/by-uuid/afb82e4b-8f9c-4acf-9562-014c78980cf8";
    fsType = "ext4";
  };

  #mergerfs 
  fileSystems."/mnt/storage" = {
    fsType = "fuse.mergerfs";
    device = "/mnt/data*";
    options = ["defaults" "minfreespace=250G" "fsname=mergerfs-jbod"];
  };
}
