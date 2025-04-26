{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    prefix = "C-Space";
    baseIndex = 1;
    escapeTime = 10;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = [
      pkgs.tmuxPlugins.better-mouse-mode
      (pkgs.tmuxPlugins.catppuccin.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "tmux";
          tag = "v2.1.3";
          sha256 = "sha256-Is0CQ1ZJMXIwpDjrI5MDNHJtq+R3jlNcd9NXQESUe2w=";
        };
      }))
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.vim-tmux-navigator
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g mouse on
      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window
      bind q killp

      set -g @catppuccin_flavour 'mocha'
      set -g @catppuccin_window_status_style "rounded"
      set-window-option -g mode-keys vi
      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      bind | split-window -h
      bind _ split-window -v

      set -g status-right-length 40
      set -g status-left-length 40
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM
    '';
  };
}

