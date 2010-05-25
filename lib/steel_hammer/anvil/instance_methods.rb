module SteelHammer::Anvil::InstanceMethods
  def method_missing(name, *args, &block)
    @file_system_entry.send(name, *args, &block)
  end
end
