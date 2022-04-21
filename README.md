## v module to play with julia

(only tested on macOS)
### settings

Set the environment variables JULIA_CFLAGS, JULIA_CFLAGS_BIS and JULIA_LDFLAGS.

```bash
## julia is supposed to be in your PATH
. ./build_flags.sh
```

The output of ./build_flags.sh can be copied-pasted to your `.bashrc` or `.zshrc` to make the settings permanent 

### getting started

```v
import vj as j

fn main() {
	// get int array from julia 
	ai := j.eval('a = [1, 2, 4]')
	j.eval('println(a * 3)') // print in julia
	println('ai = $ai.ints()') // print in v

	// get string array from julia
	j.eval('["1", "2", "4"]')
	a := j.f64('12.9') // equivalent to j.eval('12.9').f64()
	println('a * 2 = ${a * 2}')

	// get bool from julia
	b := j.bool('true') // equivalent to j.eval('true').bool()
	println('b = $b')
	s := j.string('"toto"^2 * "titi"') // equivalent to j.eval('"toto"').string()
	println('s = $s')

	// set a as a float64 julia array
	j.set_f64s('a', [1.1, 3, 2])
	println(j.f64s('a'))
	j.eval('println(typeof(a))')
	j.set_f32s('a', [f32(1.1), 3, 2])
	println(j.f32s('a'))
	j.eval('println(typeof(a))')

	j.set_ints('b', [1, 3, 2])
	println(j.ints('b'))

	j.set_bools('c', [true, true, false])
	println(j.bools('c'))

	j.set_strings('d', ['tutu', 'ititit'])
	println(j.strings('d'))

	j.set_string('toto', 'titi')
	// push newly created toto variable in the d array
	j.eval('push!(d, toto)')
	// and print in julia
	j.eval('println(d)')
}
```