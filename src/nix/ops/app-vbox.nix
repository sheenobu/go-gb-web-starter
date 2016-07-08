{
  staticappsrv =
    { config, pkgs, ... }:
    { deployment.targetEnv = "virtualbox";
      deployment.virtualbox.memorySize = 256; # megabytes
    };
}
