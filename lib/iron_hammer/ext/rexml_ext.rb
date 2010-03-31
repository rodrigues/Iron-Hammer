require 'rexml/document'

REXML::Attribute.class_eval( %q^
      def to_string
        %Q[#@expanded_name="#{to_s().gsub(/\"/, '&quot;')}"]
     end
  ^ )