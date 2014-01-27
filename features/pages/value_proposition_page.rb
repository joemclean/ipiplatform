class ValuePropositionPage < Page

    def initialize(page)
      super page
    end

    def navigate
      @page.visit(path)
    end

    def navigate_to_show_page value_proposition_id
      @page.visit("#{self.path}/#{value_proposition_id}")
    end

    def path
      '/value_propositions'
    end
end