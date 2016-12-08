set fish_greeting

# allow global pip if necessary when no virtualenv is sourced
function gpip
    begin
        set -lx PIP_REQUIRE_VIRTUALENV
        sudo -H /usr/local/bin/pip $argv
    end
end

# hacks to use XDG config location for easier backup
alias tmux "tmux -2f $HOME/.config/tmux/config"

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias dot "git --git-dir=$DOTFILES --work-tree=$HOME"

# add Homebrew's sbin to path
set -gx PATH "/usr/local/sbin" $PATH

# add user binaries to path
set -gx PATH "$HOME/.local/share/bin" $PATH

# config bobthefish
#   https://github.com/oh-my-fish/theme-bobthefish
set -g theme_display_git yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_git_worktree_support yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_ruby yes
set -g theme_display_user yes
set -g theme_display_vi yes
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_use_abbreviated_path yes
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g default_user lastson
set -g theme_color_scheme terminal-dark
# set -g theme_color_scheme user
# set -l bg 2E3440
# set -l fg D8DEE9
#
# set -g __color_initial_segment_exit  E5E9F0 BF616A --bold
# set -g __color_initial_segment_su    E5E9F0 A3BE8C --bold
# set -g __color_initial_segment_jobs  E5E9F0 81A1C1 --bold
#
# set -g __color_path                  3B4252 8FBCBB
# set -g __color_path_basename         3B4252 8FBCBB --bold
# set -g __color_path_nowrite          BF616A E5E9F0
# set -g __color_path_nowrite_basename BF616A E5E9F0 --bold
#
# set -g __color_repo                  B48EAD 3B4252
# set -g __color_repo_work_tree        B48EAD ffffff --bold
# set -g __color_repo_dirty            D08770 ECEFF4
# set -g __color_repo_staged           EBCB8B 3B4252
#
# set -g __color_vi_mode_default       999999 434C5E --bold
# set -g __color_vi_mode_insert        A3BE8C 434C5E --bold
# set -g __color_vi_mode_visual        EBCB8B 434C5E --bold
#
# set -g __color_vagrant               81A1C1 E5E9F0 --bold
# set -g __color_username              434C5E 88C0D0
# set -g __color_rvm                   D08770 ECEFF4 --bold
# set -g __color_virtualfish           5E81AC ECEFF4 --bold
status --is-interactive; and source (rbenv init -|psub)
