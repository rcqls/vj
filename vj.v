module vj

#flag $env('JULIA_CFLAGS')
#flag $env('JULIA_CFLAGS_BIS')
#flag -L $env('JULIA_LDFLAGS')

#include "@VMODROOT/vj.h"

fn C.jl_init() int
fn C.jl_atexit_hook(exitcode int)
fn C.jl_eval_string(cmd &char) voidptr
fn C.jl_unbox_long(val voidptr) int
fn C.jl_unbox_float64(val voidptr) f64
fn C.jl_unbox_float32(val voidptr) f32
fn C.jl_unbox_bool(val voidptr) bool
fn C.jl_string_ptr(val voidptr) &char
fn C.jl_array_rank(val voidptr) int
fn C.jl_array_size(val voidptr, d int) int
fn C.jl_arrayref(val voidptr, i int) voidptr
fn C.jl_arrayset(arr voidptr, val voidptr, i int)
fn C.jl_box_float64(x f64) voidptr
fn C.jl_box_float32(x f32) voidptr
fn C.jl_box_long(x int) voidptr
fn C.jl_box_bool(x bool) voidptr
fn C.jl_cstr_to_string(x &char) voidptr

fn C.vj_typeof(val voidptr) int
fn C.vj_alloc_array(typ int, n int) voidptr
fn C.vj_assign(name &char, val voidptr)

fn init() {
	C.jl_init()
}

pub fn eval(cmd string) Res {
	res := C.jl_eval_string(cmd.str)
	// println(C.vj_typeof(res))
	return match C.vj_typeof(res) {
		1 {
			Res(C.jl_unbox_long(res))
		}
		32 {
			Res(C.jl_unbox_float32(res))
		}
		64 {
			Res(C.jl_unbox_float64(res))
		}
		2 {
			Res(C.jl_unbox_bool(res))
		}
		3 {
			unsafe {
				Res(cstring_to_vstring(C.jl_string_ptr(res)))
			}
		}
		101 {
			mut a := []int{}
			len := C.jl_array_size(res, 0)
			for i in 0 .. len {
				a << C.jl_unbox_long(C.jl_arrayref(res, i))
			}
			Res(a)
		}
		102 {
			mut a := []bool{}
			len := C.jl_array_size(res, 0)
			for i in 0 .. len {
				a << C.jl_unbox_bool(C.jl_arrayref(res, i))
			}
			Res(a)
		}
		132 {
			mut a := []f32{}
			len := C.jl_array_size(res, 0)
			for i in 0 .. len {
				a << C.jl_unbox_float32(C.jl_arrayref(res, i))
			}
			Res(a)
		}
		164 {
			mut a := []f64{}
			len := C.jl_array_size(res, 0)
			for i in 0 .. len {
				a << C.jl_unbox_float64(C.jl_arrayref(res, i))
			}
			Res(a)
		}
		103 {
			mut a := []string{}
			len := C.jl_array_size(res, 0)
			for i in 0 .. len {
				a << unsafe { cstring_to_vstring(C.jl_string_ptr(C.jl_arrayref(res, i))) }
			}
			Res(a)
		}
		else {
			Res('_none_')
		}
	}
}

// get data from julia

pub fn f64(cmd string) f64 {
	return eval(cmd).f64()
}

pub fn f32(cmd string) f32 {
	return eval(cmd).f32()
}

pub fn bool(cmd string) bool {
	return eval(cmd).bool()
}

pub fn int(cmd string) int {
	return eval(cmd).int()
}

pub fn string(cmd string) string {
	return eval(cmd).string()
}

pub fn f64s(cmd string) []f64 {
	return eval(cmd).f64s()
}

pub fn f32s(cmd string) []f32 {
	return eval(cmd).f32s()
}

pub fn bools(cmd string) []bool {
	return eval(cmd).bools()
}

pub fn ints(cmd string) []int {
	return eval(cmd).ints()
}

pub fn strings(cmd string) []string {
	return eval(cmd).strings()
}

// set variable inside main julia module
pub fn set_f64(var string, val f64) {
	val_jl := C.jl_box_float64(val)
	C.vj_assign(var.str, val_jl)
}

pub fn set_f32(var string, val f32) {
	val_jl := C.jl_box_float32(val)
	C.vj_assign(var.str, val_jl)
}

pub fn set_int(var string, val int) {
	val_jl := C.jl_box_long(val)
	C.vj_assign(var.str, val_jl)
}

pub fn set_bool(var string, val bool) {
	val_jl := C.jl_box_bool(val)
	C.vj_assign(var.str, val_jl)
}

