cd common
	pub install
	dart test/solvr_common_test.dart
cd ..

cd ast
	pub install
	dart test/solvr_ast_test.dart
cd ..

cd parser
	pub install
	dart test/solvr_parser_test.dart
cd ..

cd kernel
  pub install
  dart test/solvr_kernel_internals_test.dart
cd ..

