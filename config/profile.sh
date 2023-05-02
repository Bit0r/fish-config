if [ -d $HOME/.config/profile.d ]; then
  for i in $HOME/.config/profile.d/*.sh; do
    if [ -r $i ]; then
      source $i
    fi
  done
  unset i
fi
