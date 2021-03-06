// Checks that derived implementations of Clone and Debug do not
// contribute to dead code analysis (issue #84647).

#![forbid(dead_code)]

struct A { f: () }
//~^ ERROR: field is never read: `f`

#[derive(Clone)]
struct B { f: () }
//~^ ERROR: field is never read: `f`

#[derive(Debug)]
struct C { f: () }
//~^ ERROR: field is never read: `f`

#[derive(Debug,Clone)]
struct D { f: () }
//~^ ERROR: field is never read: `f`

struct E { f: () }
//~^ ERROR: field is never read: `f`
// Custom impl, still doesn't read f
impl Clone for E {
    fn clone(&self) -> Self {
        Self { f: () }
    }
}

struct F { f: () }
// Custom impl that actually reads f
impl Clone for F {
    fn clone(&self) -> Self {
        Self { f: self.f }
    }
}

fn main() {
    let _ = A { f: () };
    let _ = B { f: () };
    let _ = C { f: () };
    let _ = D { f: () };
    let _ = E { f: () };
    let _ = F { f: () };
}
