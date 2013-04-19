Facter.add("sudoversion") do
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
