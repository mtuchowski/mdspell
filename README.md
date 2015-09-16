# MdSpell

[![Gem Version](https://badge.fury.io/rb/mdspell.svg)](http://badge.fury.io/rb/mdspell)
[![Build Status](https://travis-ci.org/mtuchowski/mdspell.svg)](
https://travis-ci.org/mtuchowski/mdspell)
[![Code Climate](https://codeclimate.com/github/mtuchowski/mdspell/badges/gpa.svg)](
https://codeclimate.com/github/mtuchowski/mdspell)
[![Test Coverage](https://codeclimate.com/github/mtuchowski/mdspell/badges/coverage.svg)](
https://codeclimate.com/github/mtuchowski/mdspell/coverage)
[![Inline docs](http://inch-ci.org/github/mtuchowski/mdspell.svg?branch=master)](
http://inch-ci.org/github/mtuchowski/mdspell)

A Ruby markdown spell checking tool.

## Installation

To install from [rubygems.org](http://rubygems.org/), run:

```console
$ gem install mdspell
Successfully installed mdspell-0.1.3
1 gem installed
```

On top of that, make sure that [GNU Aspell](http://aspell.net/) is installed on the system:

```console
# Ubuntu
$ sudo apt-get install aspell
# Arch Linux
$ sudo pacman -S aspell
```

## Usage

To spell-check markdown files, simply run `mdspell` with the filename (or directory) as
a parameter. For each spelling error found, MdSpell will display the misspelled word, filename
and line number:

```console
$ mdspell README.md spec
README.md:19: MD014 Dollar signs used before commands without showing output
README.md:36: MD014 Dollar signs used before commands without showing output
README.md:42: MD014 Dollar signs used before commands without showing output
spec/examples/with_errors.md:1: mispelled
spec/examples/with_errors.md:3: qiute
spec/examples/with_errors.md:3: actualy
spec/examples/with_errors.md:5: tobe
spec/examples/complete.md:24: Unordered
```

## MIT Licensed

See [LICENSE](https://github.com/mtuchowski/mdspell/blob/master/LICENSE) file for full license
text.
