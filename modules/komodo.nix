# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."komodo-core" = {
    image = "ghcr.io/moghtech/komodo-core:latest";
    environment = {
      "COMPOSE_KOMODO_BACKUPS_PATH" = "/etc/komodo/backups";
      "COMPOSE_KOMODO_IMAGE_TAG" = "latest";
      "KOMODO_AWS_ACCESS_KEY_ID" = "# Alt: KOMODO_AWS_ACCESS_KEY_ID_FILE";
      "KOMODO_AWS_SECRET_ACCESS_KEY" = "# Alt: KOMODO_AWS_SECRET_ACCESS_KEY_FILE";
      "KOMODO_DATABASE_ADDRESS" = "mongo:27017";
      "KOMODO_DATABASE_PASSWORD" = "admin";
      "KOMODO_DATABASE_USERNAME" = "admin";
      "KOMODO_DB_PASSWORD" = "admin";
      "KOMODO_DB_USERNAME" = "admin";
      "KOMODO_DISABLE_CONFIRM_DIALOG" = "false";
      "KOMODO_DISABLE_NON_ADMIN_CREATE" = "false";
      "KOMODO_DISABLE_USER_REGISTRATION" = "false";
      "KOMODO_ENABLE_NEW_USERS" = "false";
      "KOMODO_FIRST_SERVER" = "https://periphery:8120";
      "KOMODO_FIRST_SERVER_NAME" = "Local";
      "KOMODO_GITHUB_OAUTH_ENABLED" = "false";
      "KOMODO_GOOGLE_OAUTH_ENABLED" = "false";
      "KOMODO_HOST" = "https://demo.komo.do";
      "KOMODO_INIT_ADMIN_PASSWORD" = "changeme";
      "KOMODO_INIT_ADMIN_USERNAME" = "admin";
      "KOMODO_JWT_SECRET" = "a_random_jwt_secret";
      "KOMODO_JWT_TTL" = "1-day";
      "KOMODO_LOCAL_AUTH" = "true";
      "KOMODO_LOGGING_PRETTY" = "false";
      "KOMODO_MONITORING_INTERVAL" = "15-sec";
      "KOMODO_OIDC_ENABLED" = "false";
      "KOMODO_PASSKEY" = "a_random_passkey";
      "KOMODO_PRETTY_STARTUP_CONFIG" = "false";
      "KOMODO_RESOURCE_POLL_INTERVAL" = "1-hr";
      "KOMODO_STORAGE" = "/home/admin/stacks/komodo";
      "KOMODO_TITLE" = "Komodo";
      "KOMODO_TRANSPARENT_MODE" = "false";
      "KOMODO_WEBHOOK_SECRET" = "a_random_secret";
      "PERIPHERY_DISABLE_TERMINALS" = "false";
      "PERIPHERY_INCLUDE_DISK_MOUNTS" = "/etc/hostname";
      "PERIPHERY_LOGGING_PRETTY" = "false";
      "PERIPHERY_PASSKEYS" = "a_random_passkey";
      "PERIPHERY_PRETTY_STARTUP_CONFIG" = "false";
      "PERIPHERY_ROOT_DIRECTORY" = "/etc/komodo";
      "PERIPHERY_SSL_ENABLED" = "true";
      "TZ" = "Etc/UTC";
    };
    environmentFiles = [
      "/home/admin/stacks/komodo/compose.env"
    ];
    volumes = [
      "/home/admin/stacks/komodo/backups:/backups:rw"
    ];
    ports = [
      "9120:9120/tcp"
    ];
    labels = {
      "komodo.skip" = "";
    };
    dependsOn = [
      "komodo-mongo"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=core"
      "--network=komodo_default"
    ];
  };
  systemd.services."docker-komodo-core" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-komodo_default.service"
    ];
    requires = [
      "docker-network-komodo_default.service"
    ];
    partOf = [
      "docker-compose-komodo-root.target"
    ];
    wantedBy = [
      "docker-compose-komodo-root.target"
    ];
  };
  virtualisation.oci-containers.containers."komodo-mongo" = {
    image = "l33tlamer/mongodb-without-avx:latest";
    environment = {
      "MONGO_INITDB_ROOT_PASSWORD" = "admin";
      "MONGO_INITDB_ROOT_USERNAME" = "admin";
    };
    environmentFiles = [
      "/home/admin/stacks/komodo/compose.env"
    ];
    volumes = [
      "/home/admin/stacks/komodo/db/config:/data/configdb:rw"
      "/home/admin/stacks/komodo/db/data:/data/db:rw"
    ];
    cmd = [ "--quiet" "--wiredTigerCacheSizeGB" "0.25" ];
    labels = {
      "komodo.skip" = "";
    };
    user = "root";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=mongo"
      "--network=komodo_default"
    ];
  };
  systemd.services."docker-komodo-mongo" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-komodo_default.service"
    ];
    requires = [
      "docker-network-komodo_default.service"
    ];
    partOf = [
      "docker-compose-komodo-root.target"
    ];
    wantedBy = [
      "docker-compose-komodo-root.target"
    ];
  };
  virtualisation.oci-containers.containers."komodo-periphery" = {
    image = "ghcr.io/moghtech/komodo-periphery:latest";
    environment = {
      "COMPOSE_KOMODO_BACKUPS_PATH" = "/etc/komodo/backups";
      "COMPOSE_KOMODO_IMAGE_TAG" = "latest";
      "KOMODO_AWS_ACCESS_KEY_ID" = "# Alt: KOMODO_AWS_ACCESS_KEY_ID_FILE";
      "KOMODO_AWS_SECRET_ACCESS_KEY" = "# Alt: KOMODO_AWS_SECRET_ACCESS_KEY_FILE";
      "KOMODO_DB_PASSWORD" = "admin";
      "KOMODO_DB_USERNAME" = "admin";
      "KOMODO_DISABLE_CONFIRM_DIALOG" = "false";
      "KOMODO_DISABLE_NON_ADMIN_CREATE" = "false";
      "KOMODO_DISABLE_USER_REGISTRATION" = "false";
      "KOMODO_ENABLE_NEW_USERS" = "false";
      "KOMODO_FIRST_SERVER" = "https://periphery:8120";
      "KOMODO_FIRST_SERVER_NAME" = "Local";
      "KOMODO_GITHUB_OAUTH_ENABLED" = "false";
      "KOMODO_GOOGLE_OAUTH_ENABLED" = "false";
      "KOMODO_HOST" = "https://demo.komo.do";
      "KOMODO_INIT_ADMIN_PASSWORD" = "changeme";
      "KOMODO_INIT_ADMIN_USERNAME" = "admin";
      "KOMODO_JWT_SECRET" = "a_random_jwt_secret";
      "KOMODO_JWT_TTL" = "1-day";
      "KOMODO_LOCAL_AUTH" = "true";
      "KOMODO_LOGGING_PRETTY" = "false";
      "KOMODO_MONITORING_INTERVAL" = "15-sec";
      "KOMODO_OIDC_ENABLED" = "false";
      "KOMODO_PASSKEY" = "a_random_passkey";
      "KOMODO_PRETTY_STARTUP_CONFIG" = "false";
      "KOMODO_RESOURCE_POLL_INTERVAL" = "1-hr";
      "KOMODO_STORAGE" = "/home/admin/stacks/komodo";
      "KOMODO_TITLE" = "Komodo";
      "KOMODO_TRANSPARENT_MODE" = "false";
      "KOMODO_WEBHOOK_SECRET" = "a_random_secret";
      "PERIPHERY_DISABLE_TERMINALS" = "false";
      "PERIPHERY_INCLUDE_DISK_MOUNTS" = "/etc/hostname";
      "PERIPHERY_LOGGING_PRETTY" = "false";
      "PERIPHERY_PASSKEYS" = "a_random_passkey";
      "PERIPHERY_PRETTY_STARTUP_CONFIG" = "false";
      "PERIPHERY_ROOT_DIRECTORY" = "/etc/komodo";
      "PERIPHERY_SSL_ENABLED" = "true";
      "TZ" = "Etc/UTC";
    };
    environmentFiles = [
      "/home/admin/stacks/komodo/compose.env"
    ];
    volumes = [
      "/home/admin/stacks/komodo/periphery:/etc/komodo:rw"
      "/proc:/proc:rw"
      "/var/run/docker.sock:/var/run/docker.sock:rw"
    ];
    labels = {
      "komodo.skip" = "";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=periphery"
      "--network=komodo_default"
    ];
  };
  systemd.services."docker-komodo-periphery" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-komodo_default.service"
    ];
    requires = [
      "docker-network-komodo_default.service"
    ];
    partOf = [
      "docker-compose-komodo-root.target"
    ];
    wantedBy = [
      "docker-compose-komodo-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-komodo_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f komodo_default";
    };
    script = ''
      docker network inspect komodo_default || docker network create komodo_default
    '';
    partOf = [ "docker-compose-komodo-root.target" ];
    wantedBy = [ "docker-compose-komodo-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-komodo-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
