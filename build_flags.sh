# Run this once
JL_SHARE=`julia -e 'print(joinpath(Sys.BINDIR, Base.DATAROOTDIR, "julia"))'`
export JL_CFLAGS=`${JL_SHARE}/julia-config.jl --cflags`
export JL_LDFLAGS=`${JL_SHARE}/julia-config.jl --ldflags`
export JL_LDLIBS=`${JL_SHARE}/julia-config.jl --ldlibs`
export JULIA_CFLAGS=`julia -e 'print(join(split(replace(Base.ENV["JL_CFLAGS"], "\x27" => "")," ")[[2]], " ")[3:end])'`
export JULIA_CFLAGS_BIS=`julia -e 'print(join(split(replace(Base.ENV["JL_CFLAGS"], "\x27" => "")," ")[[1,3]], " "))'`
export JULIA_LDFLAGS=`julia -e 'print(replace(Base.ENV["JL_LDFLAGS"] * " " * Base.ENV["JL_LDLIBS"], "\x27" => "")[3:end])'`
unset JL_CFLAGS
unset JL_LDFLAGS
unset JL_LDLIBS
echo "Add these lines to your .zshrc or .bashrc"
echo "export JULIA_CFLAGS=\"$JULIA_CFLAGS\""
echo "export JULIA_CFLAGS_BIS=\"$JULIA_CFLAGS_BIS\""
echo "export JULIA_LDFLAGS=\"$JULIA_LDFLAGS\""
