module ArrayExtension
  refine Array do
    def sample_except_for(element)
      reject { |id| id == element }.sample
    end

    def format_for_slack
      text = []
      each do |element|
        text << format_id(element)
      end
      text.join
    end

    private

    def format_id(element)
      "<@#{element}>\n"
    end
  end
end
