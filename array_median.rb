require '/lib/array_sum.rb'

module Giatros
  Array.define_method :median do
    raise TypeError, "TypeError (method :median was called on " +
      "an empty Array): [].median" if self.empty?
    raise TypeError, "TypeError (method :median was called on " +
      "an Array containing non-numeric types):\n#{self.inspect}.median"\
        if self.any?{|value| !(Numeric === value)}
    return self.first if self.size == 1
    return (self.sum / 2.0) if self.size == 2
    sorted = self.sort
    middleFloor = (self.size - 1) / 2
    output = sorted[middleFloor]
    output = (output + sorted[middleFloor + 1]) / 2.0 if self.size.even?
    return output
  end
end
