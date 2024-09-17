{ inputs, hosts, config, ... }: {
  imports = [ inputs.sops.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${hosts}/${config.networking.hostName}/secrets.yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
}
