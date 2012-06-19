## Installing the App

1. Clone this repository

        $ git clone https://github.com/runemadsen/Magic-Book-Project.git
        $ cd Magic-Book-Project

2. Use Ruby 1.9.3. To manage multiple rubies, install either [RVM](https://rvm.io//) or [rbenv](https://github.com/sstephenson/rbenv).
3. Run bundler to install gems (if you don't have bundler do `$ gem install bundler`).

        $ bundle install

4. We are using a custom build of the asciidoc gem. To keep track of changes to
this gem use git [submodules](http://git-scm.com/book/en/Git-Tools-Submodules).
From the root of the repository run the following two commands to initialize
the submodule and then get any updates.

        $ git submodule init
        $ git submodule update

5. Now you need the asciidoc program. We recommend installing asciidoc with
[homebrew](http://mxcl.github.com/homebrew/). Once you have homebrew installed
get the asciidoc keg like so

        $ brew install asciidoc

### Notes

If your book will include code blocks you'll need to install pygments for
syntax highlighting.

        $ sudo easy_install Pygments

## To run the app

1. `cd Magic-Book-Project`
2. `shotgun config.ru`
3. Then visit: localhost:9393/create_html/:filename in your browser

If it's been a while since you've used this app, update the asciidoc gem by
running `$ git submodule update`.
