{
  virtualisation.oci-containers = {
    backend = "podman";
    containers.homeassistant = {
      # To see where this maps to run
      # `sudo podman volume inspect home-assistant`
      volumes = [ "home-assistant:/config" ];
      environment.TZ = "Europe/Berlin";
      # Note: The image will not be updated on rebuilds, unless the version label changes
      image = "ghcr.io/home-assistant/home-assistant:2026.9.2";
      extraOptions = [
        # Use the host network namespace for all sockets
        "--network=host"
      ];
    };
  };
}
