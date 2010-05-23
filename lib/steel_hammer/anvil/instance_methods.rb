module SteelHammer::Anvil::InstanceMethods
  def contents
    self.file_system.contents_of @path
  end
end
