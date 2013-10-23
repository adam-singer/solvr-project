pushd common
	pub install
	dart test/solvr_common_test.dart
popd

pushd parser
	pub install
	dart test/solvr_parser_test.dart
popd

