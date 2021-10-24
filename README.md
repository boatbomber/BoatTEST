# BoatTEST

Boat's TrulyEasySimpleTesting - A Luau unit testing framework. Inspired by Elttob's FusionCI

## API

`function BoatTEST.run(config: dictionary)`

config.directories: A table of Instances to search for .spec ModuleScripts within
config.includeDescendants: A boolean that defines whether to run all descendant spec files of directories or just the direct children
config.verbose: A boolean that defines whether verbose logging is enabled
