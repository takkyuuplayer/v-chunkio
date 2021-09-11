# v-httpchunkwriter

![CI](https://github.com/takkyuuplayer/v-httpchunkwriter/workflows/CI/badge.svg)

HTTP 1.1 chunk writer

```v
import takkyuuplayer.bytebuf

fn main() {
	mut output := os.stdout()
	mut buf := httpchunkwriter.new(writer: output)
	buf.write('abc'.bytes()) ?  // Output: 3\r\nabc\r\n
	buf.close() ?               // Output: 0\r\n\r\n
}
```
