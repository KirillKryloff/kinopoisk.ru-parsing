class Film
  attr_reader :director, :title, :year

  URL = "https://www.kinopoisk.ru/top/lists/1/"

  def self.from_list
    films = []
    html = open(URL)
    doc = Nokogiri::HTML(html)
    doc.css('table#itemList .news').each do |film|
      title_parse = film.css("a").first.text
      director_parse = film.css(".gray_text a").first.text
      year_parse = film.css("span").first.text.scan(/\d{4}/)[0]
      films << Film.new(director_parse, title_parse, year_parse)
    end
    films
  end

  def initialize(director, title, year)
    @director = director
    @title = title
    @year = year
  end

  def to_s
    "#{director} - #{title} (#{year})"
  end
end
