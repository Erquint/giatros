require '/lib/frametimer.rb'

def tick args
  if args.state.tick_count.zero?
    $target = 31.62
    $magic_coefficient = 240
  end
  if args.state.tick_count > 0
    $load = $target - (Giatros::Frametimer.frametime_raw * $magic_coefficient)
    # ((15 + Time.now.sec % 30)**2).times do
    ($load.clamp(1, 60)**2).times do
      args.outputs.solids <<
      {
        x: rand(args.grid.w),
        y: rand(args.grid.h),
        w: rand(args.grid.w) * 0.1,
        h: rand(args.grid.h) * 0.1,
        a: 10
      }
    end
    
    args.outputs.sprites << Giatros::Frametimer.graph
    args.outputs.labels << Giatros::Frametimer.frametime_label <<
      Giatros::Frametimer.fps_label
  end
end
