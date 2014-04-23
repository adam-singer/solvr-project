[![Build Status](https://drone.io/github.com/Solvr/solvr-project/status.png)](https://drone.io/github.com/Solvr/solvr-project/latest)

# Solvr.io

Solvr is an open web and mobile platform for creating and sharing interactive mathematical 
content such calculations, visualizations, models and notes. 

Solvr allows teachers, students and amateurs to create and share stunning mathematical 
accross platforms such as mobile and web. 

## Contributing
To get started go over the list of modules below. We recommen you start out in the **kernel** as its the most
self contained unit. For an easy entry into contributing check out some of the issues listed in the milestones 
below.

 1. [Janitor features and bugs](https://github.com/Solvr/solvr-project/issues?milestone=3&state=open)
   * The janitor list contains the features and bugs best suited for new comers 
 2. [Web features and bugs](https://github.com/Solvr/solvr-project/issues?milestone=2&state=open) 

### Modules
Solvr consist of the following modules

 * **[analyzer](analyzer/README.md)** Type analyzer for the Solvr language
 * **ast** Abstract syntax tree and syntax for the Solvr algebraic language.
 * **backend** *(non-working) Placeholder project for Solvr's backend REST services*.
 * **[chrome](chrome/README.md)** *(non-working) Placeholder project for Solvr's Chrome plugin*
 * **common** Common utilities shared accross modules, such as test helpers,dart utility methods etc.
 * **[data](data/README.md)** Open data for Solvr computations and lookup
 * **doc** Documentation for Solvr.
 * **graphics** Renders AST expressions into LaTeX or SVG, also contains plotting code.
 * **iOS** *(non-working) Placeholder project for the Solvr PhoneGap iPad port*.
 * **kernel** The Mathematical algorithms for simplifying and computing Solvr expressions. 
 * **logic** Business logic shared between **webapp** and **iOS** app goes here.
 * **matchers** Matchers for detecting and acting on various expressions types
 * **[parser](parser/README.md)** Parser for the Solvr language.
 * **site** The Solvr web site
 * **types** Types of operators and expressions supported by Solvr 
 * **ui** Shared user interface constructs
 * **webapp** The Solvr web application
 
## License

Solvr is made up of many pieces of code, all of them except the fonts are open source under
a business friendly license. See the LICENSE file for details.
