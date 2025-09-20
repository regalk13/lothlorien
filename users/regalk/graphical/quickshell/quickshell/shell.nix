{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "qmlls-dev-shell";
  
  buildInputs = with pkgs; [
    qt6.qtdeclarative
    qt6.qttools
    
    qt6.qtbase
    qt6.qtquick3d
    qt6.qtmultimedia
    typescript-language-server
    pkg-config
  ];

  shellHook = ''
    export QML_IMPORT_PATH="${pkgs.qt6.qtdeclarative}/qml:$QML_IMPORT_PATH"
    export QML2_IMPORT_PATH="${pkgs.qt6.qtdeclarative}/qml:$QML2_IMPORT_PATH"
  '';
}
