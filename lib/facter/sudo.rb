Facter.add("sudoversion") do
  ENV["PATH"]="/bin:/sbin:/usr/bin:/usr/sbin"

  setcode do
    output = `sudo -V 2>&1`
    if $?.exitstatus.zero?
      m = /Sudo version (.+)$/.match output
      if m
        m[1]
      end
    end
  end
end
