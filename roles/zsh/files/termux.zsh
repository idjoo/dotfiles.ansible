if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" 1>/dev/null 2>/dev/null
fi

export TERMINFO=/data/data/com.termux/files/usr/share/terminfo

apps ()
{
  source "$EXTERNAL_STORAGE"/termuxlauncher/.apps-launcher

  app=$(launch --list \
    | tr '[A-Z]' '[a-z]' \
    | sort | uniq \
    | fzf \
        --header='Applications:' \
        --margin=1 --padding=1 \
        --prompt='Launch > ' \
        --layout=reverse \
        --info=inline \
        --height=40% \
        --border)

  [[ -n "$app" ]] && launch "$app"
}

send()
{
  for file in "$@"; do
    termux-share -a send "$file"
  done
}

goreleaser()
{
  docker run -it -e GITLAB_TOKEN='' -v $(pwd):/app -w /app goreleaser/goreleaser "$@"
}

pandoc()
{
  docker run --rm \
    --volume "$(pwd):/data" \
    --user $(id -u):$(id -g) \
    pandoc/latex "$@"
}

alias reg='termux-chroot reg'
alias fav='termux-chroot fav'
alias vegeta='termux-chroot vegeta'

source /data/data/com.termux/files/home/.local/share/google-cloud-sdk/completion.zsh.inc
source /data/data/com.termux/files/home/.local/share/google-cloud-sdk/path.zsh.inc

complete -C /data/data/com.termux/files/home/.local/share/tofu/tofu tofu

typeset -U path PATH
path+=("$path[@]")
path+=("$XDG_DATA_HOME/nvim/mason/bin")
export PATH
