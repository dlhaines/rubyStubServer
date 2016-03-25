# rubyStubServer

Ruby web server to stub http requests to matching disk files.

This implements a simple file-based stub provider. Requests are mapped from an URL to nested directories and files.  
URL elements map to directories. File names are derived from the trailing file name on the url.  
If no matching file exists in the matching directory
then the file *default.&lt;extension&gt;* in the directory is used if it exists.   If neither exists then a 404 is returned.

File names can also contain values for query parameters.  They are currently ignored. 
A future feature will examine query parameters, sort them and add values to 
corresponding elements of the file name.  If there is
no matching file then the default file for that directory will be used.

Multiple stub servers can be run on different ports in order to stub
out multiple dependencies.  Multiple dependencies can be served from the same stub server as long as the URL spaces
are separate.

# LIMITATIONS
The server is only partly implemented.  Running the tests will show a list of potential / upcoming changes.

Major limitations are:

* Only json files are currently supported.
* Query parameters are ignored. 

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

1.  choose your working directory and check out the server code.
> git clone https://github.com/dlhaines/rubyStubServer.git
1.  checkout the appropriate branch (currently master)
1.  make sure your copy is up to date.
> git merge
1.  Setup required Ruby dependencies by running bundle.
> bundle install
1. Check the installation by running tests:
> rake test
1. Make sure that there is a data directory with directories and files matching the stub needs for the
 calls to the server.  The required format is described above.  The code comes with a couple of 
 build in stub configurations.  One is *demo/demo01*.  One is *standard/canvas*.

## Starting the server
The server is started by running:
> rake server:&lt;start_name&gt; &

Two server configurations are provided: *start_demo01*, and *start_canvas*.

The server configurations only setup environment variables for the
server.  To run a custom configuration just specify the enviroment
variables explicitly at the server invocation.  E.G.

> rake server MIN\_WAIT=&lt;number&gt; MAX\_WAIT=&lt;number&gt;  PORT=&lt;number&gt; DATA\_DIR=&lt;directory&gt; &

The *PORT* determines where the server will be available.
The *DATA_DIR* determines where on disk the server will 
look for files.
*MIN_WAIT* is the minimum time that the server will wait before returning a file.
*MAX_WAIT* is the maximum time that the server will wait before returning a file.

The default values are:

* port - 9100
* directory - &lt;startup directory&gt;/test/test-files/data
* MIN\_WAIT, MAX\_WAIT - 0

## Stub file configurations
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

These configurations include a *check.sh* bash script in the data directory.  These are meant
as a quick sanity check to see if a configured server is running as expected.  They are not meant 
to be a set of automated quality tests.

## Statistics

A request to the URL &lt;server:port&gt;/status.json will return the json described below.  The json extension is optional
but the results are always in JSON format. Entries starting with CONFIG_ are informational. CONFIG_WAIT_RANGE gives an 
array of the least and then longest amount of time that the server will wait before returning a response.  
CONFIG_START_NOW_TIME gives the server startup time and the current time of this request for statistics.  

For each URL request there will be an entry that gives the url with a value containing a 
list of the count of the number of requests and then the total wait time for this request.
CONFIG_DATA_DIR gives the disk directory containing the stub directories and files.

Sample JSON output: 

    {
    	"CONFIG_WAIT_RANGE": [0.0, 0.0],
    	"CONFIG_DATA_DIR": "/Users/dlhaines/dev/GITHUB/dlh-umich.edu/rubyStubServer/test/test-files/data",
    	"CONFIG_START_NOW_TIME": ["2016-02-19T15:31:08-05:00", "2016-02-19T16:11:00-05:00"],
    	"/": [12, 0.0],
    	"/exists": [8, 0.0],
    	"/exists.json": [7, 0.0],
    	"/exists.json.XXX": [1, 0.0],
    	"/exists.XXX": [1, 0.0],
    	"/ohcrap": [1, 0.0],
    	"/ohcrap/birds": [4, 0.0],
    	"/not\\_empty/exists.json": [1, 0.0],
    	"/not_empty/exists.json": [2, 0.0]
    }

## Accessing the server remotely
The server need not run on the same host as the consumer.  If ports
are not open on the stub server then port forwarding can be used to make them available.

### Port forwarding

Configuration of port forwarding can be confusing.  For local testing the appropriate command is likely to look very much like:
> ssh durango.ctools.org -L 9100:localhost:9100 -n -N -f

This will make the local 9100 port act as if it were the 9100 port on durango.  If the stub server is not running on durango
and/or is not using port 9100 those command should be adjusted accordingly.

The '-n -N -f' options allow the command to ask for authentication and
then run in the background.

NOTE: Sometimes port forwarding seems to slow down response time
considerably.  Using a local server, or a directly available one may
be preferable.
