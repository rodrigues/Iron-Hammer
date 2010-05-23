module SteelHammer::Anvil::InstanceMethods
  def method_missing(name, *args, &block)
    super unless @file_system_entry.respond_to? name
    return @file_system_entry.send(name) if (args.nil? || args.empty?) && block.nil?
    @file_system_entry.send(name, *args, &block)
  end
end
