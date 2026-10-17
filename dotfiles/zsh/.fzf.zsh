# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mauri/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mauri/.fzf/bin"
fi

source <(fzf --zsh)
