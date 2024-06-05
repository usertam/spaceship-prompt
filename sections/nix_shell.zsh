#
# Nix Shell
#
# Nix can be used to provide some kind of virtual environment through the nix-shell command.
# Link: https://nixos.org/manual/nix/stable/command-ref/nix-shell.html

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_NIX_SHELL_SHOW="${SPACESHIP_NIX_SHELL_SHOW=true}"
SPACESHIP_NIX_SHELL_ASYNC="${SPACESHIP_NIX_SHELL_ASYNC=false}"
SPACESHIP_NIX_SHELL_PREFIX="${SPACESHIP_NIX_SHELL_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_NIX_SHELL_SUFFIX="${SPACESHIP_NIX_SHELL_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_NIX_SHELL_SYMBOL="${SPACESHIP_NIX_SHELL_SYMBOL="❄ "}"
SPACESHIP_NIX_SHELL_COLOR="${SPACESHIP_NIX_SHELL_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Shows whether nix-shell environment is active
spaceship_nix_shell() {
  [[ $SPACESHIP_NIX_SHELL_SHOW == false ]] && return

  [[ -z "$IN_NIX_SHELL" ]] && ! (echo "$PATH" | grep -q '/nix/store') && return

  if [[ -z "$IN_NIX_SHELL" ]] then
    display_text="$(echo "$PATH" | grep -Po '/nix/store.*?:' | cut -d- -f2 | uniq | sed ':a;N;$!ba;s/\n/, /g')"
  else
    display_text="$(echo "$PATH" | grep -Po '/nix/store.*?:' | cut -d- -f2 | tail -1)"
  fi

  # Show prompt section
  spaceship::section \
    --color "$SPACESHIP_NIX_SHELL_COLOR" \
    --prefix "$SPACESHIP_NIX_SHELL_PREFIX" \
    --suffix "$SPACESHIP_NIX_SHELL_SUFFIX" \
    --symbol "$SPACESHIP_NIX_SHELL_SYMBOL" \
    "$display_text"
}
