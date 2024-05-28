PROMPT_COMMAND='return_val=$?;tty=$(tty);history -a >(logger -t "$USER|$SSH_CONNECTION|$0|$tty|$$|$PWD|$return_val" -p local6.debug)'
