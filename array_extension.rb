module ArrayExtension
  refine Array do
    def sample_except_for(element)
      reject { |id| id == element }.sample
    end

    def format_for_slack
      text = []
      each do |element|
        text << "<@#{element}>\n"
      end
      text.join
    end
  end
end
