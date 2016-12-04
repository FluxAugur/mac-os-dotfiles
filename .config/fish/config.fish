set fish_greeting

# set -gx LC_ALL en_US.UTF-8
# set -gx LC_CTYPE en_US.UTF-8

# fish will show a prompt, don't mess with my theme
# set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

# don't allow global pip by accident when no virtualenv is sourced
# set -gx PIP_REQUIRE_VIRTUALENV true

# allow global pip if necessary when no virtualenv is sourced
function gpip
    begin
        set -lx PIP_REQUIRE_VIRTUALENV
        sudo -H /usr/local/bin/pip $argv
    end
end

# hacks to use XDG config location for easier backup
alias tmux "tmux -2f $HOME/.config/tmux/config"

# less, don't save any history
# set -gx LESSHISTFILE /dev/null

# set -gx DOTFILES "$HOME/.local/share/dotfiles/"

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias dot "git --git-dir=$DOTFILES --work-tree=$HOME"

# homebrew
# set -gx HOMEBREW_CASK_OPTS "--appdir=$HOME/Applications"

# base directories
#   https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
# set -gx XDG_DATA_HOME "$HOME/.local/share"
# set -gx XDG_CONFIG_HOME "$HOME/.config"
# set -gx XDG_CACHE_HOME "$HOME/.cache"

# add user binaries to path
set -gx PATH "$HOME/.local/share/bin/" $PATH

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

set -g theme_color_scheme user
set -l colorfg 2E3440

set -g __color_initial_segment_exit  2E3440 ce000f --bold
set -g __color_initial_segment_su    3B4252 189303 --bold
set -g __color_initial_segment_jobs  ECEFF4 255e87 --bold

set -g __color_path                  333333 999999
set -g __color_path_basename         333333 ffffff --bold
set -g __color_path_nowrite          660000 cc9999
set -g __color_path_nowrite_basename 660000 cc9999 --bold

set -g __color_repo                  addc10 0c4801
set -g __color_repo_work_tree        addc10 ffffff --bold
set -g __color_repo_dirty            ce000f ffffff
set -g __color_repo_staged           f6b117 3a2a03

set -g __color_vi_mode_default       999999 333333 --bold
set -g __color_vi_mode_insert        189303 333333 --bold
set -g __color_vi_mode_visual        f6b117 3a2a03 --bold

set -g __color_vagrant               48b4fb ffffff --bold
set -g __color_username              cccccc 255e87
set -g __color_rvm                   af0000 cccccc --bold
set -g __color_virtualfish           005faf cccccc --bold
