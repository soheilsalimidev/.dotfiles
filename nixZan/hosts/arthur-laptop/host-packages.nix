{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pulseaudio
    cudatoolkit
    (ollama.override { acceleration = "cuda"; })
  ];
  # services.ollama = {
  #   enable = true;
  #   acceleration = "cuda";
  # };
  # services.open-webui.enable = true;
}
