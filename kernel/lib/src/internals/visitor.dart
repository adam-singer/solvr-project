// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

abstract class Visitor<R> {
  // Binary expressions 
  
  // TODO mixin's

  // Algebraic expressions
  R visitComplexNumber(ComplexNumberExpr expr);
  R visitDifference(DifferenceExpr expr);
  R visitDot(DotExpr expr);
  R visitFraction(FractionExpr expr);
  R visitPower(PowerExpr expr);

  // Logical expressions
  R visitAnd(AndExpr expr);
  R visitOr(OrExpr expr);

  // Object expressions
  R visitBind(BindExpr expr);
  R visitGuard(GuardExpr expr);
  R visitInstanceOf(InstanceOfExpr expr);
  R visitNotInstanceOf(NotInstanceOfExpr expr);
  R visitSubstitution(SubstitutionExpr expr);

  // Relational expressions
  R visitEqual(EqualExpr expr);
  R visitGreaterThan(GreaterThanExpr expr);
  R visitGreaterThanOrEqual(GreaterThanOrEqualExpr expr);
  R visitLessThan(LessThanExpr expr);
  R visitLessThanOrEqual(LessThanOrEqualExpr expr);
  R visitNotEqual(NotEqualExpr expr);

  // Set expressions
  R visitComplement(ComplementExpr expr);
  R visitEntry(EntryExpr expr);
  R visitIntersect(IntersectExpr expr);
  R visitNotSubset(NotSubsetExpr expr);
  R visitSubset(SubsetExpr expr);
  R visitUnion(UnionExpr expr);

  // Nary expressions 

  // Algebraic n-ary expressions
  R visitList(ListExpr expr);
  R visitMatrix(MatrixExpr expr);
  R visitProduct(ProductExpr expr);
  R visitSet(SetExpr expr);
  R visitSum(SumExpr expr);
  R visitTuple(TupleExpr expr);
  R visitVector(VectorExpr expr);

  // Non-algebraic n-ary expressions
  R visitDictionary(DictionaryExpr expr);
  R visitInterval(IntervalExpr expr);

  // Nullary expressions 
  R visitBool(BoolExpr expr);
  R visitNumber(NumberExpr expr);
  R visitString(StringExpr expr);
  R visitSymbol(SymbolExpr expr);

  // Special expressions 
  R visitAnonymousFunction(AnonymousFunctionExpr expr);
  R visitAssign(AssignExpr expr);
  R visitBlock(BlockExpr expr);
  R visitConditional(ConditionalExpr expr);
  R visitFunction(FunctionExpr expr);
  R visitGeneric(GenericExpr expr);
  R visitInvoke(InvokeExpr expr);
  R visitMethod(MethodExpr expr);
  R visitNothing(NothingExpr expr);
  R visitObject(ObjectExpr expr);
  R visitReturn(ReturnExpr expr);
  R visitSeq(SeqExpr expr);
  R visitTyped(TypedExpr expr);

  // Unary expressions 
  R visitFactorial(FactorialExpr expr);
  R visitNegation(NegationExpr expr);
  R visitNegative(NegativeExpr expr);
}
