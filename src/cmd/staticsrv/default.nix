{ stdenv, pkgs }:

with import ../../nix {};

buildGbBinary {
    name = "staticsrv";

    buildInputs = [ riot pkgs.libuuid ];

    preBuild = ''

        # generate javascript files
        substituteInPlace Makefile --replace riot ${riot}/bin/riot
        rm -f src/www/tags.js
        make src/www/tags.js

        # make javascript file unique
        file="tags-`${pkgs.libuuid}/bin/uuidgen`".js
        mv src/www/tags.js src/www/$file

        # replace reference to javascript file in index file
        substituteInPlace src/www/index.html \
            --replace tags.js $file

        # replace reference to static www folder in code
        substituteInPlace src/cmd/staticsrv/main.go \
            --replace ./src/www $out/www
    '';

    postInstall = ''
        mkdir -p $out
        cp -a src/www $out/www
    '';
}
