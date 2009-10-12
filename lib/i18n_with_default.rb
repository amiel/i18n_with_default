module I18n
	unless self.respond_to? :translate_with_en_default
		class << self
			def translate_with_en_default(key, options = {})
				return translate_without_en_default(key, options) if locale.to_sym == :en
				translate_without_en_default key, options.merge(:raise => true)
			rescue MissingTranslationData => e
				begin
					translate_without_en_default key, options.merge(:raise => true, :locale => :en)
				rescue MissingTranslationData
					options[:raise] ? raise : e.message
				end
			end
			alias_method_chain :translate, :en_default
			alias_method :t, :translate
		end
	end
end
