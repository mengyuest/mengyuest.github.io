static_files=()
jem_files=(
"index" "publications"
"blogs/collecting" "blogs/hungarian"
"misc/soccer" "misc/running"
)

for i in "${jem_files[@]}"
do
   :
   jemdoc -c config/my.conf src/$i
   mv src/${i}.html .
done

for i in "${static_files[@]}"
do
   :
   cp src/static/$i .
done
