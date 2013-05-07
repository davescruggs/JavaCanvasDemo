#Canvas Demo for Summer 13 Force.com New Features Webinar#

## Setup instructions ##

###There are three components that can be used in this demo.###
1.)	Message publisher
2.)	Message subscribes
3.)	Canvas resizer

In order to run the demo you will need a pre-release org instance. It’s highly recommended that you use a Developer Edition (DE) instance as some of the other features of Canvas won’t be available unless you use a DE instance.
There are two main citizens of this demo you will need. One requires a bit of extra effort, explained below. The first and simplest is the Visualforce page containing the Canvas components, the second and more detailed in the Java application containing the modules to be exposed in the Visualforce Canvas components.

###Getting the Java Application###
Currently the application is hosted on Heroku. You will need to Git clone it from there. Make a new application directory on your local machine, open a command prompt at enter the following command

`$git clone git@heroku.com:mighty-inlet-5517.git`