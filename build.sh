JL_SHARE=`julia -e 'print(joinpath(Sys.BINDIR, Base.DATAROOTDIR, "julia"))'`
export JULIA_CFLAGS=`${JL_SHARE}/julia-config.jl --cflags`
export JULIA_LDFLAGS=`${JL_SHARE}/julia-config.jl --ldflags`
export JULIA_LDLIBS=`${JL_SHARE}/julia-config.jl --ldlibs`