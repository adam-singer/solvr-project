declare -a projects=("common" "types" "ast" "parser" "type_checker" "kernel")

for i in "${projects[@]}"
do
	pushd "$i"
  		pub upgrade
	popd
done

