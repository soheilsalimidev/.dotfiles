# Configuration file path
CONFIG_FILE="$HOME/.config/hypr/monitors.conf"

# Monitor descriptors
EXTERNAL_MONITOR_DESC="Samsung Electric Company S24D390"
LAPTOP_MONITOR="eDP-1"

# Function to detect connected monitors
detect_monitors() {
    MONITOR_INFO=$(hyprctl monitors 2>/dev/null)
    HAS_EXTERNAL=false
    HAS_LAPTOP=false
    
    # Parse monitors by looking at the full output
    while IFS= read -r line; do
        if [[ $line =~ ^Monitor\ ([^[:space:]]+) ]]; then
            MONITOR_NAME="${BASH_REMATCH[1]}"
            
            if [[ "$MONITOR_NAME" == "$LAPTOP_MONITOR"* ]]; then
                HAS_LAPTOP=true
            else
                # For non-laptop monitors, check the description in the following lines
                DESCRIPTION_LINE=$(echo "$MONITOR_INFO" | grep -A 5 "^Monitor $MONITOR_NAME" | grep "description:")
                if [[ "$DESCRIPTION_LINE" == *"$EXTERNAL_MONITOR_DESC"* ]]; then
                    HAS_EXTERNAL=true
                fi
            fi
        fi
    done < <(echo "$MONITOR_INFO" | grep "^Monitor ")
}

# Function to write configuration for external monitor only (default)
write_external_only_config() {
    cat > "$CONFIG_FILE" << EOF
monitor=desc:$EXTERNAL_MONITOR_DESC,1920x1080@60.0,0x0,1.0
EOF
}

# Function to write configuration for both monitors (external left, laptop right)
write_both_config() {
    cat > "$CONFIG_FILE" << EOF
monitor=desc:$EXTERNAL_MONITOR_DESC,1920x1080@60.0,0x0,1.0
monitor=$LAPTOP_MONITOR,1920x1080,1920x0,1.0
EOF
}

# Function to write configuration for laptop only
write_laptop_config() {
    LAPTOP_RESOLUTION=$(hyprctl monitors 2>/dev/null | grep -A 10 "$LAPTOP_MONITOR" | grep "resolution" | head -1 | awk '{print $2}')
    
    if [ -z "$LAPTOP_RESOLUTION" ]; then
        LAPTOP_RESOLUTION="1920x1080"
    fi
    
    cat > "$CONFIG_FILE" << EOF
monitor=$LAPTOP_MONITOR,$LAPTOP_RESOLUTION,0x0,1.0
EOF
}

# Function to update configuration
update_config() {
    sleep 1
    detect_monitors
    
    if [ "$HAS_EXTERNAL" = true ] && [ "$HAS_LAPTOP" = true ]; then
        # Both monitors connected - external primary (left), laptop right
        write_external_only_config
    elif [ "$HAS_EXTERNAL" = true ]; then
        # Only external monitor connected
        write_external_only_config
    elif [ "$HAS_LAPTOP" = true ]; then
        # Only laptop connected
        write_laptop_config
    else
        # Fallback to laptop
        write_laptop_config
    fi
    
    hyprctl reload
}

# Function to handle events
handle() {
    case $1 in
        monitoradded*)
            update_config
            ;;
        monitorremoved*)
            update_config
            ;;
    esac
}

# Initial configuration setup
update_config

# Connect to Hyprland socket2 and listen for events
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do 
    handle "$line"
done
