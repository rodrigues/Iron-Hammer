class SteelHammer::Anvil
  steel_hammer_include_dependencies
  steel_hammer_include_class_methods
  steel_hammer_include_instance_methods

  def initialize path
    @file_system_entry = FileSystemEntry.at(path)
  end
end
