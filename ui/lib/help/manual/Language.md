// TODO move into help system

==Sequence== 
{ x in 1..10 | (x) => x^2 }

A fully expanded sequence is returned as a list

==List== 
[1,2,3,4]

===List operations===
[1,2].append(3,4)   = [1,2,3,4]    (a list)
[1,2].append([1 2]) = fail
[1,2].head = 1
[1,2,3].tail = [2,3]
[1,2].reverse = [2,1]
[2,3].remove(1) = [3]
[1,2,3,2,3] \ [2] = [1,3,3]


==Interval== 
1..-1..-10

Intervals generates a set


==Set== 
{}      (empty set)
{a,b,c}

===Set Operations===
{a,b,c}.get(1) == a
a in {a,b,c} == true
d !in {a,b,c} == true
{a,b} union {b,c} == {a,b,c}   
{a,b} intersect {b,c} == {b} 
{2,3,4} ∖ {1,2,3} == {4}      (complement)
{a,b,c}.length() == 3
{a,b,c}.toList() == [a,b,c]


==Dictionary== 
d = dict() (empty dictionary)
{a:b} (single element dictionary)
{a:b, c:d}

===Dictionary operations===
d.add(key, value)
d.has(key)
d.remove(key)


==Vector== 
v = ()             (empty vector)
v = (1)            (single element vector)
v = (1, 2)         (double element vector)
v = vector([1,2])  (vector from list)

===Vector operations===



==Matrix==
m = (())                  (empty matrix)
m = ((1,2))               (single element matrix)
m = ((a,b),(c,d))         (double element matrix)
m = matrix([[1,2],[3,4]]) (matrix from list of lists)



==Puslers and Corner Cases==
Like most other Mathematical programming language Qalqo does multiplication inference, that is 
it will try to inject multiplication signs into expression like 2x = 2*x or 2(x+y) = 2*(x+y). 
However in certain special conditons, this can lead to surprises. The rules are as follows

- a number followed immedatly by a expression causes injection i.e. 
=== 2x = 2*x 
=== 2(x+y) = 2*(x+y)

- a symbol followed immedatly by any other expression does not! cuase injection i.e. 
=== x2 = is just a symbol called x2
=== x(2) or x(2,3,..) = is a function invocation of the (possibly undefined) function x

- a parentheses group followed immedatly by a symbol or other parentheses group causes injection
=== (x+y)(x+z) = (x+y) * (x+z)
=== f(x)(x+y) = f(x) * (x+y)

To avoid having to remember these rules its easier to always be explicit about multiplication.


==Multiline Functions and Blocks==
doesAllot(x) {
  y = x^2
  res = dsolve(y,x)
  return res
}

{1,2,3}.mapI((elm, index) {

})

// function declarations cannot have binary arguments
// if assign = block
a(x) { y = x }


==Non algebraic types==
Most types in qalqo can deal with algebraic expressions, with a few exceptions
- booleans
- dictionaries
- strings

A few examples will illustrate this

a = true + 3             // type error
b = "test" + 3           // type error
c = { "my": "name" } + 3 // type error

note that for dictionaries the values can contain algebraic expressions but not the keys

d = {
  "formula": x^2 + 2, // OK
  x: y + 2            // Type error key x is algebraic  
} 


==Optional typing==
Typing a variable fixes it's type permanently

Matrix A
A = Matrix() // OK empty matrix
A = 2 + c // type error

contrast to

A = Matrix() // OK empty matrix
A = 2 + c    // OK an algebraic expression

var varables are untyped but cannot as mentioned above reference 

==Blocks and Scope==
Functions that returns a value directly can be written without a block

f() = x     // OK function that always return the symbol x
g(x) = x^2  // OK function that evaluates squares its input

however assignment requires block scope

x
f() { x = 2 } // OK 

contrast to

x
f() = x = 2   // Syntax error setting x = 2 does not return a value

forgetting the block this can lead to som suttle errors

f(x) = x^2 // defines function f that squares its input 
x += y     // throws error as x is undefined

this should probably have been written like

f(x) {
  x = x^2 + y
  return x
} 

f(x) {
  x += a // x = x + a
}

f(y) // fails recursive assignment (y = y + a)
f(2) // = 2 + a

x = x + 1


==Variant Argument and Return values==
Declare that a function f can take a symbol or set of symbols
 
f((Symbol | Set<Symbol>) x)

declare that g can return a number or a list of numbers

(Number | List<Number>) g()