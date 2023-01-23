class BookDto
  attr_reader :title

  # Some other attributes...
  # Some validations etc...

  def save
    raise "You can't save a DTO. Come on it's not ActiveRecord 🤪"
  end
end
