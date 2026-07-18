# -:- plumage/slackware -:-
# tagline: pure ASCII, eight colors, would render fine on the family VT
#
# The oldest one gets the oldest treatment: no unicode, no 256-color
# palette, no second thoughts. If your terminal was made after 1984
# this is purely a courtesy.

PROMPT='%F{blue}[%D{%H:%M}]%f %F{cyan}-:-%f %F{white}%n@${PLUMAGE_BOX}%f %F{cyan}-:-%f %F{white}(%~)%f %F{cyan}-:-%f%(?.. %F{red}*err %?*%f)
%F{white}%#%f '
