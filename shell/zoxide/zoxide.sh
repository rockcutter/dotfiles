if type zoxide > /dev/null 2>&1; then
	eval "$(zoxide init bash --hook pwd)" 
	alias cd='z'
fi

