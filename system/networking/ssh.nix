_: {
  services = {
    openssh = {
      enable = true;
      allowSFTP = false;
      # TODO Figure out how to reproducibly automate ssh key generation from sops/initial deployment
      hostKeys = [ ];

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        AllowTcpForwarding = true;
        AllowAgentForwarding = true;
        UsePAM = true;
        X11Forwarding = false;
        KbdInteractiveAuthentication = false;
        UseDns = false;
        StreamLocalBindUnlink = "yes";
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
          "sntrup761x25519-sha512@openssh.com"
        ];
      };
    };
  };

  programs.ssh.knownHosts = {
    "github.com".hostNames = [ "github.com" ];
    "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

    "gitlab.com".hostNames = [ "gitlab.com" ];
    "gitlab.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";

    "git.sr.ht".hostNames = [ "git.sr.ht" ];
    "git.sr.ht".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
  };
}
