// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class TrigonometryTest {
  TrigonometryTest() {
    group("functions (trigonometry)", () {
      test("replace", () {
        /*
        17. sin(60) -0.304810621 -0.3048106211022167
        18. Sin(x) Sin(x) Sin(x)
        19. asin(0.4) 0.411516846 0.41151684606748806
        20. ArcSin(x) ArcSin(x) ArcSin(x)
        21. cos(60) -0.95241298 -0.9524129804151563
        22. Cos(x) Cos(x) Cos(x)
        23. acos(0.4) 1.15927948 1.1592794807274085
        24. ArcCos(x) ArcCos(x) ArcCos(x)
        25. tan(60) 0.320040389 0.320040389379563
        26. Tan(x) Tan(x) Tan(x)
        27. atan(0.4) 0.380506377 0.3805063771123649
        28. ArcTan(x) ArcTan(x) ArcTan(x)
        */
      });
    });
  }
}
