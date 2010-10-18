module ActiveRecord
  class Base
    before_save :update_sanitizer_version
    def update_sanitizer_version
      sanitizer_attrs = {}
      ArchiveConfig.FIELDS_ALLOWING_HTML.each do |field|
        if self.respond_to?("#{field}_changed?") && self.send("#{field}_changed?")
          sanitizer_attrs["#{field}_sanitizer_version"] = ArchiveConfig.SANITIZER_VERSION
        end
      end
      self.attributes = sanitizer_attrs
    end    
  end 
end 
