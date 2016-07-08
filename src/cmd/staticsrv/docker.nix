with import <nixpkgs> {};
with import ../../nix {};
let
	staticsrv = (callPackage ./default.nix {
	  inherit stdenv;
	  inherit pkgs;
	}) {};
in
dockerTools.buildImage {

  name = "staticsrv";

  runAsRoot = ''
    #!${stdenv.shell}
    ${dockerTools.shadowSetup}
    groupadd -r www
    useradd -r -g www -d /data -M www
    mkdir /data
    chown www:www /data
  '';

  config = {
    Cmd = [ "${gosu.bin}/bin/gosu" "www" "${staticsrv}/bin/staticsrv" ];
    ExposedPorts = {
      "8080/tcp" = {};
    };
    WorkingDir = "/data";
    Volumes = {
      "/data" = {};
    };
  };
}
