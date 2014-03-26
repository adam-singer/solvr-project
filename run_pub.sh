#!/bin/bash

declare -a projects=("common" "types" "ast" "parser" "analyzer" "kernel")

for i in "${projects[@]}"
do
	pushd "$i"
	    printf "Resolving dependencies for [%s]\n" "$i" 
  		pub upgrade
	popd
done

