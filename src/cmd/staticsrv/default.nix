with import ../../nix {};

buildGbBinary {
    name = "staticsrv";

    buildInputs = [ riot ];

    preBuild = ''
        make src/www/tags.js
        substituteInPlace src/cmd/staticsrv/main.go \
            --replace ./src/www $out/www
    '';

    postInstall = ''
        mkdir -p $out
        cp -a src/www $out/www
    '';
}
