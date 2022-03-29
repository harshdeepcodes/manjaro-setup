#!/bin/bash

# customize with your own.
options=($(cat ../packages/pacman-packages.txt))

menu() {
    echo "Avaliable packages:"
    for i in ${!options[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    if [[ "$msg" ]]; then echo "$msg"; fi
}

prompt="Select the packages (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="Invalid option: $num"; continue; }
    ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="✓"
done

#printf "You selected";
msg="You selected nothing"
for i in ${!options[@]}; do
    [[ "${choices[i]}" ]] && { echo "→ ""${options[i]}"; msg=""; } && { printf "%s " "${options[i]}"; msg=""; } >> ../packages/to-install-pacman.txt
done
