// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

abstract class Grammar {
   PrefixParselet getPrefixParselet(TokenType type);

   InfixParselet getInfixParselet(TokenType type);

   /** Get precedence of token. */
   int getPrecedence(Token token);
}
