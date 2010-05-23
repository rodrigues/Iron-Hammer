module SteelHammer::Anvil::InstanceMethods
  def method_missing(name, *args, &block)
    super unless @file_system_entry.respond_to? name
    @file_system_entry.send(name, *args, &block)
  end
end
