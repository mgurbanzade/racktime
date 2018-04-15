class Handler
  attr_reader :status

  TIME_FORMATS = {
    'year' => '%Y/',
    'month' => '%m/',
    'day' => '%d',
    'hour' => '%H:',
    'minute' => '%M:',
    'second' => '%S'
  }

  def initialize(params)
    @response = set_time_format(params)
    @correct_format = ''
    @incorrect_formats = []
  end

  private

  def show_incorrect_formats
    @status = 400
    "Incorrect time format #{@incorrect_formats}"
  end

  def show_time
    @status = 200
    Time.current.strftime(@correct_formats)
  end

  def parameters(params)
    params.each do |format|
      @correct_format += TIME_FORMATS[format] if TIME_FORMATS[format]
      @incorrect_formats << format
    end
  end

  def set_time_format(params)
    parameters(params['format'].split(','))

    return show_incorrect_formats unless @incorrect_formats.empty?
    show_time
  end
end
