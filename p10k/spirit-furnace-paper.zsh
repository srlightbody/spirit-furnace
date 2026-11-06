# Spirit Furnace Paper - powerlevel10k
# Source this near the end of ~/.p10k.zsh, immediately before its single
# `p10k reload`, so the overrides are compiled without restarting prompt workers.
#
# Collapses p10k's rainbow to one lit signal bar: every segment sits on the
# same block (this variant's `hl_med`, a step up from the muted overlay so the
# prompt reads like backlit signage over the deep base), differentiated by hot
# accent text rather than per-segment fills. Only the block color changes between
# variants; the text accents are shared. Git status text colors live in
# my_git_formatter in the p10k config itself (also shared accents), not here.

() {
  local v
  # Put every segment on the lit surface individually. NOT via the global
  # POWERLEVEL9K_BACKGROUND, which fills the whole prompt line into one band.
  for v in ${(k)parameters[(I)POWERLEVEL9K_*_BACKGROUND]}; do
    typeset -g $v='#adab83'
  done
  # Drop the generated block-tuned foregrounds; a readable base + accents below.
  for v in ${(k)parameters[(I)POWERLEVEL9K_*_FOREGROUND]}; do
    unset $v
  done
}
typeset -g POWERLEVEL9K_FOREGROUND='#443524'
# Prompt char and the left/right gap stay transparent (no surface fill).
typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=

# Same-color segments: plain spacers internally so they merge into one bar;
# the config's rounded outer caps are kept for pill ends.
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=' '
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=' '
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '

# Text accents (shared across variants).
typeset -g POWERLEVEL9K_DIR_FOREGROUND='#2d2216'
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND='#5e503d'
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#2d2216'
typeset -g POWERLEVEL9K_KUBECONTEXT_FOREGROUND='#005d3f'
typeset -g POWERLEVEL9K_TERRAFORM_FOREGROUND='#7b3600'
typeset -g POWERLEVEL9K_TERRAFORM_BACKGROUND='#9da37d'
typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND='#723a82'
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='#634500'
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='#305400'
typeset -g POWERLEVEL9K_TIME_FOREGROUND='#5e503d'
typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND='#5e503d'
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#a51000'
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND='#305400'
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='#305400'
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='#a51000'

# Git status colors for my_git_formatter in ~/.p10k.zsh. Hex on purpose: after
# %B, zsh re-emits a numeric color as 24-bit (color 10 becomes #00000a).
typeset -g THEME_GIT_META='#443524'
typeset -g THEME_GIT_CLEAN='#325b00'
typeset -g THEME_GIT_MODIFIED='#634500'
typeset -g THEME_GIT_UNTRACKED='#305400'
typeset -g THEME_GIT_CONFLICTED='#a51000'
