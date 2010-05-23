module SteelHammer::Anvil::InstanceMethods
  def contents
    self.file_system.all @path
  end
end
