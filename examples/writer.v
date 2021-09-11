import os
import examples.httpchunkwriter

fn main() {
	mut output := os.stdout()
	mut buf := httpchunkwriter.new(writer: output)
	buf.write('abc'.bytes()) ? // Output: 3\r\nabc\r\n
	buf.close() ? // Output: 0\r\n\r\n
}
