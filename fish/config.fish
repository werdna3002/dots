if status is-interactive
    # Commands to run in interactive sessions can go here
    if test -z "$XDG_RUNTIME_DIR"
	    set -gx XDG_RUNTIME_DIR "/tmp/"(id -u)"-runtime-dir"
    end
	if test ! -d "$XDG_RUNTIME_DIR"
		    mkdir -p "$XDG_RUNTIME_DIR"
		    chmod 700 "$XDG_RUNTIME_DIR"
	end
    set -gx XDG_SESSION_TYPE wayland
    set -gx XDG_CURRENT_DESKTOP sway
    set -gx MOZ_ENABLE_WAYLAND 1

    if test -z "$WAYLAND_DISPLAY"; and test (tty) = "/dev/tty1"
	    exec dbus-run-session sway
    end
end

function fish_greeting
    fortune | cowsay
end
# Catppuccin Mocha prompt colors
set -g fish_color_normal cdd6f4
set -g fish_color_command a6e3a1
set -g fish_color_keyword cba6f7
set -g fish_color_quote f9e2af
set -g fish_color_redirection 89dceb
set -g fish_color_end fab387
set -g fish_color_error f38ba8
set -g fish_color_param cdd6f4
set -g fish_color_comment 6c7086
set -g fish_color_selection --background=45475a
set -g fish_color_search_match --background=45475a
set -g fish_color_operator 89dceb
set -g fish_color_autosuggestion 6c7086
set -g fish_color_valid_path --underline




function fish_prompt
    set -l last_status $status

    # Current directory
    set_color cba6f7
    printf '%s' (prompt_pwd)

    # Git branch, if inside a Git repository
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l branch (command git branch --show-current 2>/dev/null)

        if test -n "$branch"
            set_color 89b4fa
            printf '  git:%s' "$branch"

            # Show a marker if tracked or untracked changes exist
            if test -n "$(command git status --porcelain 2>/dev/null)"
                set_color f9e2af
                printf ' *'
            end
        end
    end

    # Prompt arrow: red if the previous command failed
    if test $last_status -ne 0
        set_color f38ba8
    else
        set_color a6e3a1
    end

    printf '❯ '
    set_color normal
end


fish_add_path /home/andy/.spicetify
