{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pulseaudio
    cudatoolkit
    (ollama.override { acceleration = "cuda"; })
  ];
  services.open-webui = {
    enable = true;
    environment.OLLAMA_API_BASE_URL = "http://localhost:11434";
  };
}
