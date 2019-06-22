
extern crate iron;

use iron::prelude::*;
use iron::status;
use std::env;
use std::string::String;

fn main() {
    fn messenger(_: &mut Request) -> IronResult<Response> {

        let message = match env::var("MESSAGE") {
            Ok(val) => val,
            Err(e) => {
                println!("Couldn't print env var {}: {}", "MESSAGE", e);
                String::from("a Message from somewhere!")
            },
        };

        Ok(Response::with((status::Ok, message)))
    }

    let _server = Iron::new(messenger).http("0.0.0.0:3000").unwrap();
    println!("On 3000");
}
