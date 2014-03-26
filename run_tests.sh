#!/bin/bash

declare -a projects=(
	"common:solvr_common_test.dart" 
	"types:skip" 
	"ast:solvr_ast_test.dart" 
	"parser:solvr_parser_test.dart" 
	"analyzer:solvr_analyzer_test.dart" 
	"kernel:solvr_kernel_internals_test.dart")

# TODO run all kernel tests

# execute tests
for project in "${projects[@]}" ; do
    project_dir=${project%%:*}
    test_suite=${project#*:}
    if [ "$test_suite" != "skip" ]; then 
    	pushd "$project_dir"
    		printf "Testing project [%s] using suite [%s]\n" "$project_dir" "$test_suite"
    		dart "test/$test_suite"
    	popd
   	fi
done


