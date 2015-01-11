# Debugging

An in-browser REPL (like irb) is in the works.  We also have source maps support, but it is currently disabled by default.  To enable source maps, run:

    MAPS=true volt s

This feature is disabled by default because (due to the volume of pages rendered) it slows down page rendering. We're working with the opal and sprockets teams to make it so everything is still served in one big source map file (which would show the files as they originated on disk).
