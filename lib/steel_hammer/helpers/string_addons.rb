module SteelHammer::Helpers::StringAddons
  def self.included(base)
    String.class_eval do
      def steel_hammer_class_name 
        self.
          gsub(%r{.*/}, '').
          gsub('.rb', '').
          gsub(%r{_([^_])}, "\1").
          capitalize
      end
      
      def steel_hammer_path
        result = self.clone
        while index = /::[A-Z]/ =~ result
          result[index, 3] = "/#{result[index + 2].downcase}"
        end
        result[0] = result[0].downcase
        while index = /[A-Z]/ =~ result
          result[index] = "_#{result[index].downcase}"
        end
        result
      end
    end
  end
end
