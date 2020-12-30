class UserCsvRow
  def initialize(data)
    @username = data[0]
    @email    = data[1]
    @phone    = data[2]
  end

  def to_h
    {
      username: @username,
      email:    @email,
      phone:    clean_phone
    }
  end

  private

  def clean_phone
    @phone = @phone.gsub(/[^0-9A-Za-z]/, '')[/[^Xx]+/]
  end
end
