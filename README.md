# rspec_updater

A simple tool for updating older rspec syntax. It reads a file on a line by line basis looking for certain methods like `.should` and `.stub` and updates them accordingly.

`$ ruby app.rb /full/path/to/file.rb`

It can trip on certain conversions such as examples broken over multiple lines or those with unusual bracketing. Be sure to re-test having updated a file.
