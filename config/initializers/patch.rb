ActiveSupport.on_load(:action_view) do 
	ActionView::LookupContext::DetailsKey.class_eval do 
    class << self 
      alias :old_get :get 

      def get(details) 
        if details[:formats] 
          details = details.dup 
          syms    = Set.new Mime::SET.symbols 
          details[:formats] = details[:formats].select { |v| 
            syms.include? v 
          } 
        end 
        old_get details 
      end 
    end 
  end 

  ActionView::Template::Text.class_eval do 
    def formats 
      [@mime_type.respond_to?(:ref) ? @mime_type.ref : @mime_type.to_s] 
    end 
  end 
end