Puppet::Type.newtype(:domain) do
  @doc = "Manage Glassfish domains"

  ensurable

  newparam(:name) do
    desc "The Glassfish domain name."
    isnamevar
  end

  newparam(:startoncreate) do
    desc "Start the domain immediately after it is created. Default: true"
    defaultto true
  end

  newparam(:portbase) do
    desc "The Glassfish domain port base. Default: 4800"
    defaultto "4800"
  end

  newparam(:asadminuser) do
    desc "The internal Glassfish user asadmin uses. Default: admin"
    defaultto "admin"
  end

  newparam(:passwordfile) do
    desc "The file containing the password for the user."

    validate do |value|
      unless File.exists? value
        raise ArgumentError, "%s does not exists" % value
      end
    end
  end

  newparam(:user) do
    desc "The user to run the command as."

    validate do |user|
      unless Puppet.features.root?
        self.fail "Only root can execute commands as other users"
      end
    end
  end
  
  newparam(:enablesecureadmin) do
    desc "Should secure admin be enabled. Default: true"
    defaultto true
    
    validate do |value|
      if value 
        # Need to make sure that startoncreate is set to true, otherwise enable-secure-admin will fail. 
      end
    end
  end
end
