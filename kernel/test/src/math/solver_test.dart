// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class SolverTest {
  /*
  95. Rationalise(x^-0.5) x^(-1/2) x^(-1/2)
  96. Rationalise(x^0.125) Rationalise(x^0.125) x^(1/8)
  97. RationaliseMonomial(2^(-1/2)) 1/2*2^(1/2) 1/2*2^(1/2)
  98. RationaliseMonomial(x^(-1/4)) x^(3/4)*x^(-1) x^(3/4)*x^(-1)
  99. 2/3*RationaliseMonomial(2^(-1/2)) 1/3*2^(1/2) 1/3*2^(1/2)
  100. RationaliseBinomial((5^(1/2)+6)^-1) (-1/31)*(5^(1/2)-6) (-1/31)*(5^(1/2)-6)
  101. RationaliseBinomial((x^(1/2)-y)^-1) (-y-x^(1/2))*(y^2-x)^(-1) (-y-x^(1/2))*(y^2-x)^(-1)
  102. Expand((2+3^(1/2))*RationaliseBinomial((1+2^(1/2))^-1))2^(1/2)*3^(1/2)-3^(1/2)+2*2^(1/2)-22^(1/2)*3^(1/2)-3^(1/2)+2*2^(1/2)-2
  103. CombineBases(Hold(5^8)*Hold(6^8)) 30^8 30^8
  104. CombineBases(x^8*y^8) (x*y)^8 (x*y)^8
  105. CombineBases(-9^z*1^z*8^z) (-72)^z (-72)^z
  106. TrigToExp(Sin(x)) -I*1/2*E^(I*x)+I*1/2*E^(-I*x) -I*1/2*E^(I*x)+I*1/2*E^(-I*x)
  107. Sin(x)^2+Cos(x)^2 1 1
  108. E^(I*Pii(1)) -1 -1
  109. TrigToExp(ArcSin(x)) -I*Log((-x^2+1)^(1/2)+I*x) -I*Log((-x^2+1)^(1/2)+I*x)
  110. TrigToExp(Cos(x)) 1/2*E^(I*x)+1/2*E^(-I*x) 1/2*E^(I*x)+1/2*E^(-I*x)
  111. TrigToExp(ArcCos(x)) I*Log((-x^2+1)^(1/2)+I*x)+1/2*PiI*Log((-x^2+1)^(1/2)+I*x)+1/2*Pi
  112. TrigToExp(Tan(x)) I*(-E^(I*x)+E^(-I*x))*(E^(I*x)+E^(-I*x))^(-1)I*(-E^(I*x)+E^(-I*x))*(E^(I*x)+E^(-I*x))^(-1)
  113. TrigToExp(ArcTan(x)) -I*1/2*Log(I*x+1)+I*1/2*Log(-I*x+1)-I*1/2*Log(I*x+1)+I*1/2*Log(-I*x+1)
  114. Roots(2*x-10) 5 (5)
  115. Roots(x^2-9) (3, -3) (3, -3)
  */
}