pub fn set_string(var string, val string) {
	val_jl := C.jl_cstr_to_string(val.str)
	C.vj_assign(var.str, val_jl)
}

pub fn set_f64s(var string, arr []f64) {
	mut arr_jl := C.vj_alloc_array(164, arr.len)
	for i, e in arr {
		C.jl_arrayset(arr_jl, C.jl_box_float64(e), i)
	}
	C.vj_assign(var.str, arr_jl)
}

pub fn set_f32s(var string, arr []f32) {
	mut arr_jl := C.vj_alloc_array(132, arr.len)
	for i, e in arr {
		C.jl_arrayset(arr_jl, C.jl_box_float32(e), i)
	}
	C.vj_assign(var.str, arr_jl)
}

pub fn set_ints(var string, arr []int) {
	mut arr_jl := C.vj_alloc_array(101, arr.len)
	for i, e in arr {
		C.jl_arrayset(arr_jl, C.jl_box_long(e), i)
	}
	C.vj_assign(var.str, arr_jl)
}

pub fn set_bools(var string, arr []bool) {
	mut arr_jl := C.vj_alloc_array(102, arr.len)
	for i, e in arr {
		C.jl_arrayset(arr_jl, C.jl_box_bool(e), i)
	}
	C.vj_assign(var.str, arr_jl)
}

pub fn set_strings(var string, arr []string) {
	mut arr_jl := C.vj_alloc_array(103, arr.len)
	for i, e in arr {
		C.jl_arrayset(arr_jl, C.jl_cstr_to_string(e.str), i)
	}
	C.vj_assign(var.str, arr_jl)
}


type Res = []bool | []f32 | []f64 | []int | []string | bool | f32 | f64 | int | string

pub fn (r Res) f64() f64 {
	return if r is f64 { r } else { 0.0 }
}

pub fn (r Res) f32() f32 {
	return if r is f32 { r } else { f32(0) }
}


pub fn (r Res) int() int {
	return if r is int { r } else { 0 }
}

pub fn (r Res) bool() bool {
	return if r is bool { r } else { false }
}

pub fn (r Res) string() string {
	return if r is string { r } else { '' }
}

pub fn (r Res) f64s() []f64 {
	return if r is []f64 { r } else { []f64{} }
}

pub fn (r Res) f32s() []f32 {
	return if r is []f32 { r } else { []f32{} }
}

pub fn (r Res) ints() []int {
	return if r is []int { r } else { []int{} }
}

pub fn (r Res) bools() []bool {
	return if r is []bool { r } else { []bool{} }
}

pub fn (r Res) strings() []string {
	return if r is []string { r } else { []string{} }
}

/*
array_type=jl_apply_array_type((jl_value_t*)jl_float64_type, 1);
    ans=(jl_value_t*)jl_alloc_array_1d(array_type,n);
    for(i=0;i<n;i++) {
      elt=jl_box_float64(NUM2DBL(rb_ary_entry(arr,i)));
      jl_arrayset((jl_array_t*)ans,elt,i);
    }

	array_type=jl_apply_array_type((jl_value_t*)jl_long_type, 1);
    ans=(jl_value_t*)jl_alloc_array_1d(array_type,n);
    for(i=0;i<n;i++) {
      elt=jl_box_long(NUM2INT(rb_ary_entry(arr,i)));
      jl_arrayset((jl_array_t*)ans,elt,i);
    }

	array_type=jl_apply_array_type((jl_value_t*)jl_bool_type, 1);
    ans=(jl_value_t*)jl_alloc_array_1d(array_type,n);
    for(i=0;i<n;i++) {
      elt=jl_box_bool(rb_class_of(rb_ary_entry(arr,i))==rb_cFalseClass ? 0 : 1);
      jl_arrayset((jl_array_t*)ans,elt,i);
    }

	array_type=jl_apply_array_type((jl_value_t*)jl_string_type, 1);
    ans=(jl_value_t*)jl_alloc_array_1d(array_type,n);
    for(i=0;i<n;i++) {
      tmp=rb_ary_entry(arr,i);
      elt=jl_cstr_to_string(StringValuePtr(tmp));
      jl_arrayset((jl_array_t*)ans,elt,i);
    }
}

void vj_assign<T>(var string, arr)
{
  jl_value_t* ans;
  char *tmp;

  ans=util_VALUE_to_jl_value(arr);

  tmp = StringValuePtr(name);
  jl_set_global(jl_main_module, jl_symbol(tmp),ans);

  return Qnil;
}
*/
