# ┌──( )─[ ]
#   plumage/kali — quiet operator
# tagline: steel blue rails, a transliterated box name, denials on record
#
# The box name gets the number treatment (k4l1 style) once, at load.
# Failures are logged inline as denials with the code attached.
# Background jobs stay visible — you want to know what is listening.

typeset -g _plm_kali_box=${${${${PLUMAGE_BOX//a/4}//e/3}//i/1}//o/0}

PROMPT='%F{24}┌──(%f%F{252}%n%F{24}⋈%F{45}${_plm_kali_box}%F{24})─[%f%F{250}%~%F{24}]%f%(?..%F{24}─(%F{203}denied%F{240}⁚%F{252}%?%F{24})%f)%(1j.%F{24}─[%F{45}%j bg%F{24}]%f.)
%F{24}└─%(!.%F{196}#.%F{45}»)%f '
