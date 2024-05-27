PROMPT_COMMAND='history -a >(logger -t "[$USER] [$SSH_CONNECTION] [bash] [$$] [$PWD] [$?]" -p local6.debug)'
