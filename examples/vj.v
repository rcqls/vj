import vj as j

fn main() {
	ai := j.eval('a = [1, 2, 4]')
	j.eval('println(a * 3)')
	println('ai = $ai.ints()')
	j.eval('["1", "2", "4"]')
	a := j.eval('12.9').f64()
	println('a * 2 = ${a * 2}')
	b := j.eval('true').bool()
	println('b = $b')
	s := j.eval('"toto"').string()
	println('s = $s')

	// set a as double R vector from f64 array and check inside R
	j.set_f64s('a', [1.1, 3, 2])
	println(j.eval('a').f64s())
	j.eval('println(typeof(a))')
	j.set_f32s('a', [f32(1.1), 3, 2])
	println(j.eval('a').f32s())
	j.eval('println(typeof(a))')
	// set b as integer R vector from int array and check inside R
	j.set_ints('b', [1, 3, 2])
	println(j.eval('b').ints())
	// set c as logical R vector from bool array and check inside R
	j.set_bools('c', [true, true, false])
	println(j.eval('c').bools())
	// set d as character R vector from string array and check inside R
	j.set_strings('d', ['tutu', 'ititit'])
	println(j.eval('d').strings())

	j.set_string('toto', 'titi')
	j.eval('push!(d, toto)')
	j.eval('println(d)')
}
