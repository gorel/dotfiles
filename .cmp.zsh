# Make `git b ...` complete exactly like `git branch ...`
_git_with_subcommand_aliases() {
  local -a save_words
  local save_current

  save_words=("${words[@]}")
  save_current=$CURRENT

  # `git <subcmd> ...` => subcmd is words[2]
  case "${words[2]}" in
    b)
      words[2]=branch
      ;;
  esac

  _git

  words=("${save_words[@]}")
  CURRENT=$save_current
}

compdef _git_with_subcommand_aliases git
