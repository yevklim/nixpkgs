{
  lib,
  buildPythonPackage,
  fetchPypi,
  docutils,
  lockfile,
  packaging,
  pytestCheckHook,
  testscenarios,
  testtools,
  setuptools,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "python-daemon";
  version = "3.0.1";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-bFdFI3L36v9Ak0ocA60YJr9eeTVY6H/vSRMeZGS02uU=";
  };

  postPatch = ''
    sed -i "s/setuptools\.extern\.//g" version.py test_version.py
  '';

  nativeBuildInputs = [
    setuptools
    packaging
  ];

  propagatedBuildInputs = [
    docutils
    lockfile
  ];

  nativeCheckInputs = [
    pytestCheckHook
    testscenarios
    testtools
  ];

  disabledTests = [
    "begin_with_TestCase"
    "changelog_TestCase"
    "ChangeLogEntry"
    "DaemonContext"
    "file_descriptor"
    "get_distribution_version_info_TestCase"
    "InvalidFormatError_TestCase"
    "make_year_range_TestCase"
    "ModuleExceptions_TestCase"
    "test_metaclass_not_called"
    "test_passes_specified_object"
    "test_returns_expected"
    "value_TestCase"
    "YearRange_TestCase"
  ];

  pythonImportsCheck = [
    "daemon"
    "daemon.daemon"
    "daemon.pidfile"
  ];

  meta = with lib; {
    description = "Library to implement a well-behaved Unix daemon process";
    homepage = "https://pagure.io/python-daemon/";
    # See "Copying" section in https://pagure.io/python-daemon/blob/main/f/README
    license = with licenses; [
      gpl3Plus
      asl20
    ];
    maintainers = [ ];
  };
}
