module StubHelpers


  def getDiskFileName(base_dir,file_path, file_name)

    puts "dfn: base_dir: [#{base_dir}] file_path: [#{file_path}] file_name: [#{file_name}]"
    #full_file_path = settings.base_dir
    full_file_path = base_dir

    # assemble the right path
    if !file_path.nil? && file_path.length > 0
      puts "A: #{full_file_path}#{file_path}"
      full_file_path = "#{full_file_path}#{file_path}"
    end

    # see if the file exists
    if File.exists? ("#{full_file_path}/#{file_name}")
      return "#{full_file_path}/#{file_name}"
    end

    # see if a default file exists
    if File.exists? ("#{full_file_path}/default.json")
      return "#{full_file_path}/default.json"
    end

    # fail
    nil
  end

  # generate the list of plausible file names matching a request.
  def generate_data_file_list(prefix, infix, suffix)
    all_infix_strings(infix).map { |s| "#{prefix}#{s}#{suffix}" }.reverse
  end

  # make a list of possible file names, based on appending elements of infix and
  # adding the 'default' file name.
  def all_infix_strings(infix)
    #logger.debug "#{__method__}: #{__LINE__}: infix #{infix.inspect}"

    s = infix.inject(['']) { |strings, element|
      strings<<strings[-1]+element+'.'
      strings
    }
    s.slice!(0) # remove trivial value
    ['default.']+s
  end

end
