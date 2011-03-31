Battery bars
------------

The only thing this software does is print a colored output of triangles
colored red, yellow or green. This is a visual representation of your battery
status. Green means power left, yellow means power used. If there's less than
10% of energy left, the entire bar turns red.

Using
-----

Zsh allows putting prompts to the right side of the terminal, which can be
updated every time the line changes.

By putting `setopt prompt_subst` to your .zshrc file, the prompts are
automatically updated with every change. Without it, they would be rendered
once and reused while the terminal is open.

Finish it off by putting `RPROMPT="\$(battery)"` to your .zshrc where `battery`
is the path to the executable. I have renamed mine from Battery to battery and
copied it to `$HOME/bin` which is in `$PATH`.
