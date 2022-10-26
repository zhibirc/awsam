#!/usr/bin/env bash
# -----------------------------------------
# Simple AWS CLI profile manager.
# Features:
# - output the list of existing AWS profiles
# - allow to pick some profile for further working
# - set AWS_PROFILE env to profile being choose
# - setup is applied immediately and valid until next change
# -----------------------------------------

BOLD_CYAN='\033[1;36m'
RED='\033[0;31m'
STYLE_RESET='\033[0m'

USER_ENV_FILE="$HOME"/bin/.env

printf "%b" "${BOLD_CYAN}\nThe following AWS profiles found:\n\n${STYLE_RESET}"

if command -v readarray &> /dev/null; then
  readarray -t existing_profiles < <(aws configure list-profiles)
else
  # mostly for zsh shell
  while IFS= read -r line; do existing_profiles+=("$line"); done < <(aws configure list-profiles)
fi

profile_name=''

PS3="Please, choose AWS profile to use: "
select profile in "${existing_profiles[@]}"
do
  profile_name="$profile"
  break
done

[[ -z "$profile_name" ]] && printf "%b" "${RED}\nSelection error, try again\n${STYLE_RESET}" && exit 1

mkdir -p "$HOME"/bin
# just update access time if file exists
touch "$USER_ENV_FILE"

if grep -q 'export AWS_PROFILE=' "$USER_ENV_FILE"
then
  sed -i -E "s/export AWS_PROFILE=.*/export AWS_PROFILE=$profile_name/" "$USER_ENV_FILE"
else
  echo "export AWS_PROFILE=$profile_name" >> "$USER_ENV_FILE"
fi

# apply changes for the current terminal
exec "$SHELL"

exit 0