# Giatros
…is (so far) a framework of bite-sized helper libraries for DRGTK.  
Keep them together but `require` only the ones you need.  
I suggest creating a `/lib/` directory beside your `/app/` and cloning the repo into it.

*There is still much to optimize as the first implementations have many performance issues. I'm just concentrating on getting proofs of concept out first before I bury myself in analysis.*

## [Frametimer](/frametimer.rb)
A "plug-and-play" library for performance tracking of your project.  
Just `require` it and feed the primitives it provides to DRGTK rendering pipeline like this: `args.outputs.labels << Giatros::Frametimer.frametime_label`.  
*I could even have Frametimer do that last step for you but wanted you to be able to reposition, scale and color the primitives natively to your liking.*

Go check out the [basic sample](/samples/frametimer_basics.rb) if any of this isn't clear.

### [`Giatros::Frametimer::frametime_raw`](/frametimer.rb#L5) → `Float` (in seconds)
Returns delta-time (time elapsed) from start of the last tick (frame) to start of the current one.

### [`Giatros::Frametimer::frametime`](/frametimer.rb#L9) → `Float` (in seconds)
Returns the median frametiming of the last `n` (defined by `clock_window`) ticks (frames).

### [`Giatros::Frametimer::fps`](/frametimer.rb#L16) → `Float` (in frames-per-second)
Returns the median FPS of the last `n` (defined by `clock_window`) ticks (frames).

### [`Giatros::Frametimer::frametime_label`](/frametimer.rb#L20) → `Hash` (DRGTK label primitive)
Returns a pre-formatted frametime label (based on `frametime`) which you can directly feed to `args.outputs.labels` as is or after repositioning if you so choose.

### [`Giatros::Frametimer::fps_label`](/frametimer.rb#L28) → `Hash` (DRGTK label primitive)
Returns a pre-formatted FPS label (based on `fps`) which you can directly feed to `args.outputs.labels` as is or after repositioning if you so choose.

### [`Giatros::Frametimer::graph`](/frametimer.rb#L36) → `Hash` (DRGTK sprite primitive)
Returns a pre-formatted frametime sprite (based on `frametime_raw`) which you can directly feed to `args.outputs.sprites` as is or after repositioning/resizing if you so choose.  
`clock_window` dictates the internal horizontal resolution.

### [`Giatros::Frametimer::clock_window`](/frametimer.rb#L60) → `Fixnum`
Returns the current length of the rolling window of last ticks (frames) stored to be used for the graph and median-averaging.

### [`Giatros::Frametimer::clock_window=(framecount)`](/frametimer.rb#L64) → `Fixnum`
Allows to set the length of the rolling window of last ticks (frames) stored to be used for the graph and median-averaging.

**WARNING:** it's currently discouraged to increase this clock window due to performance issues. An optimization that would allow for better performance scaling is pending.

## [Nil panic](/nil_panic.rb)
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

(You should get a different error if `nil` was the first operand but that's a whole another story and may later change on DRGTK side.)

## [Array#median](/array_median.rb) → `Float`
I've still no idea why a `median` method isn't already a part of Ruby or mRuby core but here you go for all your statistical needs.

If you're unfamiliar with how `median` is calculated:  
Sort a set and pick the middle or the average of 2 middle values depending on whether it is odd or even.

## [Array#sum](/array_sum.rb) → `Numeric`
Did I already mention DRGTK is weird? So while you can use `Array#sum` in Ruby proper — it's not defined in DRGTK.  
Well, surely, you can just `array.inject(:+)` like in ye olden times, right… right? Not so fast.  
Arithmetical operators in DRGTK are complete magic and sometimes decide to stop existing at all. Especially when you call `Array#inject` or `Array#reduce`.

The workaround is to use the block overload of `reduce`/`inject` like this: `[4, 20].reduce{|sum, summand| sum + summand}`. So you could either use that monstrosity raw or `[4, 20].sum` if you `require array_sum.rb`.
