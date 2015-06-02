# Tutorial

This guide will take you through creating a basic web application in Volt.  This tutorial assumes a basic knowledge of Ruby and web development.  Also this tutorial is a work in progress :-)

## Setup

First, let's install Volt and create an empty app.  Be sure you have ruby (>2.1.0) and rubygems installed.

Next install the volt gem:

    gem install volt

Using the volt gem, we can create a new project:

    volt new sample_project

This will setup a basic project in the sample_project folder.  We can ```cd``` into the folder and run the server:

    bundle exec volt server

Lastly, we can access the Volt console with:

    bundle exec volt console

