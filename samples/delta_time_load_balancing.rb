require '/lib/giatros/frametimer.rb'

def tick args
  if args.state.tick_count.zero?
    $target = 1 / 30
    $unit_load = 500e3
    $load = 1e-3
    $last_load = 1e-3
  end
  
  if args.state.tick_count > 0
    # Load required to compensate.
    $load = $target - Giatros::Frametimer.frametime_raw
    # Preventing hysterical overcorrection.
    $load = $load.clamp($last_load - 1e-5, $last_load + 1e-5)
    $last_load = $load
    
    ($load * $unit_load).truncate.times do
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
