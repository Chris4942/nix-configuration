{ pkgs, ... }:
let
  tailscaleState = "/var/lib/tailnet-proxy";
in
{
  virtualisation.oci-containers = {
    backend = "docker";

    containers.tailnet-proxy = {
      image = "tailscale/tailscale:latest";

      hostname = "tailnet-proxy";

      capabilities = {
        NET_ADMIN = true;
        NET_RAW = true;
      };

      volumes = [
        "${tailscaleState}:/var/lib/tailscale"
        "/run/secrets/tailnet-proxy.env:/run/secrets/tailnet-proxy.env:ro"
      ];

      environment = {
        TS_AUTHKEY_FILE = "/run/secrets/tailscale-authkey";
      };

      ports = [
        "100.100.100.10:8080:8080"
      ];

      cmd = [
        "sh"
        "-c"
        ''
          set -x  # Print everything to the terminal as it's running
          tailscaled &
          until tailscale status >/dev/null 2>&1; do
            sleep 1
          done

          tailscale up \
            --auth-key="$TS_AUTHKEY" \
            --hostname=west-server-tmugleston-network-proxy

          exec ${pkgs.socat}/bin/socat \
            TCP-LISTEN:8080,fork,reuseaddr \
            TCP:100.64.20.30:8080
        ''
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d ${tailscaleState} 0700 root root -"
  ];
}
