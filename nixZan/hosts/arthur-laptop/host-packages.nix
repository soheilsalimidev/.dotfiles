{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pulseaudio
    cudatoolkit
    # (ollama.override { acceleration = "cuda"; })
  ];
  environment.sessionVariables = {
    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
  };
  # services.open-webui = {
  #   enable = true;
  #   environment.OLLAMA_API_BASE_URL = "http://localhost:11434";
  # };
}
