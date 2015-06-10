[:var_set('', """
#/ Compile command
aoikdyndocdsl -s README.src.md -n aoikdyndocdsl.ext.all::nto -g README.md
""")]\
[:var_set('source_file_name', 'aoikwinwhich.hy')]\
[:var_set('source_file_url', '/src/aoikwinwhich/aoikwinwhich.hy')]\
[:HDLR('heading', 'heading')]\
# AoikWinWhich
[AoikWinWhich](https://github.com/AoiKuiyuyou/AoikWinWhich) written in Hy.

Tested working with:
- Hy 0.11.0
- Python 2.7.9
- Python earlier versions should work but not tested
- Windows 8.1
- Windows earlier versions should work but not tested

## Table of Contents
[:toc(beg='next', indent=-1)]

## Setup
Clone this git repository to local:
```
git clone https://github.com/AoiKuiyuyou/AoiWinWhich-Hy
```

In the local repository directory, the source file is
[[:var('source_file_name')]]([:var('source_file_url')]).

Use program **hy** to run:
```
hy src/aoikwinwhich/aoikwinwhich.hy
```

## Usage
See [usage](https://github.com/AoiKuiyuyou/AoikWinWhich#how-to-use) in the
general project [AoikWinWhich](https://github.com/AoiKuiyuyou/AoikWinWhich).
