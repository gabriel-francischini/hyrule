.. default-role:: code

Unreleased
==============================

Removals
------------------------------
* `ifp` has been removed. Use `branch` instead.

New Features
------------------------------
* New macro `block`.
* New macros `branch`, `ebranch`, `case`, and `ecase`.

Bug Fixes
------------------------------
* Destructuring macros now consistently return `None` in case of
  failing to match a certain pattern, instead of sometimes returning
  `None` and sometimes raising an exception.

0.1 (released 2022-01-09)
==============================

This is the first release of Hyrule per se. The one change below is
described relative to the ancestors of Hyrule in Hy 1.0a3.

Breaking Changes
------------------------------
* `coll?` now returns `False` for `bytes` objects.
