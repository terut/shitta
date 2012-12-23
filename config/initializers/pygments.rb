module Pygments
  module Popen
    private
    # Return the final result for the API. Return Ruby objects for the methods that
    # want them, text otherwise.
    def return_result(res, method)
      unless method == :lexer_name_for || method == :highlight || method == :css
        res = Yajl.load(res, :symbolize_keys => true)
      end
      res.strip
    end
  end
end
