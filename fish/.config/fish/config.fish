set fish_greeting ""
set -gx TERM xterm-256color

# theme
set -g theme_color_scheme default
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end
