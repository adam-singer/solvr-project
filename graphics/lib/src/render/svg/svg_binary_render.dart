// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_svg;

class _SvgBinaryRender extends _AbstractSvgRender implements BinaryRender {
  _SvgBinaryRender(SvgElement element, SvgElement glyphs): super(element, glyphs);
  
  // Algebraic expressions 
  renderDifference(DifferenceExpr expr) {
  }
  
  renderDot(DotExpr expr) {
    // x * x
    /*
     * <g stroke="black" fill="black" stroke-thickness="0" transform="matrix(1 0 0 -1 0 0)">
     * <use href="#MJMATHI-78">
     * </use><use href="#MJMAIN-22C5" x="799" y="0">
     * </use><use href="#MJMATHI-78" x="1304" y="0">
     * </use>
     * </g>
     */ 
  }
  
  renderFraction(FractionExpr expr) {
    // x/2
    /*
    <g transform="translate(120,0)">
   <rect stroke="none" width="697" height="60" x="0" y="220"></rect>
   <use href="#MJMATHI-78" x="60" y="443"></use>
   <use href="#MJMAIN-32" x="96" y="-599"></use>
   </g></g>
   */
  }
  
  renderPower(PowerExpr expr) {
    // x^2
    /*
     * <g stroke="black" fill="black" stroke-thickness="0" transform="matrix(1 0 0 -1 0 0)">
     * <use href="#MJMATHI-78"></use>
     * <use transform="scale(0.7071067811865476)" href="#MJMAIN-32" x="816" y="513">
     * </use>
     * </g>
     */
  }
  
  // Logical expressions 
  renderAnd(AndExpr expr) {
  }
  
  renderOr(OrExpr expr) {
  }
  
  // Object expressions 
  //
  
  // Relational expressions 
  renderEqual(EqualExpr expr) {
  }
  
  renderGreaterThan(GreaterThanExpr expr) {
  }
  
  renderGreaterThanOrEqual(GreaterThanOrEqualExpr expr) {
  }
  
  renderLessThan(LessThanExpr expr) {
  }
  
  renderLessThanOrEqual(LessThanOrEqualExpr expr) {
  }
  
  renderNotEqual(NotEqualExpr expr) {
  }
  
  // Set expressions 
  renderComplement(ComplementExpr expr) {
  }
  
  renderIntersect(IntersectExpr expr) {
  }
  
  renderNotSubset(NotSubsetExpr expr) {
  }
  
  renderSubset(SubsetExpr expr) {
  }
  
  renderUnion(UnionExpr expr) {
  }
}
