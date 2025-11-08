_: {
  nixpkgs.overlays = [
    (_self: super: {
      biblesync =
        (super.biblesync.override {
        }).overrideAttrs
          (_oldAttrs: rec {
            cmakeFlags = [
              "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
            ];
          });
    })
  ];
}
