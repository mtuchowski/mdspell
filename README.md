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
```

On top of that, make sure that [GNU Aspell](http://aspell.net/) is installed on the system:

```console
# Ubuntu
$ sudo apt-get install aspell
# Arch Linux
$ sudo pacman -S aspell
```

## Usage

To spell-check markdown files, simply run `mdspell` with the filenames as a parameter:

```console
$ mdspell README.md
```

To check all markdown files within the directory:

```console
$ mdspell docs/
```

For each spelling error found, MdSpell will display the misspelled word, filename and line number:

```console
./README.md:10: actualy
```

## MIT Licensed

See [LICENSE](https://github.com/mtuchowski/mdspell/blob/master/LICENSE) file for full license
text.
