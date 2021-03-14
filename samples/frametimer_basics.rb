# Copy this sample code and replace contents of "main.rb" to easily run it.

# Clone the repository into a "lib" folder beside "app" where your "main.rb" is.
require '/lib/giatros/frametimer.rb'

def tick args
# Sawtooth-oscillating performance load.
  ((15 + Time.now.sec % 30)**2).times do
    args.outputs.solids <<
    { 
      x: rand(args.grid.w),
      y: rand(args.grid.h),
      w: rand(args.grid.w) * 0.1,
      h: rand(args.grid.h) * 0.1,
      a: 10
    }
  end
# Frametimer provides premade labels and a graph sprite with preset placements:

# You can use them as is…
  args.outputs.labels <<
    [
      Giatros::Frametimer.frametime_label,
      Giatros::Frametimer.fps_label
    ]
# …or modify their properties as with any other primitive.
  sprite = Giatros::Frametimer.graph
  sprite.w = 720
  sprite.h = 90
  sprite.x = args.grid.w - sprite.w
  sprite.y = args.grid.h - sprite.h
  
  args.outputs.sprites << sprite
end
