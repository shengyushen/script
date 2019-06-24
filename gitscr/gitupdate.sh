awk '/path = /{p=$3} /url = / {print "git clone " $3 " " p}' ./.gitmodules
