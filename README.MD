# Vatican't  
(apostrophe used for styling)  
…is, strictly speaking, supposed to be a collection of helper libraries for DRGTK.

Given how `require` works in DRGTK currently and some other factors, I'm probably gonna be putting a single thing in each library.  
To overuse a joke I made on Discord, if a library houses only a single book on display — it should be called a "church".  
Thus, one could rather say that Vatican't is a collection of churches.

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
