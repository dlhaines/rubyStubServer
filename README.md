# rubyStubServer

Ruby web server to stub http requests to matching disk files.

This implements a simple file-based stub provider. Requests are mapped from an URL to nested directories and files.  
URL elements map to directories. File names are derived from the trailing file name on the url.  
If no matching file exists in the matching directory
then the file *default.<extension>* in the directory is used if it exists.   If neither exists then a 404 is returned.
File names can also contain values for query parameters. Query parameters are sorted and values are matched to 
corresponding elements of the file name.  If there is
not a matching file then the default file for that directory will be used.

Multiple stub servers can be run on different ports in order to stub
out multiple dependencies.  Multiple dependencies can be served from the same stub server as long as the URL spaces
are separate.

# LIMITATIONS
The server is only partly implemented.  Running the tests will show a list of potential / upcoming changes.

Major limitations are:

* Only json files are currently supported.
* Query parameters are ignored. 
* There is no timing, count, or delay functionality.

# Running the stub server:

## initial environment setup

The server is written in Ruby and needs a ruby environment to run. These steps may need to be repeated from time to 
time as ruby versions change or dependencies are updated. 
They don't need to be repeated with each stub server installation. 

1.  install rvm (and configure it).  It's best to use the per-user
install method.  See https://rvm.io/
1.  install ruby-2.2.1 and make it the default 
> rvm --default use 2.2.1
1. install bundler.  See http://bundler.io/ for more information.
> gem install bundler


## Stub server installation
When installing / updating the stub server do the following steps:

1.  choose your working directory and make sure you have a copy of the
server. 
> git clone https://github.com/dlhaines/rubyStubServer.git
1.  checkout the appropriate branch (currently master)
1.  make sure your copy is up to date.
> git merge
1.  Setup required Ruby dependencies by running bundle.
> bundle install
1. Check the installation by running tests:
> rake test

## Running the server
The server is started by running:
> rake server PORT=\<number\> DATA_DIR=\<directory\> &

The *port* determines where the server will be available.
The *directory* determines where on disk the server will 
look for files.  

The default values are:

* port - 9292
* directory - \<startup directory\>/test/test-files/data

The defaults are suitable for running the test queries below.

* localhost:9292/ -> (404, not found)
* localhost:9292/exists -> ["default.json]"
* localhost:9292/exists.json -> ["exists.json]"
* localhost:9292/not\_empty/exists.json -> ["not_empty/exists.json"]
* localhost:9292/subdir/get\_default\_file\_not\_exact\_file.json ->
["subdir/default.json"]

## Stub configurations
You should expect to configure the Stub server for your current testing needs. 
To add a configuration simply put the required files in a directory available to the server and 
pass that directory name to the server on startup.  The format of the directory and files is described above.
A couple of standard / sample configurations are included in the build.  This allows
trivial installation of a server for selected APIs uses.  It is easy to supply a new
configuration for new needs.  Inclustion in the build is simply to provide examples.  They aren't
complete implementations of anything.

The current configurations included are:

* canvas
* demo01

The Canvas configuration files are in standard/canvas directory.  These files include a *check.sh* 
file that can be used as a quick local check to see if the stub server is working as expected.

## Running the server remotely
The server need not run on the same host as the consumer.  If ports
are not open on the stub server then port forwarding can be used to make them available.

### Port forwarding
Use a command like the following. 
> ssh durango.dsc.umich.edu -L 13306:localhost:3306 -n -N -f

In more detail:
> ssh **\<remote host\>** -L **\<localport to use\>:\<forwared host\>:\<forwareded port\>** -n -N -f

The '-n -N -f' options allow the command to ask for authentication and then run in the background.

Configuration of port forwarding can be confusing.  For local testing the appropriate command is likely to look very much like:
> ssh durango.ctools.org -L 9100:localhost:9100 -n -N -f

This will make the local 9100 port act as if it were the 9100 port on durango.  If the stub server is not running on durango
and/or is not using port 9100 those command should be adjusted accordingly.
