class ColorsPage < Page

    def initialize(page)
      super page
    end

    def navigate
      @page.visit(path)
    end

    def navigate_to_show_page color_id
      @page.visit("#{self.path}/#{color_id}")
    end

    def path
      '/colors'
    end
end