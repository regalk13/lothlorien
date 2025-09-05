_self: super: {
  python3Packages = super.python3Packages // {
    rapidocr-onnxruntime = super.python3Packages.rapidocr-onnxruntime.overrideAttrs (_oldAttrs: rec {
      version = "1.4.4";

      src = super.fetchFromGitHub {
        owner = "RapidAI";
        repo = "RapidOCR";
        tag = "v${version}";
        hash = "sha256-x0VELDKOffxbV3v0aDFJFuDC4YfsGM548XWgINmRc3M=";
      };

      models =
        super.fetchzip {
          url = "https://github.com/RapidAI/RapidOCR/releases/download/v1.1.0/required_for_whl_v1.3.0.zip";
          hash = "sha256-j/0nzyvu/HfNTt5EZ+2Phe5dkyPOdQw/OZTz0yS63aA=";
          stripRoot = false;
        }
        + "/required_for_whl_v1.3.0/resources/models";

      sourceRoot = "${src.name}/python";

      patches = [
        (super.replaceVars ./setup-py-override-version-checking.patch {
          inherit version;
        })
      ];

      postPatch = ''
        mv setup_onnxruntime.py setup.py
        ln -s ${models}/* rapidocr_onnxruntime/models
        echo "from .rapidocr_onnxruntime.main import RapidOCR, VisRes" > __init__.py
      '';

      preBuild = ''
        mkdir rapidocr_onnxruntime_t
        mv rapidocr_onnxruntime rapidocr_onnxruntime_t
        mv rapidocr_onnxruntime_t rapidocr_onnxruntime
      '';

      postBuild = ''
        mv rapidocr_onnxruntime rapidocr_onnxruntime_t
        mv rapidocr_onnxruntime_t/* .
      '';

      dependencies = with super.python3Packages; [
        pyclipper
        opencv-python
        numpy
        six
        shapely
        pyyaml
        pillow
        onnxruntime
        tqdm
      ];

      pythonImportsCheck = [ "rapidocr_onnxruntime" ];

      nativeCheckInputs = with super.python3Packages; [
        pytestCheckHook
        requests
      ];

      disabledTestPaths = [
        "tests/test_vino.py"
        "tests/test_paddle.py"
      ];

      disabledTests = [
        "test_long_img"
      ];

      disabled = false;

      passthru.skipBulkUpdate = true;

      meta = {
        badPlatforms = [ "aarch64-linux" ];
        changelog = "https://github.com/RapidAI/RapidOCR/releases/tag/${src.tag}";
        description = "Cross platform OCR Library based on OnnxRuntime";
        homepage = "https://github.com/RapidAI/RapidOCR";
        license = super.lib.licenses.asl20;
        maintainers = with super.lib.maintainers; [ wrvsrx ];
        mainProgram = "rapidocr_onnxruntime";
      };
    });
  };
}
