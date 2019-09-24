static_files=()
jem_files=(
"index"
)

for i in "${jem_files[@]}"
do
   :
   python2 mod_jemdoc.py -c config/my.conf src/$i
   mv src/${i}.html .
done

for i in "${static_files[@]}"
do
   :
   cp src/static/$i .
done
