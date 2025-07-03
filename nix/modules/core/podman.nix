{ pkgs, ... }:
{
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    docker={
      enable=true;
    };

    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = false;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    podman-desktop
    docker
    #podman-compose # start group of containers for dev
  ];

  

  # Insecure: Expose Docker on TCP
  systemd.services.docker.serviceConfig.ExecStart = [
  ""
  "/run/current-system/sw/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375"
  ];
}

