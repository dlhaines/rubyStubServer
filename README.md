# rubyStubServer

Ruby web server to stub http requests to matching disk files

This implements a simple file-based stub provider. Requests are mapped to nested directories and files.  Directories map to
url elements.  File names are derived from the trailing file name on the url.  If no matching file exists in the matching directory
then the default.<extension> file in the directory is used if it exists.  If neither exists then a 404 is returned.  
File names can also contain values for query parameters. Query parameters are sorted and values are matched to 
corresponding elements of the file name.  If there is
not a matching file then the default file for that directory will be used.

Only json files are currently supported.

Multiple stub servers can be run on different ports in order to stub out multiple dependencies.
