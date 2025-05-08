{ pkgs, ... }: {
  home.packages = with pkgs; [ zsh ];

  home.file."./.zshrc-personal".text = ''
    export TERMINAL='wezterm'
    export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
    autoload -Uz compinit

    for dump in ~/.config/zsh/zcompdump(N.mh+24); do
      compinit -d ~/.config/zsh/zcompdump
    done

    compinit -C -d ~/.config/zsh/zcompdump

    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info
    precmd () { vcs_info }
    _comp_options+=(globdots)

    zstyle ':completion:*' verbose true
    zstyle ':completion:*:*:*:*:*' menu select
    zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS} 'ma=48;5;197;1'
    zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
    zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
    zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'


    expand-or-complete-with-dots() {
      echo -n "\e[31m…\e[0m"
      zle expand-or-complete
      zle redisplay
    }
    zle -N expand-or-complete-with-dots
    bindkey "^I" expand-or-complete-with-dots

    setopt AUTOCD              # change directory just by typing its name
    setopt PROMPT_SUBST        # enable command substitution in prompt
    setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
    setopt LIST_PACKED		   # The completion menu takes less space.
    setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
    setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
    setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
    setopt COMPLETE_IN_WORD    # Complete from both ends of a word.


    alias cl="clear"
    alias nb="sudo nixos-rebuild switch --flake /home/arthur/.dotfiles/nixZan/#nvidia-laptop"
    alias cd="z"
    alias wireless="sshpass -p 09103502440  ssh admin@192.168.88.1 \"/ip firewall mangle set 3 new-routing-mark=\"Wireless\""\"
    alias adsl="sshpass -p 09103502440  ssh admin@192.168.88.1 \"/ip firewall mangle set 3 new-routing-mark=\"ADSL\""\"
    alias musica="ncmpcpp"
    alias ..='cd ./..'
    alias ...='cd ./../..'
    alias ....='cd ./../../..'

    function xterm_title_precmd () {
        local simplified_path=$(print -P "%~" | sed -E 's/([^\/])[^\/]*\//\1\//g')
        print -Pn -- '\e]2;''${simplified_path}\a'
        [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{B}''${simplified_path}\005{-}\e\\'
    }

    function xterm_title_preexec () {
        local simplified_path=$(print -P "%~" | sed -E 's/([^\/])[^\/]*\//\1\//g')
        local truncated_cmd=$(echo "$1" | cut -c1-30)
        print -Pn -- '\e]2;''${simplified_path} → ''${truncated_cmd}\a'
        [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{B}''${simplified_path}\005{-} → ''${truncated_cmd}\e\\'; }
    }

    if [[ "$TERM" == (kitty*|alacritty*|termite*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
        add-zsh-hook -Uz precmd xterm_title_precmd
        add-zsh-hook -Uz preexec xterm_title_preexec
    fi

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # pnpm
    export PNPM_HOME="/home/arthur/.local/share/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
    # pnpm end
    alias kp='kill_process_by_port() { sudo kill -9 $(sudo lsof -t -i:"$1"); }; kill_process_by_port "$@"'


    # Show proxy settings
    function proxy_show(){
       env | grep -e _PROXY -e _proxy | sort
    }

    # Configure proxy
    function proxy_on(){
       # You may need to hardcode your password, proxy server, and proxy port
       # if the following variables do not exist
       export HTTP_PROXY="http://127.0.0.1:20171"
       export HTTPS_PROXY=$HTTP_PROXY
       export FTP_PROXY=$HTTP_PROXY
       export http_proxy=$HTTP_PROXY
       export https_proxy=$HTTP_PROXY
       export ftp_proxy=$HTTP_PROXY
       # export SOCKS_PROXY=$HTTP_PROXY
       # export no_proxy="localhost,127.0.0.1,$USERDNSDOMAIN"
       export no_proxy="localhost,127.0.0.0/8,::1"

       # Update git and npm to use the proxy
       if hash git 2>/dev/null; then
         git config --global http.proxy $HTTP_PROXY
         git config --global https.proxy $HTTP_PROXY
       fi
       
       if hash npm 2>/dev/null; then
         npm config set proxy $HTTP_PROXY
         npm config set https-proxy $HTTP_PROXY
         # npm config set strict-ssl false
         # npm config set registry "http://registry.npmjs.org/"
       fi
    }

    # Enable proxy settings immediately
    # proxy_on

    # Disable proxy settings
    function proxy_off(){
       variables=( \
          "HTTP_PROXY" "HTTPS_PROXY" "FTP_PROXY" \
          "no_proxy" "http_proxy" "https_proxy" "ftp_proxy" \
       )

       for i in "''${variables[@]}"
       do
          unset $i
       done
       
       # Update git and npm to disable the proxy
       if hash git 2>/dev/null; then
         git config --global --unset http.proxy
         git config --global --unset https.proxy
       fi
       
       if hash npm 2>/dev/null; then
         npm config rm proxy
         npm config rm https-proxy
         # npm config set strict-ssl false
         # npm config set registry "http://registry.npmjs.org/"
       fi
    }

    function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                    builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
    }

    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

    export FZF_DEFAULT_OPTS="--tmux 70% --preview 'bat --color=always {}' --preview-window '~3'"
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    unsetopt BEEP
    eval "$(zoxide init zsh)"
    eval "$(direnv hook zsh)"
    eval "$(starship init zsh)"

    alias n='proxy_on; nvim ; proxy_off;'
    if [[ -o interactive ]]; then
        fastfetch
    fi
  '';
}

