[Fixnum, Float].each do |class_handle|
  [:+, :-, :*, :/].each do |method_symbol|
    class_handle.define_method method_symbol do |arg|
      raise TypeError, "TypeError (nil can't be coerced into #{self.class}): " +
        "#{self.inspect} #{method_symbol} #{arg.inspect}" if arg.nil?
    end
  end
end
