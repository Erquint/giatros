# Giatros
…is (so far) a framework of bite-sized helper libraries for DRGTK.  
Keep them together but `require` only the ones you need.

Yes, I renamed it and removed the joke. Sorry if you liked it.

## nil_panic.rb
Sick of pesky `nil`s getting into your arithmetics and DRGTK silently allowing them to spread like `NaN`s?  
Tired of wasting time on hunting down the specific instruction that plagued your calculations with `nil` in the first place?

Frankly, exceptions were invented for this but lacking in DRGTK.  
Just `require` this library to return exceptions on `nil` arithmetics attempts.

Here's an example of the exception:
```
-> 4/nil
* EXCEPTION: TypeError (nil can't be coerced into Fixnum): 4 / nil
```
Yup, it even tells you the operation that caused it along with the first operand.

(You'll get a different error if `nil` was the first operand but that's a whole another story…)

## array_sum.rb
`Array#sum`  
Did I already mention DRGTK is weird? So while you can use `Array#sum` in Ruby proper — it's not defined in DRGTK.  
Well, surely, you can just `array.inject(:+)` like in ye olden times, right? …right? Not so fast.  
Arithmetical operators in DRGTK are complete magic and sometimes decide to stop existing at all. Especially when you call `Array#inject` or `Array#reduce`.

The workaround is to use the block overload of `reduce`/`inject` like this: `[4, 20].reduce{|sum, summand| sum + summand}`. So you could either use that monstrosity raw or `[4, 20].sum` if you `require array_sum.rb`.

## array_median.rb
`Array#median`  
I've still no idea why a `median` method isn't already a part of Ruby or mRuby core but here you go for all your statistical needs.

If you're unfamiliar with how `median` is calculated:  
Sort a set and pick the middle or the average of 2 middle values depending on whether it is odd or even.
