# require 'pycall'
# # require 'numpy'
# PyCall.init('python3')
# # array = Numpy.asarray([10, 20, 30, 40])

# # min = Numpy.min(array)

# class Aaa
#   os = PyCall.import_module("os")
#   @ans = os.getcwd

#   def self.test
#     @ans
#   end
# end

require 'pycall'
puts PyCall::LibPython::Python.start(python: 'python3')  # Pythonのバージョンを指定
