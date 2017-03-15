{ stdenv, fetchurl, ocaml, findlib, pkgconfig, gtk2, libgnomecanvas, libglade, gtksourceview, camlp4 }:

let
  pname = "lablgtk";
in

stdenv.mkDerivation (rec {
  name = "${pname}-${version}";
  version = "2.14.0";

  src = fetchurl {
    url = "https://forge.ocamlcore.org/frs/download.php/561/${name}.tar.gz";
    sha256 = "1fnh0amm7lwgyjdhmlqgsp62gwlar1140425yc1j6inwmgnsp0a9";
  };

  buildInputs = [ ocaml findlib pkgconfig gtk2 libgnomecanvas libglade gtksourceview camlp4 ];

  configureFlags = "--with-libdir=$(out)/lib/ocaml/${ocaml.version}/site-lib";
  buildFlags = "world";

  preInstall = ''
    mkdir -p $out/lib/ocaml/${ocaml.version}/site-lib
    export OCAMLPATH=$out/lib/ocaml/${ocaml.version}/site-lib/:$OCAMLPATH
  '';

  meta = {
    branch = "2.14";
    platforms = ocaml.meta.platforms or [];
    maintainers = [
      stdenv.lib.maintainers.z77z
      stdenv.lib.maintainers.roconnor
    ];
    homepage = http://wwwfun.kurims.kyoto-u.ac.jp/soft/lsl/lablgtk.html;
    description = "LablGTK is is an Objective Caml interface to gtk+";
    license = stdenv.lib.licenses.lgpl21Plus;
  };
})
