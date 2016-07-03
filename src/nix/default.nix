with import <nixpkgs> {};
{ }:
let
  gb = (callPackage ./gb {}).bin // { outputs = [ "bin" ]; };
  riot = (callPackage ./riot {});
  gosu = (callPackage ./gosu { runc = callPackage ./runc {}; });

  go = go_1_6;
  removeReferences = [ go ];

  removeExpr = refs: lib.flip lib.concatMapStrings refs (ref: ''
    | sed "s,${ref},$(echo "${ref}" | sed "s,$NIX_STORE/[^-]*,$NIX_STORE/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee,"),g" \
  '');

in
{

  myEnv = stdenv.mkDerivation {
    name = "go-gb-env";
    buildInputs = [ go gb riot python27Packages.docker_compose ];
    shellHook = ''
        export GOROOT="${go}/share/go"
        export GOPATH="$PWD/.go:$PWD/vendor:$PWD"
        export GOBIN="$PWD/.go/bin"
        export PATH="$PATH:$GOBIN"

		function buildDockerImages() {
			for x in `find -iname docker.nix`; do
				echo $x
				name=`echo $x | xargs dirname | xargs basename`
				dockerfile=$x
				nix-build $dockerfile -o .tmp/docker-$name
			done
		}

		function loadDockerImages() {
			for x in `find .tmp -iname docker-*`; do
				echo "Loading $x"
				docker load < $x
			done
		}
    '';
  };

  buildGbBinary = { name, ... } @ args: { }: stdenv.mkDerivation {
	inherit name;
    src = ../../.;

	buildPhase = ''
		${args.preBuild}

		GOROOT=${go}/share/go ${gb.bin}/bin/gb build cmd/${name}
	'';

	installPhase = ''

		mkdir -p $out/bin
		cp bin/${name} $out/bin

		${args.postInstall}
	'';

	preFixup = ''
	  echo "fixing up"
      while read file; do
        cat $file ${removeExpr removeReferences} > $file.tmp
        mv $file.tmp $file
        chmod +x $file
      done < <(find $out/bin -type f 2>/dev/null)
    '';

    outputs = [ "out" ];
  };

  dockerTools = dockerTools;
  gb = gb;
  riot = riot;
  gosu = gosu;
}

