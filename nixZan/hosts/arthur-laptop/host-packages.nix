{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pulseaudio
    cudatoolkit
    (ollama.override { acceleration = "cuda"; })
    open-webui
  ];
}
