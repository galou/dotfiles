Configuration to be used with `chezmoi_modify_manager<https://github.com/VorpalBlade/chezmoi_modify_manager>`_.

``modify_`` scripts bypass the check for "Did the file change in the target
state" that chezmoi performs. This is essential for proper operation.
However it also means that you will not be asked about overwriting changes.
Always look at ``chezmoi diff`` first! I do have some ideas on how to mitigate
this in the future. See also `this chezmoi bug<https://github.com/twpayne/chezmoi/issues/2244>`_
for a more detailed discussion on this.

The official version requires Python 3.10 but a version for Python 3.8 can be found at `galou's fork<https://github.com/galou/chezmoi_modify_manager>`_.
