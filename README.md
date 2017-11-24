# vim-in-proportion

Resize vim's containing window and your splits resize proportionally.

This works well when I resize the window in gnome shell with <kbd>win</kbd> <kbd>←</kbd> et al.

```
+----------+-------------------------+      +----+-------------+-----------------+
|          |                         |      |    |             |/////////////////|
|          |                         |      |    |             |/////////////////|
|          |                         |      |    |             |/////////////////|
|          |                         |      |    |             |/////////////////|
|          |          V I M          |      |    |     VIM     |/////////////////|
|          |                         |  =>  |    |             |/////////////////|
|          |                         |      |    |             |/////////////////|
|          |                         |      |    |             |/////////////////|
+----------+-------------------------+      +----+-------------+/////////////////|
|                                    |      |                  |/////////////////|
+------------------------------------+      +------------------+-----------------+
```

Doesn't work so well when resizing with a mouse (at least for me in Alacritty on Ubuntu 17.10).

Pull requests happily accepted.
