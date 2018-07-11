# **Setup TL;DR**

Run the following command to **install all dependencies and serve** the website locally.
```
$ make
```
---

# Development Notes

### Managing Dependencies
All dependencies can be managed with three commands:

>`$ make install` download and install all dependencies.  
> `$ make static` copy all of the static depencency files into the `assets/vendor` folder.  
> `$ make update` update all dependencies.

> `$ make clean` wipe all dependency and generated \_site files.
> `$ make reinstall` wipes all dependency, \_site files and re-installs all dependencies.

These commands can be chained. ***To install, update, and copy all static files*** into the development folders, run:  
> `$ make install update static`

See `Makefile` for more details.


### Ruby & Node Dependencies

Jekyll and it's related plugins are installed and maintained via rubygems `bundle`.  
`$ cat Gemfile | grep gem` will display a list of ruby dependencies:
```
gem "jekyll", "~> 3.8.3"
  gem "jekyll-assets", "~> 3.0"
```

Development libraries are added and maintained via node using `yarn`.  
`$ yarn ls` will display a list of node dependencies:
```
BoldCommerce.com-v2
├── @fortawesome/fontawesome-free@5.1.0  
├── bootstrap@4.1.1  
├── jquery@3.3.1  
└── popper.js@1.14.3
```
