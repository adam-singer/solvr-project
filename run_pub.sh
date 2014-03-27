#!/bin/bash

# projects ordered by their dependencies
declare -a projects=(
	"common" 
	"types"     # depends on common
	"ui"        # depends on common
	"site"      # depends on ui, common
	"ast"       # depends on types, common
	"parser"    # depends on ast, types, common
	"analyzer"  # depends on parser, ast, types, common
	"kernel"    # depends on analyzer, parser, ast, types, common
	"logic"     # depends on kernel, analyzer, parser, ast, types, common
	"webapp")   # depends on ui, logic, kernel, analyzer, parser, ast, types, common

for i in "${projects[@]}"
do
	pushd "$i"
	    printf "Resolving dependencies for [%s]\n" "$i" 
  		pub upgrade
	popd
done

