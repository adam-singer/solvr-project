# Solvr.io

Solvr is an open web and mobile platform for creating and sharing interactive mathematical 
content such calculations, visualizations, models and notes. 

Solvr allows teachers, students and amateurs to create and share stunning mathematical 
accross platforms such as mobile and web. 

## Contributing
To get started go over the list of modules below. We recommen you start out in the **kernel** as its the most
self contained unit. For an easy entry into contributing check out some of the issues listed in the milestones 
below.

 1. (Janitor features and bugs)[https://github.com/Solvr/solvr-project/issues?milestone=3&state=open]
   * The janitor list contains the features and bugs best suited for new comers 
 2. (Web features and bugs)[https://github.com/Solvr/solvr-project/issues?milestone=2&state=open] 

### Modules
Solvr consist of the following modules

 * **ast** Abstract syntax tree, defines the syntax for the Solvr algebraic language.
 * **backend** *(non-working) Placeholder project for Solvr's service code such as REST services*.
 * **common** Common utilities shared accross modules, such as test helpers,dart utility methods etc.
 * **doc** Documentation for Solvr.
 * **graphics** Renders AST expressions into LaTeX or SVG, also contains plotting code.
 * **iOS** *(non-working) Placeholder project for the Solvr PhoneGap iPad port*.
 * **kernel** Math kernel, simplifies expressions and contains all the numeric and symbolic algorithms. Also a REPL.
 * **logic** Business logic shared between **webapp** and **iOS** app goes here.
 * **parser** Parser for Solvr's algebraic language
 * **site** The http://solvr.io web site
 * **ui** UI constructs shared between **site** and **webapp**.
 * **webapp** The Solvr web application

## License

Solvr is made up of many pieces of code, all of them except the fonts are open source under
a business friendly license. See the LICENSE file for details.