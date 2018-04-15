require_relative 'handler'

class Application
  def call(env)
    @request = Rack::Request.new(env)
    return time_response if @request.path_info == '/time/'
    response(404, 'Not found')
  end

  private

  def response(status, text)
    [status, {'Content-Type' => 'text/plain'}, [text]]
  end

  def time_response
    time = Handler.new(@request.params)
    response(time.status, time.response)
  end
end
