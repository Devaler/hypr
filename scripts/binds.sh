#!/bin/sh
# Show Hyprland's keybinds
hyprctl binds -j | jq -c '.[]' | while read -r i; do
        extract_json_field() { echo $i | jq -r .$1; }

        description=$(extract_json_field description)
        key=$(extract_json_field key)
        keycode=$(extract_json_field keycode) # Those are codes instead of keynames, need reformatting
        modmask=$(extract_json_field modmask) # Those are codes instead of key names, need reformatting

        # Didn't find a reliable way to translate keycode, so bruteforce 1-9 it is.
        if ((keycode>0)); then
                key="$key$((($keycode-9)%10))"
        fi

        mods=""
        eval_mod() {
                if ((modmask>=$1)); then
                        modmask=$((modmask-$1))
                        mods="$mods$2+"
                fi
        }
        eval_mod 64 SUPER
        eval_mod 8 ALT
        eval_mod 4 CTRL
        eval_mod 1 SHIFT
        mods="${mods%+}"

        # Formatted output
        printf "[%-20s] %-20s %s\n" "$mods" "$key" "$description"
done
