# rubyStubServer
Ruby web server to stub requests to matching disk files

Implement trivial file-based ESB stub provider for StudentDashboard API.   If a data file exists that matches the
the name and/or term in a request the contents of that files it will be returned as json.  If no such file
is found a default file will be returned.   See the Ruby code for details.

