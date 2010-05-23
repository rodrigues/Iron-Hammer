module SteelHammer::Helpers::StringAddons
  def self.included(base)
    String.class_eval do
      def steel_hammer_class_name 
        result = self.
          gsub(%r{.*/}, '').
          gsub('.rb', '').
          capitalize

        while index = /_[^_]/ =~ result
          result[index, 2] = result[index + 1].upcase
        end

        result
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
