_: {
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = false;
      MaxAuthTries = 3;
      AllowTcpForwarding = false;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = false;
  };
}
