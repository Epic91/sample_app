# RUBY ON RAILS TUTORIAL: Sample Application

This is the sample application for the 
[*Ruby on Rails Tutorial: Learn Web Developement with Rails*](http://www.railstutorial.org/) by [Michael Hartl](http://www.michaelhartl.com)

## What I learned:
* Automated testing allows us to write test suites that drive the developement of new features, allow for confident refactoring and catch regressions.
* How to use the Rails **provide** function to set a different title on each page.
* How to use the **setup** function which is run automatically before every test
* Some browsers don't support HTML5 specially older versions of Internet Explorer so we include JS code known as **'HTML5 shim or shiv'** to   work around the issue. This line of code is located in the **application.html.erb file**
* Sass and the asset pipeline allows us to: *Refer to Chapter 5, section 5.2.2*
    1. nest our elements
    2. define variables to eliminate duplication and write more expressive code.
* Integration tests effectively simulate a browser clicking from page to page

## Code to take note of:
The assertion for the root path verifies that there are two such links(one each for the logo and navigation menu elements) this ensures that both links to the Home page are defined.
`assert_select "a[href=?]", root_path, count:2`