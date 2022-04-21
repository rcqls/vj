## v module to play with julia

(only tested on macOS)
### settings

Set the environment variables JULIA_CFLAGS, JULIA_CFLAGS_BIS and JULIA_LDFLAGS.

```bash
## julia is supposed to be in your PATH
. ./build.sh
```

Think later to put this in your `.bashrc` or `.zshrc` 

### getting started

```v
import vj as j

fn main() {
	ai := j.eval("a = [1, 2, 4]")
	j.eval('println(a * 3)')
	println("ai = $ai.ints()")
	j.eval('["1", "2", "4"]')
	a := j.eval('12.9').f64()
	println("a * 2 = ${a * 2}")
	b := j.eval('true').bool()
	println("b = ${b}")
	s := j.eval('"toto"').string()
	println("s = ${s}")

	// set a as double julia vector from f64 array and check inside julia
	j.set_f64s('a', [1.1, 3, 2])
	println(j.eval('a').f64s())
	j.eval("println(typeof(a))")
	j.set_f32s('a', [f32(1.1), 3, 2])
	println(j.eval('a').f32s())
	j.eval("println(typeof(a))")
	// set b as integer julia vector from int array and check inside julia
	j.set_ints('b', [1, 3, 2])
	println(j.eval('b').ints())
	// set c as a boolean julia vector from bool array and check inside julia
	j.set_bools('c', [true, true, false])
	println(j.eval('c').bools())
	// set d as a string julia vector from string array and check inside julia
	j.set_strings('d', ['tutu', 'ititit'])
	println(j.eval('d').strings())

	j.set_string('toto', "titi")
	j.eval("push!(d, toto)")
	j.eval("println(d)")
}
```