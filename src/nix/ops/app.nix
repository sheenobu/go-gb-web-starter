{
  network.description = "Simple Static Application Network";

  staticappsrv  =
    { config, pkgs, ... }:
    let
       staticsrv = (pkgs.callPackage ../../cmd/staticsrv {});
    in
    {
      systemd.services.staticsrv =
          { description = "Static Web Server";
            path  = [ staticsrv ];
            script = ''${staticsrv}/bin/staticsrv'';
            wantedBy = [ "multi-user.target" ];
            after = [ "network.target" ];
          };

      networking.firewall.allowedTCPPorts = [ 8080 ];
    };
}
