# v-chunkio

![CI](https://github.com/takkyuuplayer/v-chunkio/workflows/CI/badge.svg)

HTTP 1.1 chunk writer

```v
import takkyuuplayer.chunkio

fn main() {
	mut output := os.stdout()
	mut buf := chunkio.new_writer(writer: output)
	buf.write('abc'.bytes()) ?  // Output: 3\r\nabc\r\n
	buf.close() ?               // Output: 0\r\n\r\n
}
```
