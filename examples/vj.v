import vj as j

fn main() {
	j.vj_init()
	// println("icici julia")
	// output echo
	j.eval("a = [1, 2, 4]")
	j.eval('println(a * 3)')
// 	// getting array (i.e. R Vector)
// 	a := j.f64('a')
// 	println(a)
// 	i := j.int('1:10')
// 	println(i)
// 	s := j.string("paste0('a',1:10)")
// 	println(s)
// 	// set a as double R vector from f64 array and check inside R
// 	j.set_f64('a', [1., 3, 2])
// 	println(j.f64('a'))
// 	// set b as integer R vector from int array and check inside R
// 	j.set_int('b', [1, 3, 2])
// 	println(j.int('b'))
// 	// set c as logical R vector from bool array and check inside R
// 	j.set_bool('c', [true, true, false])
// 	println(j.bool('c'))
// 	// set d as character R vector from string array and check inside R
// 	j.set_string('d', ['tutu', 'ititit'])
// 	println(j.string('d'))
// 	// j.eval("capabilities()")
// 	// j.eval("png('toto.png')")
// 	// j.eval("plot(1:10)")
// 	// j.eval("dev.off()")
}
